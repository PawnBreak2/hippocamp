import 'package:flutter/material.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:hippocapp/styles/colors.dart';
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
              // Builds this section depending on the post type based on time
              Builder(builder: (context) {
                if (post.wholeDay) {
                  return Icon(
                    Icons.square,
                    color: CustomColors.grey66,
                    size: 10,
                  );
                } else if (!post.wholeDay && post.from == post.to) {
                  return Text(post.timePost,
                      style: TextStyle(
                        fontSize: 14,
                      ));
                } else if (!post.wholeDay && post.from != post.to) {
                  return Text(
                    '${post.from.substring(0, post.from.length - 3)} - ${post.to.substring(0, post.to.length - 3)}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  );
                } else {
                  /// TODO: da completare
                  return Icon(
                    Icons.square,
                    color: CustomColors.grey66,
                    size: 10,
                  );
                }
              }),
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
