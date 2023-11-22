import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/pages/categories/detail_category/posts_per_category_page.dart';
import 'package:hippocamp/pages/categories/sub_categories_inactive.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/dialogs/custom_bottom_sheet.dart';

class DetailCategoryPage extends ConsumerStatefulWidget {
  final Domain domain;
  const DetailCategoryPage({required this.domain});

  @override
  ConsumerState<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends ConsumerState<DetailCategoryPage> {
  late Domain domainSelected = widget.domain;

  int _indexPage = 0;
  bool _loading = true;

  late final Map<int, DraggableGridItem> elements = {};

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final appStateProviderState = ref.watch(appStateProvider);
    final appStateProviderNotifier = ref.watch(appStateProvider.notifier);
    await appStateProviderNotifier.getCategoriesInDomains(
      forceCall: true,
      domainKey: domainSelected.key,
    );
    _loading = false;

    for (var i = 0; i < 40; i++) {
      final element = appStateProviderState.categoriesInDomains.where(
        (e) => e.position == i,
      );
      if (element.isNotEmpty)
        elements[i] = _categoryBox(
          isNull: false,
          index: i,
          key: element.first.key,
          image: element.first.iconUrl,
          backgroundColor: element.first.domainBackgroundColorHex.colorFromHex,
          title: element.first.localizedName,
          onPressed: () {},
        );
      else
        elements[i] = _categoryBox(
          index: i,
          isNull: true,
          key: "",
        );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 230, 222, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 196, 190, 1),
        elevation: 0,
        leading: Container(),
        toolbarHeight: 10,
        shadowColor: Colors.transparent,
      ),
      body: GestureDetector(
        onVerticalDragEnd: (d) async {
          if (!d.primaryVelocity!.isNegative) return;

          final resp = await CustomBottomSheet.showDraggableBottomSheet(
            context,
            (controller) => SubCategoriesInactive(
              domainKey: widget.domain.key,
              scrollController: controller,
            ),
          );

          if (resp == null || !resp) return;

          _loading = true;
          setState(() {});

          _init();
        },
        child: Column(
          children: [
            _AppBarSection(
              domain: domainSelected,
              onDomainChange: (newDom) {
                _loading = true;
                domainSelected = newDom as Domain;
                setState(() {});

                _init();
              },
            ),
            SizedBox(height: 8),

            // Icon page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        _indexPage == 0 ? CustomColors.primaryRed : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color:
                        _indexPage == 1 ? CustomColors.primaryRed : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  width: 16,
                  height: 16,
                ),
              ],
            ),
            SizedBox(height: 8),

            // Gridview
            Expanded(
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
          ],
        ),
      ),
    );
  }

  DraggableGridViewBuilder listItems(List<DraggableGridItem> children) {
    final appStateProviderNotifier = ref.read(appStateProvider.notifier);
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

        await appStateProviderNotifier.updateIndexCategory(
          domainSelected.key,
          key,
          nextIndex,
        );
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

  DraggableGridItem _categoryBox({
    required bool isNull,
    required int index,
    required String key,
    String? image,
    Color? backgroundColor,
    String? title,
    VoidCallback? onPressed,
  }) {
    return DraggableGridItem(
      isDraggable: true,
      dragCallback: (_, v) {},
      child: GestureDetector(
        key: Key(key),
        onTap: () {
          final appStateProviderState = ref.watch(appStateProvider);

          final category = appStateProviderState.categoriesInDomains
              .firstWhere((e) => e.key == key);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostsPerCategory(category: category),
            ),
          );
        },
        // It blocks user to move empty box
        onLongPress: isNull ? () {} : null,
        child: isNull
            ? Container()
            : Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: backgroundColor,
                        border: Border.all(color: Colors.black),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 5,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: SvgPicture.network(image!),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      title!,
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

class _AppBarSection extends StatelessWidget {
  final Domain domain;
  final void Function(Domain newDomainSelected) onDomainChange;
  const _AppBarSection({
    required this.domain,
    required this.onDomainChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.pinkWhite,
      height: 100,
      child: Stack(
        children: [
          // Setting app bar fixed
          // Container with options
          Container(
            color: CustomColors.pinkWhiteDeep,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  onSelected: (c) async {},
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: "0",
                      child: Text("Salva come predefinito"),
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
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 26,
                  ),
                ),

                // Image + other
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Image circle
                      InkWell(
                        onTap: () => onDomainAvatarClick(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(239, 230, 222, 1),
                            border: Border.all(
                              color: Color.fromRGBO(239, 230, 222, 1),
                              width: 12,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: 100,
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: domain.backgroundColorHex.colorFromHex,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: SvgPicture.network(
                              domain.iconUrl,
                            ),
                          ),
                        ),
                      ),

                      // Partner + title
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              domain.localizedName,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontWeight: FontWeight.w500,
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
          ),
        ],
      ),
    );
  }

  Future<void> onDomainAvatarClick(BuildContext context) async {
    final resp = await CustomBottomSheet.showFullDialog(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 5,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Container(
              height: 150,
              color: Colors.white,
              child: Consumer(
                builder: (context, ref, child) {
                  final appStateProviderState = ref.watch(appStateProvider);
                  final domains = appStateProviderState.domainsInCategories;

                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemBuilder: (_, i) => Center(
                      child: SizedBox(
                        width: 60,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => Navigator.pop(context, domains[i]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: domains[i]
                                      .backgroundColorHex
                                      .colorFromHex,
                                  border: Border.all(
                                    width: domain.key == domains[i].key ? 4 : 1,
                                    color: domain.key == domains[i].key
                                        ? CustomColors.primaryRed
                                        : Colors.grey,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.network(
                                  domains[i].iconUrl,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                domains[i].localizedName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: domains.length,
                    separatorBuilder: (_, i) => SizedBox(width: 8),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    if (resp == null) return;

    onDomainChange(resp);
  }
}
