import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/pages/posts-creation/post_creation_page.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/styles/colors.dart';
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
  final TextEditingController _controller = TextEditingController();
  int _index = -1;
  bool _loading = true;
  bool _loadingCategories = false;

  @override
  void initState() {
    super.initState();
    init();
    _controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> init() async {
    final appStateProviderNotifier = ref.read(appStateProvider.notifier);
    await appStateProviderNotifier.getDomains();
    await appStateProviderNotifier.getCategories(forceCall: true);
    _loading = false;
    setState(() {});
  }

  Future<void> getNewCategories(String? key) async {
    _loadingCategories = true;
    setState(() {});

    final appStateProviderNotifier = ref.read(appStateProvider.notifier);
    await appStateProviderNotifier.getCategories(
      key: key,
      forceCall: true,
    );
    _loadingCategories = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return Center(
        child: CircularProgressIndicator(),
      );

    final domains = ref.watch(appStateProvider).domains;

    return Stack(
      children: [
        ListView(
          controller: widget.scrollController,
          padding: EdgeInsets.only(bottom: 16, top: 16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    "Seleziona la categoria per il post",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  PrimaryTextFormField(
                    controller: _controller,
                    action: TextInputAction.done,
                    backgroundColor: Colors.white,
                    hintText: "Cerca categoria",
                    suffixIcon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // List Categories
            _loadingCategories
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListCategories(
                    controller: _controller,
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
            selectedDomain: _index,
            domains: domains,
            onTap: (i) {
              _controller.clear();

              if (i == _index)
                _index = -1;
              else
                _index = i;
              setState(() {});

              if (_index == -1)
                getNewCategories(null);
              else
                getNewCategories(domains[_index].key);
            },
          ),
        ),
      ],
    );
  }
}

class ListDomains extends StatelessWidget {
  final int selectedDomain;
  final List<Domain> domains;
  final void Function(int) onTap;
  const ListDomains({
    required this.domains,
    required this.selectedDomain,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(spreadRadius: 1, blurRadius: 10, color: Colors.black12),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        itemBuilder: (_, i) => InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onTap(i),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: domains[i].backgroundColorHex.colorFromHex,
              border: Border.all(
                width: selectedDomain == i ? 4 : 1,
                color:
                    selectedDomain == i ? CustomColors.primaryRed : Colors.grey,
              ),
            ),
            alignment: Alignment.center,
            child: SvgPicture.network(
              domains[i].iconUrl,
              width: 50,
              height: 50,
            ),
          ),
        ),
        itemCount: domains.length,
        separatorBuilder: (_, i) =>
            i == domains.length ? SizedBox() : SizedBox(height: 16),
      ),
    );
  }
}

class ListCategories extends ConsumerWidget {
  final TextEditingController controller;
  final bool selectNewCategory;
  const ListCategories({
    required this.controller,
    required this.selectNewCategory,
  });

  List<PostCategory> categoriesFilter(List<PostCategory> categories) {
    final text = controller.text.toLowerCase();

    if (text.isEmpty) return categories;

    return categories
        .where((e) => e.localizedName.toLowerCase().contains(text))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = categoriesFilter(ref.watch(appStateProvider).categories);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: categories.length > 100 ? 100 : categories.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        return InkWell(
          onTap: () {
            Navigator.pop(context, categories[i]);
            if (!selectNewCategory)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostCreationPage(
                    category: categories[i],
                  ),
                ),
              );
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
                margin: EdgeInsets.only(left: 16, right: 8, top: 4, bottom: 4),
                child: SvgPicture.network(
                  categories[i].iconUrl,
                ),
              ),
              Expanded(
                child: Text(
                  categories[i].localizedName,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) =>
          i == categories.length ? SizedBox() : SizedBox(height: 4),
    );
  }
}
