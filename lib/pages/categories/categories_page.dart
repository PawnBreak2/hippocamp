import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/repositories/app_state_repository.dart';
import 'package:hippocapp/models/responses/domains_response_model.dart';
import 'package:hippocapp/pages/categories/categories_inactive.dart';
import 'package:hippocapp/pages/categories/detail_category/detail_category_page.dart';
import 'package:hippocapp/providers/app_state_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/dialogs/cupertino_bottom_sheet.dart';
import 'package:hippocapp/widgets/dialogs/custom_bottom_sheet.dart';
import 'package:hippocapp/widgets/forms/primary_text_form.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {
  late final Map<int, DraggableGridItem> elements = {};
  bool _loading = true;

  int _indexPage = 0;

  bool _searchFieldActive = false;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _timerForSearching;
  late final AppStateNotifier appStateProviderNotifier;
  late final AppState appStateProviderState;

  @override
  void initState() {
    appStateProviderNotifier = ref.read(appStateProvider.notifier);
    appStateProviderState = ref.read(appStateProvider);

    super.initState();
    _init();
  }

  Future<void> _init() async {
    await appStateProviderNotifier.getDomainsInCategories(forceCall: true);
    _loading = false;

    for (var i = 0; i < 40; i++) {
      final element = appStateProviderState.domainsInCategories.where(
        (e) => e.position == i,
      );

      if (element.isNotEmpty)
        elements[i] = _domainBox(
          index: i,
          domain: element.first,
          onPressed: () {},
        );
      else
        elements[i] = _domainBox(
          index: i,
          domain: null,
        );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pinkWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        actions: [
          // Search form
          if (_searchFieldActive)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _searchFieldActive = false;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: PrimaryTextFormField(
                        controller: _textEditingController,
                        hintText: "Cerca",
                        focusNode: _focusNode,
                        backgroundColor: Colors.white,
                        action: TextInputAction.search,
                        onChange: (_) {
                          // searchTextInPosts();
                        },
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: _textEditingController.text.isNotEmpty
                              ? Icon(Icons.clear)
                              : Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Icons
          if (!_searchFieldActive)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon for scheme
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.network(
                        "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/categorie/category-gallery.svg",
                        height: 28,
                        width: 28,
                      ),
                      splashRadius: 26,
                      iconSize: 26,
                    ),

                    // Icon page
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _indexPage == 0
                                ? CustomColors.primaryRed
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: _indexPage == 1
                                ? CustomColors.primaryRed
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),

                    // Icon for search
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _searchFieldActive = true;
                            _focusNode.requestFocus();
                            setState(() {});
                          },
                          icon: SvgPicture.network(
                            "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/top-nav-bar/lente-search.svg",
                            height: 28,
                            width: 28,
                          ),
                          splashRadius: 26,
                          iconSize: 26,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: GestureDetector(
        onVerticalDragEnd: (d) async {
          if (!d.primaryVelocity!.isNegative) return;

          final resp = await CustomBottomSheet.showDraggableBottomSheet(
            context,
            (controller) => CategoriesInactive(
              scrollController: controller,
            ),
          );

          if (resp == null || !resp) return;

          _loading = true;
          setState(() {});

          _init();
        },
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PageView(
                onPageChanged: (i) {
                  _indexPage = i;
                  setState(() {});
                },
                children: [
                  // First elements
                  listItems(
                    elements.entries
                        .map((e) => e.value)
                        .toList()
                        .sublist(0, 20),
                  ),

                  // Second elements
                  listItems(
                    elements.entries
                        .map((e) => e.value)
                        .toList()
                        .sublist(20, 40),
                  ),
                ],
              ),
      ),
    );
  }

  DraggableGridViewBuilder listItems(List<DraggableGridItem> children) {
    return DraggableGridViewBuilder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 90 / 150,
        crossAxisCount: 4,
        crossAxisSpacing: 24,
        mainAxisSpacing: 16,
      ),
      dragCompletion: (list, previousIndex, nextIndex) async {
        final e = elements[previousIndex];
        final key =
            e!.child.key.toString().replaceAll("[<'", "").replaceAll("'>]", "");

        if (previousIndex < nextIndex) {
          for (var i = previousIndex; i < nextIndex; i++) {
            final temp = elements[i]!;
            elements[i] = elements[i + 1]!;
            elements[i + 1] = temp;
          }
        } else {
          for (var i = previousIndex; i > nextIndex; i--) {
            final temp = elements[i]!;
            elements[i] = elements[i - 1]!;
            elements[i - 1] = temp;
          }
        }
        setState(() {});
        await appStateProviderNotifier.updateIndexDomain(key, nextIndex);
      },
      dragFeedback: (list, index) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: 90,
            height: 140,
            color: Colors.transparent,
            padding: EdgeInsets.all(4),
            child: Center(child: list[index].child),
          ),
        );
      },
      dragPlaceHolder: (list, index) {
        return PlaceHolderWidget(
          child: Container(
            color: CustomColors.pinkWhite,
          ),
        );
      },
      children: children,
    );
  }

  DraggableGridItem _domainBox({
    required int index,
    required Domain? domain,
    VoidCallback? onPressed,
  }) {
    return DraggableGridItem(
      isDraggable: true,
      dragCallback: (_, v) {},
      child: GestureDetector(
        key: Key(domain?.key ?? ""),
        onTap: domain == null
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailCategoryPage(domain: domain),
                  ),
                );
              },
        onDoubleTap: domain == null
            ? null
            : () async {
                final resp =
                    await CustomCupertinoDialogs.showCupertinoBottomSheet(
                  context: context,
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context, 0);
                      },
                      child: Text("Disattiva"),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context, 1);
                      },
                      child: Text("Disinstalla"),
                    ),
                  ],
                  lastButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Torna indietro"),
                  ),
                );

                if (resp == null) return;

                if (resp == 0)
                  await appStateProviderNotifier.addRemoveDomainSelected(
                    domain.key,
                    addOrRemove: false,
                  );
                else
                  await appStateProviderNotifier
                      .uninstallDomainSelected(domain.key);

                elements[index] = _domainBox(
                  index: index,
                  domain: null,
                );
                setState(() {});
              },
        // It blocks user to move empty box
        onLongPress: domain == null ? () {} : null,
        child: domain == null
            ? Container()
            : Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: domain.backgroundColorHex.colorFromHex,
                        border: Border.all(color: Colors.black),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 5,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: SvgPicture.network(domain.iconUrl),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      domain.localizedName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
