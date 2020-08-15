import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flexible & Expanded Deep Dive'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 100,
              child: Text('Item 1'),
              color: Colors.red,
            ),
            // Flexible(
            //   // flex: 1, default value
            //   // it takes the double size og orange container
            //   flex: 5,
            //   fit: FlexFit.tight,
            //   child: Container(
            //     height: 100,
            //     // width: 100,
            //     child: Text('Item 2'),
            //     color: Colors.blue,
            //   ),
            // ),
            // Expanded always fit value
            Expanded(
              // flex: 1, default value
              flex: 5,
              child: Container(
                height: 100,
                // width: 100,
                child: Text('Item 2'),
                color: Colors.blue,
              ),
            ),
            Flexible(
              flex: 1,
              // fit: FlexFit.tight,
              // loose means takea as much needed
              fit: FlexFit.loose,
              child: Container(
                height: 100,
                child: Text('Item 3'),
                color: Colors.orange,
              ),
            )
          ],
        ),
      ),
    );
  }
}
