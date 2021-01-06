import 'package:flutter/material.dart';  
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class dashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<dashboardPage> {
  var jsonLogin, token, jsondata, image;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{
    image = await storage.read(key: 'image');
    var readData   = await storage.read(key: 'loginData');
    jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    var response = await http.get("https://testing.timestint.com/tsapi/v1/dashboard/", headers: <String, String>{'authorization': "Token " +token});
    jsondata = json.decode(response.body);
    setState(() { token; jsondata; }); 
  }
  @override  
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue), backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,                                         title: Text('Dashboard', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(children: <Widget>[
          if(jsondata != null)
          Column(children: <Widget>[
            new UserAccountsDrawerHeader( 
              decoration: BoxDecoration(color: Colors.white),
              accountName: new Text(jsonLogin['username'] ?? 'default', style: TextStyle(color: Colors.black)),
              accountEmail: new Text(jsonLogin['email'] ?? 'default', style: TextStyle(color: Colors.blue)),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(image ?? 'default'),
                ),
              ),
            ),
            Row(children: <Widget>[
          		Padding(padding: EdgeInsets.fromLTRB(40, 0, 0, 0)),
          		Text(jsondata['created_task'].toString() ?? 'default', style: TextStyle(fontSize: 25)),
          		Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
          		Text(jsondata['assign_task'].toString() ?? 'default', style: TextStyle(fontSize: 25)),
            ]),
            Row(children: <Widget>[
          		Padding(padding: EdgeInsets.fromLTRB(40,0,0,0)),
          		Text('Created Tasks', style: TextStyle(fontSize: 10)),
          		Padding(padding: EdgeInsets.fromLTRB(65,0,0,0)),
          		Text('Total Assing Tasks', style: TextStyle(fontSize: 10)),
            ]),
            new Divider(), 
            Row(children: <Widget>[
              Container(
      		      padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 100,
                child: Card(
                	color: Colors.blueAccent[400], elevation: 50,
                	child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0,50,50,0),
                      child: Text(jsondata['ongoing_task'].toString() ?? 'default', style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,10,5),
                      child: Text('Ongoing Tasks', style: TextStyle(color: Colors.white, fontSize: 10),),
                    ),
                  ]),
                ),
              ),
              Container(
        		    padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 100,
                child: Card(
                	color: Colors.lightGreenAccent[700], elevation: 50,
                	child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0,50,50,0),
                      child: Text(jsondata['completed_task'].toString() ?? 'default', style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,10,5),
                      child: Text('Completed Tasks', style: TextStyle(color: Colors.white, fontSize: 10),),
                    ),
                  ]),
                ),
              ),
              Container(
        		    padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 100,
                child: Card(
                	color: Colors.pink,	elevation: 50,
                	child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0,50,50,0),
                      child: Text(jsondata['overdue_task'].toString() ?? 'default', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10,0,10,5),
                      child: Text('Overdue Tasks', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ]),
                ),
              ),
            ]),
            Row(children: <Widget>[
          		Padding(padding: EdgeInsets.fromLTRB(40,80,0,0)),
          		Text('Statistics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          		Padding(padding: EdgeInsets.fromLTRB(150,80,0,0)),
          		Text(jsondata['statistics']['date'].toString() ?? 'default', style: TextStyle(fontSize: 12)),
            ]),
            Row(children: <Widget>[
              Container(
              	padding: EdgeInsets.all(15.0),
              	child: new Row(children: <Widget>[
                	new CircularPercentIndicator(
                    radius: 80.0, lineWidth: 6.0, percent: 0.80,
                    center: new Text(jsondata['statistics']['work'].toString() ?? 'default', style: TextStyle(fontSize: 18)),
                    progressColor: Colors.red,
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.0)),
                  new CircularPercentIndicator(
                    radius: 80.0, lineWidth: 6.0, percent: 0.50,
                    center: new Text(jsondata['statistics']['meeting'].toString() ?? 'default', style: TextStyle(fontSize: 18)),
                    progressColor: Colors.cyan,
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.0)),
                  new CircularPercentIndicator(
                    radius: 80.0, lineWidth: 6.0, percent: 0.20,
                    center: new Text(jsondata['statistics']['etc'].toString() ?? 'default', style: TextStyle(fontSize: 18)),
                    progressColor: Colors.yellow,
                  ),
                ]),
              ),
            ]),
            Row(children: <Widget>[
          		Padding(padding: EdgeInsets.fromLTRB(40,0,0,0)),
          		Text('Work', style: TextStyle(fontSize: 12)),
          		Padding(padding: EdgeInsets.symmetric(horizontal: 45.0)),
          		Text('Meeting', style: TextStyle(fontSize: 12)),
          		Padding(padding: EdgeInsets.symmetric(horizontal: 45.0)),
          		Text('Etc.', style: TextStyle(fontSize: 12)),
            ]),
          ]),
        ]),
      ),
    );
  }
}