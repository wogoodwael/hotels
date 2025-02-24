import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class UpgradeExperienceScreen extends StatelessWidget {
  const UpgradeExperienceScreen({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Upgrade your experience",
        ),
        elevation: 0,
      ),
      body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(url),),
          initialOptions: InAppWebViewGroupOptions(
            ios: IOSInAppWebViewOptions(
              allowsInlineMediaPlayback: true,
            ),
          ),
          onWebViewCreated: (controller) {
            print("WebView Created!");
          },
          onUpdateVisitedHistory: (controller, url, isReload) {
            print("Visited: $url");
          },
        )
    );
  }
}
