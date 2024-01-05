import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/repositories/app_state_repository.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/widgets/dialogs/cupertino_bottom_sheet.dart';

class SubCategoriesInactive extends ConsumerStatefulWidget {
  final String domainKey;
  final ScrollController scrollController;
  const SubCategoriesInactive({
    required this.domainKey,
    required this.scrollController,
  });

  @override
  ConsumerState<SubCategoriesInactive> createState() =>
      _SubCategoriesInactiveState();
}

class _SubCategoriesInactiveState extends ConsumerState<SubCategoriesInactive> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = true;
  late final AppStateNotifier appStateProviderNotifier;
  late final AppState appStateProviderState;

  @override
  void initState() {
    appStateProviderNotifier = ref.read(appStateProvider.notifier);
    appStateProviderState = ref.read(appStateProvider);

    super.initState();
    init();
    _controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> init() async {
    await appStateProviderNotifier.getCategoriesInDomains(
      domainKey: widget.domainKey,
      active: false,
      forceCall: true,
    );
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );

    final listInactiveCategories =
        appStateProviderState.categoriesInDomainsInactive;

    return ListView(
      controller: widget.scrollController,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      children: [
        Center(
          child: Text(
            "Categorie disattivate",
            style: TextStyle(
              color: Color.fromRGBO(94, 92, 97, 1),
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(height: 32),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 90 / 150,
            crossAxisCount: 4,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (_, i) => _domainBox(
            index: i,
            category: listInactiveCategories[i],
          ),
          itemCount: listInactiveCategories.length,
        ),
      ],
    );
  }

  Widget _domainBox({
    required int index,
    required PostCategory category,
  }) {
    return GestureDetector(
      key: Key(category.key),
      onTap: () async {
        final resp = await CustomCupertinoDialogs.showCupertinoBottomSheet(
          context: context,
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: Text("Attiva"),
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
          await appStateProviderNotifier.addRemoveDomainSelected(category.key);
        else
          await appStateProviderNotifier.uninstallDomainSelected(category.key);

        await appStateProviderNotifier.getDomainsInCategories(
          active: false,
          forceCall: true,
        );

        Navigator.pop(context, resp == 0);
        setState(() {});
      },
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: category.domainBackgroundColorHex.colorFromHex,
              ),
              child: SvgPicture.network(category.iconUrl),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Text(
              category.name,
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
    );
  }
}
