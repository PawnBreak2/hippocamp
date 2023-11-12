import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget {
  final int indexStart;
  final List<Uint8List?> photos;
  const PhotoView({
    required this.photos,
    this.indexStart = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (photos.length == 1)
      return Center(
        child: Container(
          height: 700,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(photos.first!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

    return Center(
      child: CarouselSlider(
        items: photos
            .map(
              (e) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(e!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 700,
          viewportFraction: .9,
          initialPage: indexStart,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          onPageChanged: (i, __) {},
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
