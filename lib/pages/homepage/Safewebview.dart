import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class SafeWebView extends StatelessWidget {
  final String? url;
  SafeWebView({this.url});

  void _openURL(BuildContext context) async {
    if (url != null && url!.isNotEmpty) {
      FlutterWebBrowser.openWebPage(
        url: url!,
        customTabsOptions: CustomTabsOptions(
          toolbarColor: Theme.of(context).primaryColor,
          showTitle: true,
        ),
        safariVCOptions: SafariViewControllerOptions(
          barCollapsingEnabled: true,
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid URL'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);

    // Open the URL directly after the widget is built
    Future.delayed(Duration.zero, () => _openURL(context));

    // Return an empty container as the main UI since we don't want to show anything
    return Container();
  }
}
