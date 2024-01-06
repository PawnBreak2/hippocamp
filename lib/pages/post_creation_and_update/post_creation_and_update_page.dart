import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocapp/constants/navigation/routeNames.dart';
import 'package:hippocapp/models/posts-creation/post/post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:hippocapp/pages/post_creation_and_update/functions/listeners.dart';
import 'package:hippocapp/pages/post_creation_and_update/utilities/description_icon_enum.dart';
import 'package:hippocapp/pages/post_creation_and_update/views/overlay_dialog_for_attachments.dart';
import 'package:hippocapp/pages/post_creation_and_update/widgets/date_selection_section.dart';
import 'package:hippocapp/pages/post_creation_and_update/widgets/partner_dialog.dart';
import 'package:hippocapp/pages/post_creation_and_update/widgets/text_form_field_button.dart';
import 'package:hippocapp/pages/post_creation_and_update/widgets/top_bar_section.dart';
import 'package:hippocapp/providers/posts_management/creation_and_update/post_creation_and_update_provider.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/providers/ui/isLoading_provider.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';
import 'package:hippocapp/providers/posts_management/support/wallets_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/styles/icons.dart';

import 'package:hippocapp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:hippocapp/widgets/dialogs/flash_dialog.dart';
import 'package:hippocapp/widgets/forms/primary_text_form.dart';

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
  /// Used in the post creation/update phase and when opening a timeline item

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
  late PostCategory _category;
  late List<BusinessPartner> _businessPartners;
  late TextEditingController _titleTextController;
  late TextEditingController _locationTextController;
  late TextEditingController _descriptionTextController;
  late PostCreationAndUpdateNotifier _postCreationAndUpdateNotifier;
  late PostToBeSentToAPI _postCreationAndUpdateState;
  late UIStateNotifier _uiNotifier;
  late AppStateNotifier _appStateNotifier;

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
    _uiNotifier = ref.read(uiStateProvider.notifier);
    _postCreationAndUpdateNotifier =
        ref.read(postCreationAndUpdateProvider.notifier);
    _postCreationAndUpdateState = ref.read(postCreationAndUpdateProvider);
    _appStateNotifier = ref.read(appStateProvider.notifier);

    // Setup controllers for text fields and add listeners

    _category = _appStateNotifier
        .findCategoryByKey(_postCreationAndUpdateState.categoryKey);
    _businessPartners ==
        _appStateNotifier.findBusinessPartnersByKeys(
            _postCreationAndUpdateState.businessPartners);

    super.initState();
    initListeners();
    initPost();
  }

  void initPost() {
    final walletsProviderNotifier = ref.read(walletsProvider.notifier);
    final walletsProviderState = ref.read(walletsProvider);

    if (widget.isUpdatingExistingPost) {
      _titleTextController.text = _postCreationAndUpdateState.title;
      _locationTextController.text = _postCreationAndUpdateState.address;
    } else {
      _titleTextController.text = _category.name;
    }

    if (widget.isCreatingNewPost) return;
  }

  void initListeners() {
    ///TODO: dispose of listeners

    _titleTextController = TextEditingController()
      ..addListener(() {
        titleTextControllerListener(controller: _titleTextController, ref: ref);
      });
    _locationTextController = TextEditingController()..addListener(() {});
    _descriptionTextController = TextEditingController()
      ..addListener(() {
        descriptionTextControllerListener(
            controller: _descriptionTextController, ref: ref);
      });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(isLoadingProvider.notifier).state;
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
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      TopBarSectionForCreatePost(
                        onPartnerTap: () async {
                          final resp =
                              await CustomBottomSheet.showDraggableBottomSheet(
                            context,
                            (controller) =>
                                PartnerDialog(scrollController: controller),
                            appBarColor: CustomColors.pinkWhite,
                          );

                          if (resp is BusinessPartner) {
                            String businessPartnerKey = resp.key;
                            _postCreationAndUpdateNotifier
                                .setBusinessPartners([businessPartnerKey]);
                            setState(() {});
                          }
                        },
                        onSave: () async {
                          if (isLoading) return;

                          // Set loading screen

                          ref
                              .read(isLoadingProvider.notifier)
                              .update((state) => true);

                          bool resp = false;
                          PostToBeSentToAPI postToBeSentToAPI =
                              _postCreationAndUpdateNotifier.state;
                          if (widget.isUpdatingExistingPost) {
                            resp = await ref
                                .read(postListProvider.notifier)
                                .updatePost(
                                    key: widget.post!.key,
                                    postBody: postToBeSentToAPI);
                          } else {
                            resp = await ref
                                .read(postListProvider.notifier)
                                .createPost(
                                  postBody: postToBeSentToAPI,
                                );
                          }

                          // Saving completed, remove loading screen

                          ref
                              .read(isLoadingProvider.notifier)
                              .update((state) => false);

                          if (resp) {
                            FlashCustomDialog.showPopUp(
                              context: context,
                              text: "Post salvato",
                              isError: false,
                            );
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              context
                                  .goNamed(routeMap[routeNames.mainScaffold]);
                            });
                          } else {
                            FlashCustomDialog.showPopUp(
                              context: context,
                              text:
                                  "C'è stato un errore nel salvataggio del post. Riprova più tardi",
                              isError: true,
                            );
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              context.pop();
                            });
                          }
                        },
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
                                textCapitalization:
                                    TextCapitalization.sentences,
                                action: TextInputAction.next,
                              ),
                            ),
                            SizedBox(width: 2.w),

                            // button to show/hide the description field
                            Consumer(
                              builder: (context, ref, child) {
                                final descriptionButtonState = ref.watch(
                                    uiStateProvider.select((state) => state
                                        .descriptionButtonStateInPostCreation));
                                final showDescription = ref.watch(
                                    uiStateProvider.select((value) => value
                                        .showDescriptionFieldInPostCreation));
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
                                          isDescriptionEmpty:
                                              isDescriptionEmpty,
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
                              uiStateProvider.select((value) =>
                                  value.showDescriptionFieldInPostCreation));
                          if (shouldShowDescriptionField) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 4.w,
                                right: 4.w,
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
                                      textCapitalization:
                                          TextCapitalization.sentences,
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
                              onTap: () async {
                                final Uri url = Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=52.32,4.917');

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Location All day / Time
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: DateSelectionSection(
                          isUpdatingPost: widget.isUpdatingExistingPost,
                        ),
                      ),

                      SizedBox(height: 150),

                      // Appbar
                    ],
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => OverlayDialogForAttachments());
          },
          child: Transform.rotate(
              angle: pi / 2,
              alignment: Alignment.center,
              child: Icon(Icons.attach_file)),
        ));
  }
}
