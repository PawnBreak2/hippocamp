import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';

class CachedSvgImage extends StatelessWidget {
  final Post post;
  final double? width;
  final double? height;

  const CachedSvgImage({
    Key? key,
    required this.post,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _loadSvg(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // SVG is loaded, render it
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: post.category.domainBackgroundColorHex.colorFromHex,
            ),
            child: SvgPicture.memory(
              snapshot.data!,
              width: width,
              height: height,
              fit: BoxFit.fill,
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error, display an error icon or message
          return Icon(Icons.error);
        }
        // Show a loading spinner while waiting for the SVG data
        return CircularProgressIndicator();
      },
    );
  }

  Future<Uint8List> _loadSvg() async {
    // Use DefaultCacheManager to fetch and cache the SVG file
    final cacheManager = DefaultCacheManager();
    final file = await cacheManager.getSingleFile(post.category.iconUrl);
    return file.readAsBytes();
  }
}
