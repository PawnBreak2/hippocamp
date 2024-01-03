import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/domains_response_model.dart';
import 'package:hippocapp/providers/app_state_provider.dart';
import 'package:hippocapp/providers/posts_provider.dart';
import 'package:hippocapp/widgets/dialogs/cupertino_bottom_sheet.dart';

class CategoriesInactive extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const CategoriesInactive({
    required this.scrollController,
  });

  @override
  ConsumerState<CategoriesInactive> createState() => _CategoriesInactiveState();
}

class _CategoriesInactiveState extends ConsumerState<CategoriesInactive> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = true;

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
    await appStateProviderNotifier.getDomainsInCategories(
      active: false,
      forceCall: true,
    );
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appStateProviderState = ref.read(appStateProvider);

    if (_loading)
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );

    final listInactiveDomains =
        appStateProviderState.domainsInCategoriesInactive;

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
            domain: listInactiveDomains[i],
          ),
          itemCount: listInactiveDomains.length,
        ),
      ],
    );
  }

  Widget _domainBox({
    required int index,
    required Domain domain,
  }) {
    return GestureDetector(
      key: Key(domain.key),
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
        final appStateProviderNotifier = ref.read(appStateProvider.notifier);
        if (resp == null) return;

        if (resp == 0) {
          await appStateProviderNotifier.addRemoveDomainSelected(domain.key);
        } else {
          await appStateProviderNotifier.uninstallDomainSelected(domain.key);
        }

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
                color: domain.backgroundColorHex.colorFromHex,
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
    );
  }
}
