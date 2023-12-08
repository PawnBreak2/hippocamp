import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/body/created_post.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/pages/select_categories/select_category_dialog.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:hippocamp/widgets/dialogs/flash_dialog.dart';
import 'package:hippocamp/widgets/images/generic_cached_icon.dart';

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
                          color: Color.fromRGBO(0, 84, 147, 1),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onSelected: (c) async {
                        if (c != "0") return;

                        final response = await ref
                            .read(postListProvider.notifier)
                            .saveTemplate(
                              category.key,
                              createPost,
                            );

                        if (response)
                          FlashCustomDialog.showPopUp(
                            context: context,
                            text:
                                "Questo post è stato salvato come modello predefinito della Categoria \"${category.name}\"",
                            isError: false,
                          );
                        else
                          FlashCustomDialog.showPopUp(
                            context: context,
                            text:
                                "Ops... qualcosa è andato storto, ti preghiamo di riprovare",
                            isError: true,
                          );
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: "0",
                          child: Text("Salva come predefinito"),
                        ),
                      ],
                    ),
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
                        child: Container(
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
                              color: category
                                  .domainBackgroundColorHex.colorFromHex,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Hero(
                                tag: category.key,
                                child: GenericCachedIcon(
                                    imageUrl: category.iconUrl)),
                          ),
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
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: GestureDetector(
                                  onTap: onPartnerTap,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      width: 70,
                                      height: 35,
                                      child: partnerModel == null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: CustomColors
                                                    .primaryLightGreen,
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Partner",
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                ),
                                              ),
                                            )
                                          : SvgPicture.network(
                                              partnerModel!.iconUrl,
                                              fit: BoxFit.contain,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),

                              // Title
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
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
