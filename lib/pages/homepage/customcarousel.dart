import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/pages/homepage/Safewebview.dart';
import 'package:fyp/utils/quotes.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({Key? key}) : super(key: key);

  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);

    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.3,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: List.generate(
          imageSliders.length,
          (index) => Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.r), // Responsive border radius
            ),
            child: InkWell(
              onTap: () {
                if (index == 0) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://gulfnews.com/world/asia/pakistan/womens-day-10-pakistani-women-inspiring-the-country-1.77696239"));
                } else if (index == 1) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://plan-international.org/ending-violence/16-ways-end-violence-girls"));
                } else if (index == 2) {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
                } else {
                  navigateToRoute(
                      context,
                      SafeWebView(
                          url:
                              "https://www.healthline.com/health/womens-health/self-defense-tips-escape"));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20.r), // Responsive border radius
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          imageSliders[index],
                        ))),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20.r), // Responsive border radius
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ]),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 8.h, left: 8.w), // Responsive padding
                      child: Text(
                        articleTitle[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.sp, // Responsive font size
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
