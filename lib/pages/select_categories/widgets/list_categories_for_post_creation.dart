import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocapp/constants/navigation/routeNames.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/pages/post_creation_and_update/post_creation_and_update_page.dart';
import 'package:hippocapp/providers/posts_management/creation_and_update/post_creation_and_update_provider.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:collection/collection.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/images/generic_cached_icon.dart';

class ListCategoriesForPostCreation extends ConsumerWidget {
  final TextEditingController controller;
  final bool selectNewCategory;
  const ListCategoriesForPostCreation({
    required this.controller,
    required this.selectNewCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDomainKey = ref.watch(
        uiStateProvider.select((state) => state.currentlySelectedDomainKey));
    String selectedDomainName = ref
        .read(appStateProvider)
        .domains
        .firstWhere((element) =>
            element.key ==
            ref.watch(uiStateProvider).currentlySelectedDomainKey)
        .localizedName;
    final categoriesForSelectedDomain = categoriesFilter(
        ref
            .read(appStateProvider)
            .categories
            .where((element) => element.domainKey == selectedDomainKey)
            .toList(),
        ref);
    final uiStateNotifier = ref.read(uiStateProvider.notifier);
    final uiState = ref.watch(uiStateProvider);

    // used to hide the title of the domain when the user searchs in all the categories

    final isSearchingCategories = ref
        .watch(appStateProvider.select((state) => state.isSearchingCategories));
    return Column(
      children: [
        !isSearchingCategories
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Text(
                    selectedDomainName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: categoriesForSelectedDomain.length > 100
                  ? 100
                  : categoriesForSelectedDomain.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, i) {
                return InkWell(
                  onLongPress: () {
                    if (!uiState.isLongPressingCategory) {
                      uiStateNotifier.setIsLongPressingCategory(true);
                      uiStateNotifier.setLongPressedCategoryKey(
                          categoriesForSelectedDomain[i].key);
                    } else {
                      uiStateNotifier.setIsLongPressingCategory(false);
                      uiStateNotifier.setLongPressedCategoryKey('');
                    }
                  },
                  onTap: () {
                    // If is not selecting (long-pressing) a new category, it pushes the post creation/updated page

                    ///TODO: refactor per includere tutto in un unica var?

                    if (!(uiState.isLongPressingCategory &&
                        uiState.longPressedCategoryKey ==
                            categoriesForSelectedDomain[i].key)) {
                      // Sets the current category key in the post creation and update provider

                      ref
                          .read(postCreationAndUpdateProvider.notifier)
                          .setCategoryKey(categoriesForSelectedDomain[i].key);
                      context.pushNamed(
                          routeMap[routeNames.postCreationAndUpdate],
                          extra: categoriesForSelectedDomain[i]);
                    } else {
                      return;
                    }

                    if (!selectNewCategory) {}
                  },
                  child: Container(
                    decoration: (uiState.isLongPressingCategory &&
                            uiState.longPressedCategoryKey ==
                                categoriesForSelectedDomain[i].key)
                        ? const BoxDecoration(
                            color: CustomColors.backgroundGrey,
                          )
                        : null,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: categoriesForSelectedDomain[i]
                                .domainBackgroundColorHex
                                .colorFromHex,
                            border: Border.all(color: Colors.grey),
                          ),
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(
                              left: 12,
                              right: 8,
                              // used to add extra margin to the first element
                              top: (i == 0) ? 12 : 6,
                              bottom: 6),
                          child: Hero(
                            tag: categoriesForSelectedDomain[i].key,
                            child: GenericCachedIcon(
                                imageUrl:
                                    categoriesForSelectedDomain[i].iconUrl),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoriesForSelectedDomain[i].name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              (uiState.isLongPressingCategory &&
                                      uiState.longPressedCategoryKey ==
                                          categoriesForSelectedDomain[i].key)
                                  ? Text('Imposta come preferita',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: CustomColors.primaryRed))
                                  : const SizedBox(height: 0),
                            ],
                          ),
                        ),
                        (uiState.isLongPressingCategory &&
                                uiState.longPressedCategoryKey ==
                                    categoriesForSelectedDomain[i].key)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: const Icon(
                                  Icons.favorite,
                                  color: CustomColors.primaryRed,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, i) =>
                  i == categoriesForSelectedDomain.length
                      ? const SizedBox()
                      : const SizedBox(height: 4),
            ),
          ),
        ),
        SizedBox(
          height: 24,
        )
      ],
    );
  }

  // HELPERS

  /// Works with text controller to filter results based on search.
  ///
  /// The search happens in all categories.
  ///
  /// If the text is empty, it returns all the categories for the selected domain.

  List<PostCategory> categoriesFilter(
      List<PostCategory> categoriesForSelectedDomain, WidgetRef ref) {
    final text = controller.text.toLowerCase();

    if (text.isEmpty) {
      return categoriesForSelectedDomain
          .sorted((a, b) => a.name.compareTo(b.name));
    } else {
      // returns a list of categories that contains the text, in all the categories active and available
      return ref
          .read(appStateProvider)
          .categories
          .where((e) => e.name.toLowerCase().contains(text))
          .toList();
    }
  }
}
