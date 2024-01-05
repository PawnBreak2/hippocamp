import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/pages/post_change_category/list_categories.dart';
import 'package:hippocapp/pages/post_change_category/list_domains.dart';

import 'package:hippocapp/providers/state/app_state_provider.dart';

import 'package:hippocapp/widgets/forms/primary_text_form.dart';

class ChangeCategoryDialog extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool selectNewCategory;
  const ChangeCategoryDialog({
    required this.scrollController,
    this.selectNewCategory = false,
  });

  @override
  ConsumerState<ChangeCategoryDialog> createState() =>
      _ChangeCategoryDialogState();
}

class _ChangeCategoryDialogState extends ConsumerState<ChangeCategoryDialog> {
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

  void init() {}

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
                    "A quale categoria vuoi assegnare il tuo post?",
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
                : ListCategoriesForPostupdate(
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
          child: ListDomainsForPostUpdate(
            domains: domains,
          ),
        ),
      ],
    );
  }
}
