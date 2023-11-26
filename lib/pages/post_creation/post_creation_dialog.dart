import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/repositories/app_state_repository.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/pages/post_creation/list_categories_for_post_creation.dart';

import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/components/bottom_bar/list_categories.dart';
import 'package:hippocamp/widgets/components/bottom_bar/list_domains.dart';
import 'package:hippocamp/widgets/forms/primary_text_form.dart';

class PostCreationDialog extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool selectNewCategory;
  const PostCreationDialog({
    required this.scrollController,
    this.selectNewCategory = false,
  });

  @override
  ConsumerState<PostCreationDialog> createState() => _PostCreationDialogState();
}

class _PostCreationDialogState extends ConsumerState<PostCreationDialog> {
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
                    "Seleziona la categoria per il post",
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
                    hintText: "Cerca categoria",
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
          child: ListDomains(
            domains: domains,
          ),
        ),
      ],
    );
  }
}
