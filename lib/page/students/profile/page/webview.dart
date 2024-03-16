import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class IyzcoWebView extends StatefulWidget {
  const IyzcoWebView({super.key, required this.url});
  final String url;
  @override
  // ignore: library_private_types_in_public_api
  _IyzcoWebViewState createState() => _IyzcoWebViewState();
}

class _IyzcoWebViewState extends State<IyzcoWebView> {
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Ödeme Sayfası ",
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            WebView(
              zoomEnabled: true,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                // if (progress == 75) {
                //   _isLoading = false;
                // }
              },
              // javascriptChannels: <JavascriptChannel>{
              //   _toasterJavascriptChannel(context),
              // },
              onPageFinished: (String url) {
                setState(() {
                  _isLoading = false;
                });
              },
              gestureNavigationEnabled: true,
              geolocationEnabled: true, // set geolocationEnable true or not
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
