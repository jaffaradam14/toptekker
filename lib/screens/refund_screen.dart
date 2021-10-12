import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../AppColors.dart';

class RefundPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Tekker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RefundPolicyPage extends StatefulWidget {
  RefundPolicyPage({required this.value});

  final String value;

  @override
  RefundPolicyPageState createState() {
    return new RefundPolicyPageState();
  }
}

class RefundPolicyPageState extends State<RefundPolicyPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
        centerTitle: false,
        title: Text('TopTekker'),
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          if ('${widget.value}' == "refund") {
            _loadHtmlFromAssets('assets/html/refund_policy.html');
          }else if ('${widget.value}' == "about_us") {
            _loadHtmlFromAssets('assets/html/about_us.html');
          }else if ('${widget.value}' == "contact_us") {
            _loadHtmlFromAssets('assets/html/contactus.html');
          }else if ('${widget.value}' == "terms_condition") {
            _loadHtmlFromAssets('assets/html/terms_condition.html');
          }else if ('${widget.value}' == "privacy") {
            _loadHtmlFromAssets('assets/html/privacy_policy.html');
          }
        },
      ),
    );
  }

  _loadHtmlFromAssets(String url) async {
    String fileText =
        await rootBundle.loadString(url);
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
