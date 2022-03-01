import 'package:codingstack_core/src/utils/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPage extends StatelessWidget {
  final String title;
  final String message;
  final String lottieUrl;
  final double imageSize;
  final TextStyle? headingStyle;
  final TextStyle? textStyle;

  const ErrorPage({
    Key? key,
    required this.title,
    required this.message,
    required this.lottieUrl,
    this.imageSize = 80,
    this.headingStyle,
    this.textStyle,
  }) : super(key: key);

  static navigate(
    BuildContext context, {
    required String title,
    required String message,
    required String lottieUrl,
    double imageSize = 80,
    bool replace = false,
    TextStyle? headingStyle,
    TextStyle? textStyle,
  }) {
    final route = MaterialPageRoute(
      builder: (_) => ErrorPage(
        title: title,
        message: message,
        lottieUrl: lottieUrl,
        imageSize: imageSize,
        textStyle: textStyle,
        headingStyle: headingStyle,
      ),
    );
    if (replace) {
      return Navigator.pushReplacement(context, route);
    }
    return Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(lottieUrl, height: imageSize, width: imageSize,
                errorBuilder: (c, o, s) {
              return const Icon(Icons.error);
            }),
            VerticalGap.v22,
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 26),
            ),
            VerticalGap(),
            Text(
              message,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Visibility(
              visible: Navigator.canPop(context),
              child: TextButton(
                child: Text(
                  "Close",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
