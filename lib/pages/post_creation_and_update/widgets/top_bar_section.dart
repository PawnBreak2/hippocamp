import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/body/created_post.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/important_icon_overlay.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/top_bar_widgets/alert_dialog_for_post_attributes.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/top_bar_widgets/top_bar_partner_button.dart';
import 'package:hippocamp/pages/post_creation_and_update/widgets/top_bar_widgets/top_bar_post_detail_icon.dart';
import 'package:hippocamp/pages/select_categories/select_category_dialog.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/post_creation_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/styles/icons.dart';
import 'package:hippocamp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:hippocamp/widgets/dialogs/flash_dialog.dart';
import 'package:hippocamp/widgets/images/generic_cached_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TopBarSectionForCreatePost extends ConsumerWidget {
  final NewCreatedPost createPost;
  final PostCategory category;
  final void Function(PostCategory?) onCategoryTap;
  final void Function()? onPartnerTap;
  final void Function() onSave;
  final PartnerModel? partnerModel;

  const TopBarSectionForCreatePost({
    required this.createPost,
    required this.category,
    required this.onCategoryTap,
    required this.onPartnerTap,
    required this.onSave,
    required this.partnerModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      height: 100,
      child: Stack(
        children: [
          // Setting app bar fixed
          // Container with options
          Container(
            color: CustomColors.backgroundGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Last buttons
                Row(
                  children: [
                    TextButton(
                      onPressed: onSave,
                      child: Text(
                        "Salva",
                        style: TextStyle(
                          color: CustomColors.grey66,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SpeedDial(
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      activeBackgroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      overlayColor: Colors.black12,
                      direction: SpeedDialDirection.down,
                      children: [
                        SpeedDialChild(
                          shape: const CircleBorder(),
                          child: Icon(
                            CustomMaterialIcons.attributes,
                            size: 20,
                            color: Colors.white,
                          ),
                          backgroundColor: CustomColors.primaryRed,
                          label: "Attributi del post",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: CustomColors.darkGrey,
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialogForPostAttributes();
                                });
                          },
                        ),
                        SpeedDialChild(
                          shape: CircleBorder(),
                          child: Icon(
                            CustomMaterialIcons.save,
                            size: 20,
                            color: Colors.white,
                          ),
                          backgroundColor: CustomColors.primaryRed,
                          label: "Salva come predefinito",
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: CustomColors.darkGrey,
                          ),
                          onTap: onSave,
                        ),
                      ],
                    ),
                    SizedBox(width: 2.w)
                  ],
                ),
              ],
            ),
          ),

          // All data
          Padding(
            padding: EdgeInsets.only(left: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arrow back
                IconButton(
                  onPressed: () => context.canPop()
                      ? context.pop()
                      : context.pushReplacementNamed(
                          routeMap[routeNames.mainScaffold]),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 26,
                  ),
                ),

                // Image + other
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image circle
                      InkWell(
                        onTap: () {
                          CustomBottomSheet.showDraggableBottomSheet(
                            context,
                            (controller) => SelectCategoriesDialog(
                              scrollController: controller,
                              selectNewCategory: true,
                            ),
                          ).whenComplete(() {
                            // to reset selected domain after user opens and closes the bottom sheet to select categories

                            if (context.mounted) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                ref
                                    .read(uiStateProvider.notifier)
                                    .setSelectedDomainKey(ref
                                        .read(appStateProvider)
                                        .domains[0]
                                        .key);
                              });
                            }
                          });

                          onCategoryTap(category);
                        },
                        child: Stack(
                          children: [
                            CategoryIcon(category: category),
                            // this is the important icon, to be activated only for important posts
                            Container(
                              width: 100,
                              height: 100,
                              child: Align(
                                alignment: Alignment(0.7, -0.7),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    bool isImportant = ref.watch(
                                        postCreationProvider.select(
                                            (value) => value.important));
                                    return Visibility(
                                      visible: isImportant,
                                      child: child!,
                                    );
                                  },
                                  child: ImportantIconOverlay(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Partner + title
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Partner upload
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // partner button & field
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: GestureDetector(
                                      onTap: onPartnerTap,
                                      child: TopBarPartnerButton(
                                          partnerModel: partnerModel),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  // tentative icon
                                  Consumer(
                                    builder: (context, ref, child) {
                                      bool isUncertain = ref.watch(
                                          postCreationProvider.select(
                                              (value) => value.uncertain));
                                      return Visibility(
                                        visible: isUncertain,
                                        child: child!,
                                      );
                                    },
                                    child: AppBarPostDetailIcon(
                                        icon: CustomMaterialIcons.uncertain),
                                  ),
                                  SizedBox(width: 12),
                                  // sensitive icon
                                  Consumer(
                                      builder: (context, ref, child) {
                                        bool isSensitive = ref.watch(
                                            postCreationProvider.select(
                                                (value) =>
                                                    value.sensitiveInfo));

                                        return Visibility(
                                          visible: isSensitive,
                                          child: child!,
                                        );
                                      },
                                      child: AppBarPostDetailIcon(
                                          icon: CustomMaterialIcons.sensitive)),
                                ],
                              ),
                              SizedBox(height: 12),

                              // Title
                              Row(
                                children: [
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 0.5.h),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      bool isSpot = ref.watch(
                                          postCreationProvider.select((value) =>
                                              value.visualization ==
                                              visualizationTypeMap[
                                                  VisualizationType.spot]));
                                      return Icon(
                                        isSpot
                                            ? CustomMaterialIcons.spot
                                            : CustomMaterialIcons.slot,
                                        color: CustomColors.primaryRed,
                                        size: 20,
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.category,
  });

  final PostCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 12,
        ),
      ),
      width: 100,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: category.domainBackgroundColorHex.colorFromHex,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 3,
              blurRadius: 5,
              color: Colors.black12,
            ),
          ],
        ),
        child: GenericCachedIcon(imageUrl: category.iconUrl),
      ),
    );
  }
}
