import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class ListPage extends StatelessWidget {
  ListPage({Key? key}) : super(key: key);
  // late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
      ),
      body: const Center(
        // child: WebView(
        //   initialUrl: 'https://www.tutorialkart.com/',
        //   javascriptMode: JavascriptMode.unrestricted,
        //   onWebViewCreated: (WebViewController webViewController) {
        //     _controller = webViewController;
        //   },
        // ),
        child: Text('List Page'),
      ),
    );
  }
}
