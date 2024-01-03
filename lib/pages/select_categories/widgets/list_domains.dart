import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/domains_response_model.dart';
import 'package:flutter/material.dart';
import 'package:hippocapp/providers/app_state_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/images/generic_cached_icon.dart';

import '../../../../providers/ui_state_provider.dart';

class ListDomainsForPostCreation extends StatelessWidget {
  final TextEditingController _textController;
  const ListDomainsForPostCreation({
    super.key,
    required textController,
  }) : _textController = textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.black26,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                    spreadRadius: 1, blurRadius: 10, color: Colors.black12),
              ],
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final domains = ref.watch(appStateProvider).domains;

                return ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  itemBuilder: (_, i) {
                    final uiStateNotifier = ref.read(uiStateProvider.notifier);
                    final isDomainSelected = ref.watch(uiStateProvider.select(
                        (state) =>
                            state.currentlySelectedDomainKey ==
                            domains[i].key));

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        _textController.clear();
                        uiStateNotifier.setSelectedDomainKey(domains[i].key);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: domains[i].backgroundColorHex.colorFromHex,
                              border: Border.all(
                                width: isDomainSelected ? 4 : 1,
                                color: isDomainSelected
                                    ? CustomColors.primaryRed
                                    : Colors.grey,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: GenericCachedIcon(
                                imageUrl: domains[i].iconUrl)),
                      ),
                    );
                  },
                  itemCount: domains.length,
                  separatorBuilder: (_, i) => i == domains.length
                      ? const SizedBox()
                      : const SizedBox(height: 16),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 24,
        )
      ],
    );
  }
}
