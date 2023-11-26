import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/pages/posts-creation/post_creation_page.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:collection/collection.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/images/generic_cached_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    final categories = categoriesFilter(ref
        .watch(appStateProvider)
        .categories
        .where((element) => element.domainKey == selectedDomainKey)
        .toList());
    return ListView.separated(
      shrinkWrap: true,
      itemCount: categories.length > 100 ? 100 : categories.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PostCreationPage(
                category: categories[i],
              ),
            ));

            if (!selectNewCategory) {}
          },
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: categories[i].domainBackgroundColorHex.colorFromHex,
                  border: Border.all(color: Colors.grey),
                ),
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(
                    left: 16, right: 8, top: 4, bottom: 4),
                child: GenericCachedIcon(imageUrl: categories[i].iconUrl),
              ),
              Expanded(
                child: Text(
                  categories[i].name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) =>
          i == categories.length ? const SizedBox() : const SizedBox(height: 4),
    );
  }

  // HELPERS

  List<PostCategory> categoriesFilter(List<PostCategory> categories) {
    final text = controller.text.toLowerCase();

    if (text.isEmpty)
      return categories.sorted((a, b) => a.name.compareTo(b.name));

    return categories
        .where((e) => e.name.toLowerCase().contains(text))
        .toList();
  }
}
