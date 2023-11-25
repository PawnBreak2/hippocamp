import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocamp/helpers/extensions/string_extensions.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';

class GenericCachedIcon extends StatelessWidget {
  late double width;
  late double height;
  late String imageUrl;

  GenericCachedIcon({
    super.key,
    this.width = 40,
    this.height = 40,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _loadSvg(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // SVG is loaded, render it
          return SvgPicture.memory(
            snapshot.data!,
            width: width,
            height: height,
            fit: BoxFit.fill,
          );
        } else if (snapshot.hasError) {
          // Handle error, display an error icon or message
          return const SizedBox();
        }
        // Show a loading spinner while waiting for the SVG data
        return const CircularProgressIndicator();
      },
    );
  }

  Future<Uint8List> _loadSvg() async {
    // Use DefaultCacheManager to fetch and cache the SVG file
    final cacheManager = DefaultCacheManager();
    final file = await cacheManager.getSingleFile(imageUrl);
    return file.readAsBytes();
  }
}
