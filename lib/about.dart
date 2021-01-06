import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';

class aboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<aboutPage> {
  @override  
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,
        title: Text('About Us', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0)),
          Image.asset('assets/images/TS-long-logo-400.png',width: 200, height: 80),
          Container(padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0)),
          Column(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(150,0,0,0)),
            Text('Version', style: TextStyle(fontSize: 20)),
            Padding(padding: EdgeInsets.fromLTRB(145, 0, 0, 0)),
            Text('2.4.5 Live', style: TextStyle(fontSize: 20)),
          ]),
          Column(children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20,50,20,0),
              child: Text('Lorum ipsum dolor sit amet, consesec tur adipiscing elit, sit do eisomud temp poibx trsja ijws vcjf rtrn watf hell edjiyw howe iouds poiuy bnvmx heydts zxsed mnbv jiuyt lkas hdhwiwe jheuu Lorum ipsum dolor amet, bnvmx elit, sit do eisomud temp', overflow: TextOverflow.ellipsis, maxLines: 8 ,style: TextStyle(fontSize: 20)),
            ),
          ]),
        ]),
      ),
    );
  }
}