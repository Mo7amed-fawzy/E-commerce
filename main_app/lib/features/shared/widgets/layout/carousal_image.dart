import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/components/utils.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  CarouselImageState createState() => CarouselImageState();
}

class CarouselImageState extends State<CarouselImage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: CarouselSlider(
        items:
            Declarations.carouselImages.map((e) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Optional: Perform an action when the image is tapped
                        printHere("Image tapped");
                      });
                    },
                    child: AnimatedOpacity(
                      opacity:
                          _currentIndex ==
                                  Declarations.carouselImages.indexOf(e)
                              ? 1.0
                              : 0.5,
                      duration: const Duration(milliseconds: 300),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          15,
                        ), // Rounded corners
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ), // Small margin between images
                          child: Image.network(
                            e,
                            fit: BoxFit.cover,
                            height: 180, // Reduced height
                            width: double.infinity,
                            loadingBuilder: (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) {
                                return child; // الصورة اتحملت خلاص
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              (loadingProgress
                                                      .expectedTotalBytes ??
                                                  1)
                                          : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
        options: CarouselOptions(
          viewportFraction:
              0.9, // Less than 1 for images to feel part of the content
          height: 180, // Reduced height
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
          autoPlay: true, // Enable autoplay
          autoPlayInterval: const Duration(
            seconds: 4,
          ), // Change every 4 seconds
          autoPlayAnimationDuration: const Duration(
            milliseconds: 800,
          ), // Smooth transition
          autoPlayCurve: Curves.easeInOut, // Smooth curve effect
        ),
      ),
    );
  }
}
