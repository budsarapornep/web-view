import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  _WebViewContainerState(this._url);
  final _key = UniqueKey();
  WebViewController controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  Future<bool> _onWillPop(BuildContext context) async {
    print("onwillpop");
    if (await controller.canGoBack()) {
      controller.goBack();
    } else {
      // exit(0); //io
      print('back');
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('กลับไปหน้าเมนู URL'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ไม่'),
                  ),
                  FlatButton(
                    onPressed: () {
                      // SystemNavigator.pop(); //service
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text('ใช่'),
                  ),
                ],
              ));
      return Future.value(false);
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(),
  //       body: Column(
  //         children: [
  //           Expanded(
  //               child: WebView(
  //                   key: _key,
  //                   javascriptMode: JavascriptMode.unrestricted,
  //                   initialUrl: _url))
  //         ],
  //       ));
  // }

  //webview handle
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // title: Text("Sample"),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController c) {
            _controllerCompleter.future.then((value) => controller = value);
            _controllerCompleter.complete(c);
          },
        ),
      ),
    );
  }
}
