import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/models/posts-creation/partner_model.dart';
import 'package:hippocapp/providers/app_state_provider.dart';
import 'package:hippocapp/providers/posts_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/components/timeline/partner_box.dart';
import 'package:hippocapp/widgets/forms/primary_text_form.dart';

class PartnerDialog extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const PartnerDialog({required this.scrollController});

  @override
  ConsumerState<PartnerDialog> createState() => _PartnerDialogState();
}

class _PartnerDialogState extends ConsumerState<PartnerDialog> {
  final TextEditingController _controller = TextEditingController();
  int _index = 0;
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
    final appStateProviderState = ref.read(appStateProvider);
    final appStateProviderNotifier = ref.read(appStateProvider.notifier);
    if (appStateProviderState.businessPartners.isEmpty) {
      await appStateProviderNotifier.getBusinessPartners();
      _loading = false;
      setState(() {});
    } else
      _loading = false;
  }

  List<PartnerModel> partnersSearching(List<PartnerModel> partners) {
    final text = _controller.text.toLowerCase();

    if (text.isEmpty) return partners;

    return partners.where((e) => e.name.toLowerCase().contains(text)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return Center(
        child: CircularProgressIndicator(),
      );

    final partners = ref
        .watch(appStateProvider)
        .businessPartners
        .where(
          (e) => _index == 0 ? e.assigned : true,
        )
        .toList();

    return ListView(
      controller: widget.scrollController,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                "Seleziona il Partner da associare al post",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              PrimaryTextFormField(
                controller: _controller,
                backgroundColor: Colors.white,
                borderRadius: 18,
                action: TextInputAction.done,
                hintText: "Cerca business partner",
                suffixIcon: Icon(Icons.search),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Buttons filter active or every
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  _index = 0;
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    color: _index == 1
                        ? Colors.transparent
                        : CustomColors.primaryLightGreen,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    "Attivi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              InkWell(
                onTap: () {
                  _index = 1;
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: BoxDecoration(
                    color: _index == 0
                        ? Colors.transparent
                        : CustomColors.primaryLightGreen,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Text(
                    "Tutti",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // List Partners
        ListPartners(
          partners: partnersSearching(partners),
          onTap: (i) {
            Navigator.pop(context, i);
          },
        ),
      ],
    );
  }
}

class ListPartners extends StatelessWidget {
  final List<PartnerModel> partners;
  final void Function(PartnerModel) onTap;
  const ListPartners({
    required this.partners,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (partners.isEmpty)
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Text(
          "La lista dei partner vuota",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

    return ListView.separated(
      shrinkWrap: true,
      itemCount: partners.length > 100 ? 100 : partners.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        return InkWell(
          onTap: () => onTap(partners[i]),
          child: Row(
            children: [
              PartnerBox(
                iconUrl: partners[i].iconUrl,
                width: 90,
                height: 40,
                margin: EdgeInsets.only(left: 16, right: 8, bottom: 8, top: 8),
              ),
              Expanded(
                child: Text(
                  partners[i].name,
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
          i == partners.length ? SizedBox() : SizedBox(height: 4),
    );
  }
}
