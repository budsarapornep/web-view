import 'package:flutter/material.dart';
import 'web_view_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _value = 1;
  final _urlText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Web view"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 20.0),
              child: DropdownButton(
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("https://"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("http://"),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0, bottom: 10.0, right: 20.0),
                child: TextField(
                  controller: _urlText,
                )),
            Container(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15.0),
                  child: Text(
                    'Summit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    var http;
                    if (_value == 1) {
                      http = "https://";
                      print(http + _urlText.text);
                      _handleURLButtonPress(context, http + _urlText.text);
                    } else {
                      http = "http://";
                      print(http + _urlText.text);
                      _handleURLButtonPress(context, http + _urlText.text);
                    }
                  },
                ))
          ],
        ));
  }
}
// class Home extends StatelessWidget {
//   final _links = ['https://camellabs.com'];

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//         body: SafeArea(
//             child: SingleChildScrollView(
//                 child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[

//       ],
//       // children: _links.map((link) => _urlButton(context, link)).toList(),
//     ))));
//   }

//   Widget _urlButton(BuildContext context, String url) {
//     return Container(
//         padding: EdgeInsets.all(20.0),
//         child: FlatButton(
//           color: Theme.of(context).primaryColor,
//           padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
//           child: Text(url),
//           onPressed: () => _handleURLButtonPress(context, url),
//         ));
//   }

void _handleURLButtonPress(BuildContext context, String url) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WebViewContainer(url)));
}
// }
