import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/pages/posts-creation/post_creation_page.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/components/partner_box.dart';
import 'package:hippocamp/widgets/components/timeline/timeline_post_icon.dart';
import 'package:hippocamp/widgets/components/timeline/timeline_post_title_and_description.dart';
import 'package:hippocamp/widgets/images/cached_timeline_post_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimeEventItem extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    inspect(post);
    final listChips = _chipsBoxList;
    final isPast = post.dateTimeFromString.isBefore(DateTime.now());

    return Material(
      color: isSelectedItem
          ? CustomColors.mediumRed
          : isPast
              ? Colors.white
              : CustomColors.primaryLightBlue,
      child: InkWell(
        overlayColor: MaterialStateProperty.all(CustomColors.mediumRed),
        splashColor: CustomColors.mediumRed,
        onTap: onTap ??
            () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostCreationPage(post: post),
                ),
              );
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PartnerBox(
                              iconUrl: post.businessPartners.isEmpty
                                  ? ""
                                  : post.businessPartners.first.iconUrl,
                              width: 15.w,
                              height: 15.w,
                              backgroundColor: post.businessPartners.isEmpty
                                  ? Colors.white
                                  : Colors.transparent,
                              borderColor: post.businessPartners.isEmpty
                                  ? CustomColors.darkerGrey
                                  : Colors.black54,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// TODO: cosa sono?

                  // Data 2 -> List chips data
                  if (_chipsBoxList.isNotEmpty)
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
                    ),
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
