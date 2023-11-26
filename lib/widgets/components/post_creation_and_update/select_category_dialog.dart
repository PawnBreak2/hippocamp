import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/pages/post_creation_and_update/list_categories_for_post_creation.dart';
import 'package:hippocamp/pages/post_creation_and_update/list_domains.dart';

import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';

import 'package:hippocamp/widgets/forms/primary_text_form.dart';

class SelectCategoriesDialog extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool selectNewCategory;
  const SelectCategoriesDialog({
    required this.scrollController,
    this.selectNewCategory = false,
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
      setState(() {});
    });
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

    final domains = ref.watch(appStateProvider).domains;

    return Stack(
      children: [
        ListView(
          controller: widget.scrollController,
          padding: const EdgeInsets.only(bottom: 16, top: 16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Text(
                    "In quale categoria vuoi inserire il tuo post?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  PrimaryTextFormField(
                    controller: _textEditingController,
                    action: TextInputAction.done,
                    backgroundColor: Colors.white,
                    hintText: "Cerca nelle categorie",
                    suffixIcon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // List Categories
            _loadingCategories
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListCategoriesForPostCreation(
                    controller: _textEditingController,
                    selectNewCategory: widget.selectNewCategory,
                  ),
          ],
        ),
        // List domains
        Positioned(
          right: 8,
          top: 100,
          bottom: 20,
          child: ListDomainsForPostCreation(
            domains: domains,
          ),
        ),
      ],
    );
  }
}
