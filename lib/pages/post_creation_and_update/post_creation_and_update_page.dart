import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/helpers/extensions/datetime_extension.dart';
import 'package:hippocamp/helpers/extensions/int_extensions.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/helpers/service/permission_handler.dart';
import 'package:hippocamp/models/body/attachments_for_created_post.dart';
import 'package:hippocamp/models/body/created_post.dart';
import 'package:hippocamp/models/body/multi_party_transaction_for_created_post.dart';
import 'package:hippocamp/models/body/single_party_transaction_for_created_post.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/models/posts-creation/finance_movement_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart' show Post;
import 'package:hippocamp/models/wallets/wallet_model.dart';
import 'package:hippocamp/pages/post_creation_and_update/utilities/description_icon_enum.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/date_selection_section.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/partner_dialog.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/text_form_field_button.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/top_bar_section.dart';
import 'package:hippocamp/pages/select_categories/select_category_dialog.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/post_creation_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/providers/wallets_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/styles/icons.dart';
import 'package:hippocamp/widgets/buttons/delete_x_icon.dart';
import 'package:hippocamp/widgets/dialogs/cupertino_bottom_sheet.dart';
import 'package:hippocamp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:hippocamp/widgets/dialogs/flash_dialog.dart';
import 'package:hippocamp/widgets/forms/primary_text_form.dart';
import 'package:hippocamp/widgets/images/generic_cached_icon.dart';
import 'package:hippocamp/widgets/view/photo_view.dart';
import 'package:image_picker/image_picker.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/posts-creation/partner_model.dart';

class PostCreationAndUpdatePage extends ConsumerStatefulWidget {
  /// Widget used when the user wants to create a new post or update an existing one.
  ///
  /// If the user wants to update an existing post, the [post] parameter must be passed.
  ///
  /// If the user wants to create a new post, the [category] parameter must be passed.
  ///
  /// Used in the post creation phase and when opening a timeline item

  final PostCategory? category;
  final Post? post;
  final bool isCreatingNewPost;
  final bool isUpdatingExistingPost;
  const PostCreationAndUpdatePage._({
    this.category,
    this.post,
  })  : isCreatingNewPost = post == null,
        isUpdatingExistingPost = post != null;

  // Factory constructor for creating a new post
  factory PostCreationAndUpdatePage.createNewPostWithCategory(
      {required PostCategory category}) {
    return PostCreationAndUpdatePage._(category: category);
  }

  // Factory constructor for updating an existing post
  factory PostCreationAndUpdatePage.updatePost({required Post post}) {
    return PostCreationAndUpdatePage._(post: post);
  }

  @override
  ConsumerState<PostCreationAndUpdatePage> createState() =>
      _PostCreationPageState();
}

class _PostCreationPageState extends ConsumerState<PostCreationAndUpdatePage> {
  late PostCategory category;
  late TextEditingController _titleTextController;
  late TextEditingController _locationTextController;
  late TextEditingController _descriptionTextController;
  late PostCreationNotifier _postCreationNotifier;
  PartnerModel? _partnerModel;
  DateTime _dateTime = DateTime.now();
  bool _allDay = true;
  TimeOfDay _timeOfDayFrom = TimeOfDay.now();
  TimeOfDay _timeOfDayTo = TimeOfDay.now();
  late UIStateNotifier uiNotifier;
  final List<Map> _financeMovementListToSave = [];

  final List<Map> _fileAndDocumentsListToSave = [];

  bool _loading = false;

  late final FocusNode _focusNodeTitle = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  late final FocusNode _focusNodeLocation = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  late final FocusNode _focusNodeDescription = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    uiNotifier = ref.read(uiStateProvider.notifier);

    _titleTextController = TextEditingController()
      ..addListener(() {
        // sets the title of the post in the post creation provider state
        _postCreationNotifier.setTitle(_titleTextController.text);
      });
    _locationTextController = TextEditingController()..addListener(() {});
    _descriptionTextController = TextEditingController()
      ..addListener(() {
        // sets the description of the post in the post creation provider state
        _postCreationNotifier.setDescription(_descriptionTextController.text);
        if (_descriptionTextController.text.isNotEmpty) {
          uiNotifier.updateDescriptionButtonState(
              isDescriptionEmpty: false,
              showDescription: true,
              isFromListener: true);
        } else {
          uiNotifier.updateDescriptionButtonState(
              isDescriptionEmpty: true,
              showDescription: true,
              isFromListener: true);
        }
      });
    _postCreationNotifier = ref.read(postCreationProvider.notifier);
    super.initState();
    initPost();
  }

  void initPost() {
    final walletsProviderNotifier = ref.read(walletsProvider.notifier);
    final walletsProviderState = ref.read(walletsProvider);

    category = widget.category ??
        PostCategory.fromCategoryModel(widget.post!.category);
    _titleTextController.text = category.name;

    if (widget.post == null) return;

    if (widget.post!.businessPartners.isNotEmpty)
      _partnerModel =
          PartnerModel.fromPostPartner(widget.post!.businessPartners.first);

    _titleTextController.text = widget.post!.title;
    _locationTextController.text = widget.post!.address;

    _dateTime = widget.post!.dateTimeFromString;

    _allDay = widget.post!.wholeDay;
    _timeOfDayFrom = widget.post!.from.timeOfDayFromString;
    _timeOfDayTo = widget.post!.to.timeOfDayFromString;

    for (var i in widget.post!.singlePartyTransactions) {
      final firstWallet =
          walletsProviderNotifier.getWalletByWalletKey(i.wallet);

      _financeMovementListToSave.add(
        FinanceMovementModel(
          wallet: firstWallet,
          inOrOut: i.type != "OUTFLOW",
          value: i.amount.toString(),
        ).toJsonStandard(),
      );
    }

    if (widget.post!.multiPartyTransaction != null) {
      final trx = widget.post!.multiPartyTransaction!;
      final fromWallet =
          walletsProviderNotifier.getWalletByWalletKey(trx.fromWallet);
      final toWallet =
          walletsProviderNotifier.getWalletByWalletKey(trx.toWallet);

      _financeMovementListToSave.add(
        FinanceMovementModel(
          typeNotStandard: trx.type,
          typeWalletFROM: fromWallet,
          typeWalletTO: toWallet,
          value: trx.amountIn.toString(),
          valueEntered: trx.amountOut == 0 ? null : trx.amountOut.toString(),
        ).toJsonNotStandard(),
      );
    }
  }

  NewCreatedPost postModelToCreate(
      {List<Map<String, dynamic>> attachments = const []}) {
    List<SinglePartyTransactionForCreatedPost>? _singleTrxs;
    MultiPartyTransactionForCreatedPost? _multiTrxs;

    if (_financeMovementListToSave.isNotEmpty) {
      for (var i in _financeMovementListToSave) {
        final amountValue =
            i["value"].toString().replaceAll(".", "").replaceAll(",", ".");
        final secondAmountValue = i["valueEntered"]
            .toString()
            .replaceAll(".", "")
            .replaceAll(",", ".");

        if (i["typeNotStandard"] == null) {
          _singleTrxs ??= [];

          _singleTrxs.add(
            SinglePartyTransactionForCreatedPost(
              amount: double.tryParse(amountValue) ?? 0,
              date: _dateTime.toUtc().toIso8601String(),
              type: i["inOrOut"] ? "INFLOW" : "OUTFLOW",
              walletKey: i["wallet"].key,
            ),
          );
        } else {
          _multiTrxs ??= MultiPartyTransactionForCreatedPost(
            date: _dateTime.toUtc().toIso8601String(),
            type: category.type,
            categoryKey: category.key,
            fromWalletKey: i["walletFROM"].key,
            toWalletKey: i["walletTO"].key,
            amountIn: double.tryParse(amountValue) ?? 0,
            amountOut: double.tryParse(secondAmountValue) ?? 0,
          );
        }
      }
    }

    return NewCreatedPost(
      title: _titleTextController.text,
      description: "",
      categoryKey: category.key,
      contacts: [],
      businessPartners: _partnerModel == null ? [] : [_partnerModel!.key],
      latitude: "",
      longitude: "",
      address: _locationTextController.text,
      important: false,
      canceled: false,
      uncertain: false,
      sensitiveInfo: false,
      type: "STANDARD",
      visualization: "",
      rating: "",
      from: _allDay ? "" : _timeOfDayFrom.timeToString,
      to: _allDay ? "" : _timeOfDayTo.timeToString,
      interval: "EXACT",
      date: _dateTime.dateToString,
      at: _allDay ? "" : _timeOfDayFrom.timeToString,
      within: _allDay ? "" : _timeOfDayTo.timeToString,
      morning: false,
      afternoon: false,
      evening: false,
      wholeDay: _allDay,
      attachments:
          attachments.map((e) => AttachmentForCreatedPost.fromJson(e)).toList(),
      notificationsActive: false,
      notificationsUnit: "",
      singlePartyTransactions: _singleTrxs,
      multiPartyTransaction: _multiTrxs,
      businessPartnerBranch: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundGrey,
        elevation: 0,
        leading: Container(),
        toolbarHeight: 10,
        shadowColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBarSectionForCreatePost(
                onCategoryTap: (c) async {
                  if (c == null) return;
                  category = c;

                  if (widget.post == null)
                    _titleTextController.text = category.name;
                  setState(() {});
                },
                onPartnerTap: () async {
                  final resp = await CustomBottomSheet.showDraggableBottomSheet(
                    context,
                    (controller) => PartnerDialog(scrollController: controller),
                    appBarColor: CustomColors.pinkWhite,
                  );

                  if (resp is PartnerModel) {
                    _partnerModel = resp;
                    setState(() {});
                  }
                },
                onSave: () async {
                  if (_loading) return;

                  _loading = true;
                  setState(() {});

                  List<Map<String, dynamic>> attachmentsToAdd = [];

                  for (var i in _fileAndDocumentsListToSave)
                    attachmentsToAdd.add({
                      "localizedName": (i["attachment"] as AttachmentType).name,
                      "type": (i["attachment"] as AttachmentType).key,
                      "content": "", //base64Encode(i["value"])
                      "contentType": "application/pdf",
                    });

                  bool resp = false;

                  if (widget.post != null) {
                    resp = await ref.read(postListProvider.notifier).updatePost(
                          key: widget.post?.key ?? "",
                          postBody:
                              postModelToCreate(attachments: attachmentsToAdd),
                        );
                  } else {
                    resp = await ref.read(postListProvider.notifier).createPost(
                          postBody:
                              postModelToCreate(attachments: attachmentsToAdd),
                        );
                  }

                  _loading = false;
                  setState(() {});

                  if (resp) {
                    FlashCustomDialog.showPopUp(
                      context: context,
                      text: "Post salvato",
                      isError: false,
                    );
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      context.goNamed(routeMap[routeNames.mainScaffold]);
                    });
                  } else {
                    FlashCustomDialog.showPopUp(
                      context: context,
                      text:
                          "Ops... qualcosa è andato storto, riprova più tardi",
                      isError: true,
                    );
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      context.pop();
                    });
                  }
                },
                createPost: postModelToCreate(),
                category: category,
                partnerModel: _partnerModel,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryTextFormField(
                        controller: _titleTextController,
                        focusNode: _focusNodeTitle,
                        hintText: "Titolo",
                        textCapitalization: TextCapitalization.sentences,
                        action: TextInputAction.next,
                      ),
                    ),
                    SizedBox(width: 2.w),

                    // button to show/hide the description field
                    Consumer(
                      builder: (context, ref, child) {
                        final descriptionButtonState = ref.watch(
                            uiStateProvider.select((state) =>
                                state.descriptionButtonStateInPostCreation));
                        final showDescription = ref.watch(
                            uiStateProvider.select((value) =>
                                value.showDescriptionFieldInPostCreation));
                        final isDescriptionEmpty =
                            _descriptionTextController.text.isEmpty;

                        return InkWell(
                          child: TextFormFieldButton(
                            child: insertDescriptionButtonStateMap[
                                descriptionButtonState]!,
                          ),
                          onTap: () {
                            ref
                                .read(uiStateProvider.notifier)
                                .updateDescriptionButtonState(
                                  isDescriptionEmpty: isDescriptionEmpty,
                                  showDescription: showDescription,
                                );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),

              // description field

              Consumer(
                builder: (context, ref, child) {
                  final shouldShowDescriptionField = ref.watch(
                      uiStateProvider.select(
                          (value) => value.showDescriptionFieldInPostCreation));
                  if (shouldShowDescriptionField) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                        top: 1.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryTextFormField(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              maxLines: 5,
                              controller: _descriptionTextController,
                              focusNode: _focusNodeDescription,
                              hintText: "Descrizione",
                              textCapitalization: TextCapitalization.sentences,
                              action: TextInputAction.next,
                              onChange: (_) => setState(() {}),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(height: 1.h),
              // Location
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PrimaryTextFormField(
                        controller: _locationTextController,
                        focusNode: _focusNodeLocation,
                        hintText: "Indirizzo / Posizione",
                        action: TextInputAction.next,
                        onChange: (_) => setState(() {}),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    InkWell(
                      child: TextFormFieldButton(
                          child: Icon(CustomMaterialIcons.gpsLocation)),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              // Location All day / Time
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: DateSelectionSection(
                  allDaySelected: _allDay,
                  onTapTimeSelection: (c) async {
                    _allDay = c == "0";
                    setState(() {});
                  },
                  timeFrom: TextEditingController(
                    text: _timeOfDayFrom.timeToString,
                  ),
                  onTapTimeFrom: () async {
                    final timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: _timeOfDayFrom,
                    );
                    _timeOfDayFrom = timeOfDay ?? _timeOfDayFrom;

                    if (_timeOfDayFrom.hour > _timeOfDayTo.hour ||
                        (_timeOfDayFrom.hour == _timeOfDayTo.hour &&
                            _timeOfDayFrom.minute > _timeOfDayTo.minute))
                      _timeOfDayTo = _timeOfDayFrom;

                    setState(() {});
                  },
                  timeTo: TextEditingController(
                    text: _timeOfDayTo.timeToString,
                  ),
                  onTapTimeTo: () async {
                    final timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: _timeOfDayTo,
                    );

                    if (timeOfDay == null) return;

                    _timeOfDayTo = timeOfDay;
                    setState(() {});
                  },
                  onTapDateSelection: () async {
                    final dateTime = await showDatePicker(
                      context: context,
                      initialDate: _dateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                    );
                    _dateTime = dateTime ?? _dateTime;
                    setState(() {});
                  },
                  controllerDate: TextEditingController(
                    text:
                        "${_dateTime.day} ${_dateTime.month.monthFromInt.substring(0, 3).toLowerCase()} ${_dateTime.year}",
                  ),
                  setChange: (_) => setState(() {}),
                ),
              ),

              // Finance Movements
              if (_financeMovementListToSave.isNotEmpty)
                ListView.separated(
                  itemCount: _financeMovementListToSave.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 16),
                  separatorBuilder: (_, __) => SizedBox(height: 28),
                  itemBuilder: (_, i) {
                    final _financeToSave = _financeMovementListToSave[i];
                    final typeFinance = _financeToSave["typeNotStandard"];
                    final typeMovement = _financeToSave[
                        typeFinance != null ? "walletFROM" : "wallet"];

                    return FinanceMovementItem(
                      typeFinance: typeFinance,
                      typeMovement: typeMovement,
                      typeMovementSecond: _financeToSave["walletTO"],
                      isInOrOut: _financeToSave["inOrOut"] ?? false,
                      value: _financeToSave["value"] ?? "",
                      valueSecond: _financeToSave["valueEntered"],
                      onValueChange: (s) {
                        _financeToSave["value"] = s;
                        setState(() {});
                      },
                      onSecondValueChange: (s) {
                        _financeToSave["valueEntered"] = s;
                        setState(() {});
                      },
                      onTypeTap: (s) {
                        _financeToSave[
                            typeFinance != null ? "walletFROM" : "wallet"] = s;
                        setState(() {});
                      },
                      onSecondTypeTap: (s) {
                        _financeToSave["walletTO"] = s;
                        setState(() {});
                      },
                      onInOrOutTap: (v) {
                        _financeToSave["inOrOut"] = v;
                        setState(() {});
                      },
                      onDelete: () async {
                        // Update list values
                        final cacheItems =
                            _financeMovementListToSave.map((e) => e).toList();
                        cacheItems.removeAt(i);

                        _financeMovementListToSave.clear();
                        setState(() {});

                        await Future.delayed(Duration(milliseconds: 100));

                        _financeMovementListToSave.addAll(cacheItems);
                        setState(() {});
                      },
                    );
                  },
                ),

              // File & Documents
              ListView.separated(
                itemCount: _fileAndDocumentsListToSave.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 16),
                separatorBuilder: (_, __) => SizedBox(height: 28),
                itemBuilder: (_, i) {
                  final _fileToSave = _fileAndDocumentsListToSave[i];

                  return _DocumentItem(
                    attachmentType: _fileToSave["attachment"],
                    onTypeTap: (s) {
                      _fileToSave["attachment"] = s;
                      setState(() {});
                    },
                    value: _fileToSave["value"],
                    onValueChange: (s) {
                      _fileToSave["value"] = s;
                      setState(() {});
                    },
                    onDelete: () async {
                      // Update list values
                      final cacheItems =
                          _fileAndDocumentsListToSave.map((e) => e).toList();
                      cacheItems.removeAt(i);

                      _fileAndDocumentsListToSave.clear();
                      setState(() {});

                      await Future.delayed(Duration(milliseconds: 100));

                      _fileAndDocumentsListToSave.addAll(cacheItems);
                      setState(() {});
                    },
                  );
                },
              ),

              SizedBox(height: 150),

              // Appbar
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: CustomColors.primaryYellow,
        overlayColor: Colors.black12,
        children: [
          // Movimenti di finanza
          if (Constants.typeFinanceMovement[category.name] == null ||
              (Constants.typeFinanceMovement[category.name] != null &&
                  _financeMovementListToSave.isEmpty))
            SpeedDialChild(
              backgroundColor: Colors.white,
              labelWidget: Text(
                "Entrate / Uscite ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.pie_chart,
                color: CustomColors.primaryGrey,
              ),
              onTap: addFinancesMovement,
            ),

          // File e Documenti
          SpeedDialChild(
            backgroundColor: Colors.white,
            labelWidget: Text(
              "File e Documenti ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Icon(
              Icons.file_copy,
              color: CustomColors.primaryGrey,
            ),
            onTap: uploadDocuments,
          ),
        ],
        activeChild: Icon(Icons.cancel),
        buttonSize: Size(60, 60),
        child: Icon(
          Icons.attach_file,
          size: 24,
        ),
      ),
    );
  }

  Future<void> addFinancesMovement() async {
    final id = Constants.typeFinanceMovement[category.name];
    int? resp;

    if (id == null) {
      resp = await CustomCupertinoDialogs.showCupertinoBottomSheet(
        context: context,
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 1);
            },
            child: Text('Entrata'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 2);
            },
            child: Text('Uscita'),
          ),
        ],
        lastButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancella'),
        ),
      );

      if (resp == null) return;
    }

    final firstWallet =
        ref.read(walletsProvider.notifier).getWalletById(TypeWallets.contante);

    if (id == null)
      _financeMovementListToSave.add(
        FinanceMovementModel(
          wallet: firstWallet,
          inOrOut: resp == 1,
        ).toJsonStandard(),
      );
    else
      _financeMovementListToSave.add(
        FinanceMovementModel.notStandardMovement(id, ref).toJsonNotStandard(),
      );

    setState(() {});
  }

  Future<void> uploadDocuments() async {
    // Choose type document
    final resp = await CustomCupertinoDialogs.showCupertinoBottomSheet(
      context: context,
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, 1);
          },
          child: Text('Fotocamera'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, 2);
          },
          child: Text('Carica immagine da galleria'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, 3);
          },
          child: Text('Carica file'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, 4);
          },
          child: Text('Carica link'),
        ),
      ],
      lastButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancella'),
      ),
    );

    if (resp == null) return;

    // Ask permissions
    bool hasPermissions = false;

    dynamic value;

    switch (resp) {
      case 1:
        hasPermissions = await PermissionHandler.askPermissions(
          permission: Permission.camera,
          context: context,
        );
        if (!hasPermissions) break;

        value = await initCameraAndPickImage();
        break;
      case 2:
        if (Platform.isAndroid) {
          final androidInfo = await DeviceInfoPlugin().androidInfo;
          if (androidInfo.version.sdkInt <= 32)
            hasPermissions = await PermissionHandler.askPermissions(
              permission: Permission.storage,
              context: context,
            );
          else
            hasPermissions = await PermissionHandler.askPermissions(
              permission: Permission.photos,
              context: context,
            );
        } else
          hasPermissions = await PermissionHandler.askPermissions(
            permission: Permission.photos,
            context: context,
          );

        if (!hasPermissions) break;

        final resp = await _pickMultipleImage();
        List<Uint8List?> images = [];
        for (var i in resp) {
          final img = await i?.readAsBytes();
          images.add(img);
        }
        value = images;
        break;
      case 3:
        hasPermissions = await PermissionHandler.askPermissions(
          permission: Permission.storage,
          context: context,
        );
        if (!hasPermissions) break;

        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          final file = File(result.files.single.path ?? "");
          value = file;
        }

        break;
      case 4:
        hasPermissions = true;
        value = "";
        break;
    }
    if (value == null) return;

    if (hasPermissions) {
      final firstAttachmentType =
          ref.read(appStateProvider).attachmentTypes.first;

      _fileAndDocumentsListToSave.add(
        {
          "attachment": firstAttachmentType,
          "value": value,
          "typeAttachmentValue": resp,
        },
      );

      setState(() {});
    }
  }

  Future<Uint8List?> initCameraAndPickImage() async {
    final cameras = await availableCameras();

    final controller = CameraController(
      cameras[1],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller.initialize();
    final image = await _pickImage();

    return await image?.readAsBytes();
  }

  Future<XFile?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    return await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      requestFullMetadata: false,
    );
  }

  Future<List<XFile?>> _pickMultipleImage() async {
    final ImagePicker _picker = ImagePicker();

    return await _picker.pickMultiImage(
      requestFullMetadata: false,
    );
  }
}

class FinanceMovementItem extends ConsumerStatefulWidget {
  final String? typeFinance;
  final Wallet typeMovement;
  final Wallet? typeMovementSecond;
  final bool isInOrOut;
  final String value;
  final String? valueSecond;
  final void Function(String) onSecondValueChange;
  final void Function(String) onValueChange;
  final void Function(Wallet) onTypeTap;
  final void Function(Wallet) onSecondTypeTap;
  final void Function(bool) onInOrOutTap;
  final VoidCallback onDelete;
  const FinanceMovementItem({
    this.typeFinance,
    this.valueSecond,
    this.typeMovementSecond,
    required this.onSecondValueChange,
    required this.onSecondTypeTap,
    required this.typeMovement,
    required this.isInOrOut,
    required this.value,
    required this.onValueChange,
    required this.onTypeTap,
    required this.onInOrOutTap,
    required this.onDelete,
  });

  @override
  ConsumerState<FinanceMovementItem> createState() =>
      _FinanceMovementItemState();
}

class _FinanceMovementItemState extends ConsumerState<FinanceMovementItem> {
  late final _textFieldFocus = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerSecondValue = TextEditingController();

  late Wallet typeMovement = widget.typeMovement;
  late Wallet? typeMovementSecond = widget.typeMovementSecond;
  late bool isInOrOut = widget.isInOrOut;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
    _controller.addListener(() {
      widget.onValueChange(_controller.text);
    });

    if (widget.valueSecond != null) {
      _controllerSecondValue.text = widget.valueSecond!;

      _controllerSecondValue.addListener(() {
        widget.onSecondValueChange(_controllerSecondValue.text);
      });
    }
  }

  List<DropdownMenuItem> itemsPerDropDown({bool fistDropDown = true}) {
    print(widget.typeFinance);

    final walletsPerType =
        ref.read(walletsProvider.notifier).getWalletsPerFinanceType(
              widget.typeFinance,
              fistDropDown: fistDropDown,
            );

    print(walletsPerType);

    return walletsPerType
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e.name),
          ),
        )
        .toList();
  }

  Widget dropDownFirst() {
    final items = itemsPerDropDown();

    return Row(
      children: [
        SvgPicture.network(
          typeMovement.walletTypeIconUrl,
          width: 30,
          height: 30,
          placeholderBuilder: (_) => Center(
            child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: items,
                      iconEnabledColor: Colors.transparent,
                      iconDisabledColor: Colors.transparent,
                      value: typeMovement,
                      onChanged: (v) {
                        if (v == null) return;

                        typeMovement = v;
                        widget.onTypeTap(v);
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dropDownSecond() {
    final items = itemsPerDropDown(fistDropDown: false);

    return Row(
      children: [
        SvgPicture.network(
          typeMovementSecond?.walletTypeIconUrl ?? "",
          width: 30,
          height: 30,
          placeholderBuilder: (_) => Center(
            child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: items,
                      iconEnabledColor: Colors.transparent,
                      iconDisabledColor: Colors.transparent,
                      value: typeMovementSecond,
                      onChanged: (v) {
                        if (v == null) return;

                        typeMovementSecond = v;
                        widget.onSecondTypeTap(v);
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            // Entrata / Uscita / Oper.
            InkWell(
              child: SizedBox(
                width: 50,
                child: Column(
                  children: [
                    SvgPicture.network(
                      "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/finanza/finanza-infotype.svg",
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "FIN",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),

            // Card
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.primaryLightGreen,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    // First dropdown
                    Row(
                      children: [
                        Expanded(child: dropDownFirst()),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isInOrOut ? Colors.green : Colors.red,
                          ),
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            isInOrOut ? Icons.add : Icons.remove,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    if (widget.valueSecond != null)
                      // Import value
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Text(
                              "Importo",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: SizedBox(
                                height: 30,
                                child: PrimaryTextFormField(
                                  focusNode: _textFieldFocus,
                                  controller: _controller,
                                  borderRadius: 12,
                                  textAlign: TextAlign.end,
                                  amountFormat: true,
                                  textInputType:
                                      TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  onChange: (_) {
                                    setState(() {});
                                  },
                                  hintText: "0,00",
                                  padding: EdgeInsets.only(left: 12, right: 34),
                                  suffix: Container(
                                    width: 24,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      typeMovement.currencySymbol,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  action: TextInputAction.done,
                                ),
                              ),
                            ),
                            SizedBox(width: 35, height: 1),
                          ],
                        ),
                      ),

                    SizedBox(height: 8),

                    // Second dropdown
                    if (widget.typeFinance != null)
                      Row(
                        children: [
                          Expanded(child: dropDownSecond()),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: !isInOrOut ? Colors.green : Colors.red,
                            ),
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              !isInOrOut ? Icons.add : Icons.remove,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 12),

                    // Import value
                    widget.valueSecond == null
                        ? Row(
                            children: [
                              Text(
                                "Importo",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: SizedBox(
                                  height: 30,
                                  child: PrimaryTextFormField(
                                    controller: _controller,
                                    focusNode: _textFieldFocus,
                                    textAlign: TextAlign.end,
                                    amountFormat: true,
                                    borderRadius: 12,
                                    textInputType:
                                        TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    hintText: "0,00",
                                    onChange: (_) {
                                      setState(() {});
                                    },
                                    padding:
                                        EdgeInsets.only(left: 12, right: 34),
                                    suffix: Container(
                                      width: 24,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(right: 8),
                                      child: Text(
                                        typeMovement.currencySymbol,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    action: TextInputAction.done,
                                  ),
                                ),
                              ),
                              SizedBox(width: 35, height: 1)
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                "Importo",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: PrimaryTextFormField(
                                    controller: _controllerSecondValue,
                                    borderRadius: 12,
                                    amountFormat: true,
                                    textInputType:
                                        TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    textAlign: TextAlign.end,
                                    hintText: "0,00",
                                    onChange: (_) {
                                      setState(() {});
                                    },
                                    padding:
                                        EdgeInsets.only(left: 12, right: 34),
                                    suffix: Container(
                                      width: 24,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(right: 8),
                                      child: Text(
                                        typeMovementSecond?.currencySymbol ??
                                            "€",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    action: TextInputAction.done,
                                  ),
                                ),
                              ),
                              SizedBox(width: 35, height: 1)
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Delete
        DeleteXIcon(
          alignment: Alignment(
            1.05,
            widget.typeFinance != null ? -1.4 : -1.6,
          ),
          onTap: widget.onDelete,
        ),
      ],
    );
  }
}

class _DocumentItem extends ConsumerStatefulWidget {
  final AttachmentType attachmentType;
  final dynamic value;
  final void Function(AttachmentType) onTypeTap;
  final void Function(String) onValueChange;
  final VoidCallback onDelete;
  const _DocumentItem({
    required this.attachmentType,
    required this.value,
    required this.onTypeTap,
    required this.onValueChange,
    required this.onDelete,
  });

  @override
  ConsumerState<_DocumentItem> createState() => __DocumentItemState();
}

class __DocumentItemState extends ConsumerState<_DocumentItem> {
  late final FocusNode _focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  final TextEditingController _controller = TextEditingController();
  late AttachmentType typeMovement = widget.attachmentType;
  List<Uint8List?>? galleryImages;
  Uint8List? imageUploaded;
  File? fileUploaded;

  @override
  void initState() {
    super.initState();

    if (widget.value is String) {
      _controller.text = widget.value;
      _controller.addListener(() {
        widget.onValueChange(_controller.text);
      });
    } else if (widget.value is Uint8List)
      imageUploaded = widget.value;
    else if (widget.value is List<Uint8List?>)
      galleryImages = widget.value;
    else if (widget.value is File) fileUploaded = widget.value;
  }

  List<DropdownMenuItem> get items {
    return ref
        .read(appStateProvider)
        .attachmentTypes
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.name),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            InkWell(
              child: SizedBox(
                width: 50,
                child: Column(
                  children: [
                    SvgPicture.network(
                      "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/documenti/documenti-infotype.svg",
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "DOC",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),

            // CARD
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.primaryLightGreen,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // First dropdown
                    Row(
                      children: [
                        SvgPicture.network(
                          typeMovement.iconUrl,
                          width: 30,
                          height: 30,
                          placeholderBuilder: (_) => Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: EdgeInsets.all(8),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      items: items,
                                      iconEnabledColor: Colors.transparent,
                                      iconDisabledColor: Colors.transparent,
                                      value: typeMovement,
                                      onChanged: (v) {
                                        if (v == null) return;

                                        typeMovement = v;
                                        widget.onTypeTap(v);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Upload value
                    _getRightContentToDisplay(),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Delete
        DeleteXIcon(
          alignment: Alignment(
            1.05,
            imageUploaded != null
                ? -1.25
                : galleryImages != null
                    ? -1.25
                    : -1.4,
          ),
          onTap: widget.onDelete,
        ),
      ],
    );
  }

  Widget _getRightContentToDisplay() {
    if (imageUploaded != null)
      return InkWell(
        onTap: () => CustomBottomSheet.showDraggableBottomSheet(
          context,
          (controller) => PhotoView(
            photos: [imageUploaded],
          ),
          appBarColor: Colors.black54,
          showCloserIcon: false,
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 1,
          touchToClose: true,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: MemoryImage(imageUploaded!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );

    if (galleryImages != null) {
      if (galleryImages!.length == 1)
        return InkWell(
          onTap: () => CustomBottomSheet.showDraggableBottomSheet(
            context,
            (controller) => PhotoView(
              photos: [galleryImages!.first],
            ),
            appBarColor: Colors.black54,
            showCloserIcon: false,
            initialChildSize: 1,
            maxChildSize: 1,
            minChildSize: 1,
            touchToClose: true,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: MemoryImage(galleryImages!.first!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );

      return SizedBox(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 120,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (_, i) {
            final isLastOneAndThereIsMore = i == 3 && galleryImages!.length > 4;

            return InkWell(
              onTap: () => CustomBottomSheet.showDraggableBottomSheet(
                context,
                (controller) => PhotoView(
                  photos: galleryImages ?? [],
                  indexStart: i,
                ),
                appBarColor: Colors.black54,
                showCloserIcon: false,
                initialChildSize: 1,
                maxChildSize: 1,
                minChildSize: 1,
                touchToClose: true,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: MemoryImage(galleryImages![i]!),
                      fit: BoxFit.cover,
                      opacity: isLastOneAndThereIsMore ? .3 : 1,
                    ),
                    color: isLastOneAndThereIsMore ? Colors.black87 : null,
                  ),
                  child: isLastOneAndThereIsMore
                      ? Center(
                          child: Text(
                            "+${galleryImages!.length - 4}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            );
          },
          itemCount: galleryImages!.length > 4 ? 4 : galleryImages!.length,
        ),
      );
    }

    if (fileUploaded != null)
      return Row(
        children: [
          Icon(
            Icons.file_copy_sharp,
            size: 30,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 14,
              ),
              child: Text(
                fileUploaded!.path.nameOfFile,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.link,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: PrimaryTextFormField(
                    focusNode: _focusNode,
                    controller: _controller,
                    hintText: "Link",
                    textInputType: TextInputType.url,
                    action: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
