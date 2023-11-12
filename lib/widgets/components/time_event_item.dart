import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/pages/posts-creation/post_creation_page.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:hippocamp/widgets/components/partner_box.dart';

class TimeEventItem extends StatelessWidget {
  final Post post;
  final bool isLastOne;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelectedItem;
  final bool showSelectionCircle;

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
    final listChips = _chipsBoxList;
    final isPast = post.dateTimeFromString.isBefore(DateTime.now());

    return Material(
      color: isSelectedItem
          ? Color.fromRGBO(235, 235, 235, 1)
          : isPast
              ? Colors.white
              : CustomColors.primaryLightBlue,
      child: InkWell(
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
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Data 1
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon / Texts
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: post
                                .category.domainBackgroundColorHex.colorFromHex,
                          ),
                          child: SvgPicture.network(
                            post.category.iconUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                post.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.grey66,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6),
                              // Category & Price
                              Row(
                                children: [
                                  // Category
                                  Expanded(
                                    child: Text(
                                      post.category.nome,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(width: 6),

                                  // Price
                                  if (post.totalAmountSpent.isNotEmpty)
                                    Text(
                                      post.totalAmountSpent,
                                      style: TextStyle(
                                        color: post.colorAmountSpent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 16),

                        // Image / time
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PartnerBox(
                              iconUrl: post.businessPartners.isEmpty
                                  ? ""
                                  : post.businessPartners.first.iconUrl,
                              width: 65,
                              height: 30,
                              backgroundColor: post.businessPartners.isEmpty
                                  ? CustomColors.white243
                                  : Colors.transparent,
                            ),
                            SizedBox(height: 14),
                            Text(
                              post.timePost,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Data 2 -> List chips data
                  if (_chipsBoxList.isNotEmpty)
                    Container(
                      height: 30,
                      margin: EdgeInsets.only(
                        top: 8,
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          left: 74,
                          right: 32,
                        ),
                        itemBuilder: (_, i) => listChips[i],
                        itemCount: listChips.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8),
                      ),
                    ),
                ],
              ),
            ),

            // Selection circle
            if (showSelectionCircle)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelectedItem ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: Colors.white),
                ),
                width: 26,
                height: 26,
                child: Icon(
                  Icons.check,
                  color: isSelectedItem ? Colors.white : Colors.grey,
                  size: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _chipBox({required String name, required String icon}) {
    return Container(
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
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
          SizedBox(width: 4),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
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
