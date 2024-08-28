// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String heading;
  String url;
  WebViewScreen({super.key, required this.heading, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.heading),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
