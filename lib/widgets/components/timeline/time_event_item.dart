import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocapp/constants/navigation/routeNames.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:hippocapp/pages/post_creation_and_update/post_creation_and_update_page.dart';
import 'package:hippocapp/providers/posts_management/creation/post_creation_provider.dart';
import 'package:hippocapp/styles/colors.dart';
import 'package:hippocapp/widgets/components/timeline/partner_box.dart';
import 'package:hippocapp/widgets/components/timeline/timeline_post_icon.dart';
import 'package:hippocapp/widgets/components/timeline/timeline_post_title_and_description.dart';
import 'package:hippocapp/widgets/images/cached_timeline_post_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimeEventItem extends ConsumerWidget {
  final Post post;
  final bool isLastOne;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelectedItem;
  final bool showSelectionCircle;

  /// Widget that represents a single post in the timeline.

  const TimeEventItem({
    required this.post,
    this.isLastOne = false,
    this.onTap,
    this.onLongPress,
    this.isSelectedItem = false,
    this.showSelectionCircle = false,
  });

/*
  List<Widget> get _chipsBoxList {
    List<Widget> data = [];

    if (post.address.isNotEmpty)
      data.add(
        _chipBox(
          name: post.address,
          icon:
              "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/timeline-body/position-mark.svg",
        ),
      );

    if (post.attachments.isNotEmpty) {
      for (var i in post.attachments)
        data.add(_chipBox(name: i.name, icon: i.iconUrl));
    }

    return data;
  }
*/

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final listChips = _chipsBoxList;
    // final isPast = post.dateTimeFromString.isBefore(DateTime.now());

    return Material(
      color: isSelectedItem ? CustomColors.mediumRed : Colors.white,
      child: InkWell(
        overlayColor: MaterialStateProperty.all(CustomColors.mediumRed),
        splashColor: CustomColors.mediumRed,
        onTap: onTap ??
            () {
              // resets the postCreationAndUpdate provider and sets it to the post to be edited

              ref
                  .read(postCreationAndUpdateProvider.notifier)
                  .initPostToBeSentToAPIFromExistingPost(post);
              context.pushNamed(routeMap[routeNames.postCreationAndUpdate],
                  extra: post);
            },
        onLongPress: onLongPress,
        child: Stack(
          children: [
            // Item data
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Data 1
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon / Texts
                        Hero(
                            tag: post.key,
                            child: CachedSvgImage(
                                post: post, width: 50, height: 50)),
                        SizedBox(width: 3.w),
                        TimeLinePostTitleAndDescription(post: post),
                        SizedBox(width: 3.w),

                        // Image / time

                        post.businessPartners.isNotEmpty
                            ? PartnerBox(
                                iconUrl: post.businessPartners.first.iconUrl,
                                width: 15.w,
                                height: 15.w,
                                backgroundColor: Colors.transparent,
                                borderColor: Colors.black54)
                            : SizedBox(),
                      ],
                    ),
                  ),

                  /// TODO: cosa sono?

                  // Data 2 -> List chips data
                  /*if (_chipsBoxList.isNotEmpty)
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          left: 74,
                          right: 32,
                        ),
                        itemBuilder: (_, i) => listChips[i],
                        itemCount: listChips.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                      ),
                    ),*/
                ],
              ),
            ),

            // Selection circle
            if (showSelectionCircle)
              TimeEventItemSelectionCircle(isSelectedItem: isSelectedItem),
          ],
        ),
      ),
    );
  }

/*
  Widget _chipBox({required String name, required String icon}) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(
            icon,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: CustomColors.primaryGrey,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
*/
}

class TimeEventItemSelectionCircle extends StatelessWidget {
  const TimeEventItemSelectionCircle({
    super.key,
    required this.isSelectedItem,
  });

  final bool isSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isSelectedItem ? CustomColors.primaryRed : Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(width: 3, color: Colors.white),
      ),
      width: 26,
      height: 26,
      child: Icon(
        Icons.circle,
        color: isSelectedItem ? Colors.white : Colors.grey,
        size: 6,
      ),
    );
  }
}
