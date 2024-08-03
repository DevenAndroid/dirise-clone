import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImageViewer extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImageViewer({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index]),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
                initialScale: PhotoViewComputedScale.contained,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(
              color: Colors.white,
            ),
            pageController: PageController(initialPage: initialIndex),
            onPageChanged: (index) {
              // Optional: Do something when the page is changed
            },
          ),
          Positioned(
            top: 40,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
              Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
