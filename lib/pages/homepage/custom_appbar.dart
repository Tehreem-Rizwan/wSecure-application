import 'package:flutter/material.dart';
import 'package:fyp/utils/quotes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerAppBar extends StatefulWidget {
  final Function()? onTap;
  final int? quoteIndex;

  CustomerAppBar({required this.onTap, required this.quoteIndex});

  @override
  State<CustomerAppBar> createState() => _CustomerAppBarState();
}

class _CustomerAppBarState extends State<CustomerAppBar> {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(8.0.w), // Responsive padding
        child: Text(
          goodSayings[widget.quoteIndex!],
          style: TextStyle(
            fontSize: 20.sp, // Responsive font size
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
