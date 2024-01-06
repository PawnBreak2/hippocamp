import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/pages/select_categories/widgets/list_categories_for_post_creation.dart';
import 'package:hippocapp/pages/select_categories/widgets/list_domains.dart';

import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';

import 'package:hippocapp/widgets/forms/primary_text_form.dart';

class SelectCategoriesDialog extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool selectNewCategory;
  final bool updateCategoryForPost;
  const SelectCategoriesDialog({
    required this.scrollController,
    this.selectNewCategory = false,
    this.updateCategoryForPost = false,
  });

  @override
  ConsumerState<SelectCategoriesDialog> createState() =>
      _PostCreationDialogState();
}

class _PostCreationDialogState extends ConsumerState<SelectCategoriesDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _loading = false;
  bool _loadingCategories = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      bool isSearchingCategories =
          ref.read(appStateProvider).isSearchingCategories;
      if (isSearchingCategories && _textEditingController.text.isEmpty) {
        ref.read(appStateProvider.notifier).setIsSearchingCategories(false);
      } else if (!isSearchingCategories &&
          _textEditingController.text.isNotEmpty) {
        ref.read(appStateProvider.notifier).setIsSearchingCategories(true);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void init() {
    // if there are posts selected, they are cleared and the ui is updated
    ref.read(postListProvider.notifier).clearAllSelectedPosts();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(children: [
      TitleText(),
      SearchInCategoriesTextField(
          textEditingController: _textEditingController),
      _loadingCategories
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
              child: Row(children: [
                Expanded(
                  flex: 8,
                  child: ListCategoriesForPostCreation(
                    controller: _textEditingController,
                    selectNewCategory: widget.selectNewCategory,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListDomainsForPostCreation(
                      textController: _textEditingController),
                ),
              ]),
            )
    ]);
  }
}

class SearchInCategoriesTextField extends StatelessWidget {
  const SearchInCategoriesTextField({
    super.key,
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PrimaryTextFormField(
        controller: _textEditingController,
        action: TextInputAction.done,
        backgroundColor: Colors.white,
        hintText: "Cerca nelle categorie",
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: const Text(
          "Seleziona la categoria per il post",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
