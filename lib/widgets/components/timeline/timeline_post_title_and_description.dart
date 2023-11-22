import 'package:flutter/material.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimeLinePostTitleAndDescription extends StatelessWidget {
  const TimeLinePostTitleAndDescription({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            post.title,
            style: TextStyle(
              fontSize: 16,
              color: CustomColors.grey66,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          // Category & Price
          Row(
            children: [
              Text(
                post.timePost,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 1.w),
              Text(
                " | ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
              ),
              SizedBox(width: 1.w),

              // Category
              Expanded(
                child: Text(
                  post.category.name,
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
    );
  }
}
