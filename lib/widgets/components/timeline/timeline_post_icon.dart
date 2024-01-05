import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocapp/helpers/extensions/string_extensions.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';

class TimelinePostIcon extends StatelessWidget {
  const TimelinePostIcon({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: post.category.domainBackgroundColorHex.colorFromHex,
      ),
      child: SvgPicture.network(
        post.category.iconUrl,
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      ),
    );
  }
}
