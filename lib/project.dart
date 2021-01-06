import 'package:flutter/material.dart';  
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';

class projectPage extends StatefulWidget {
  var projectid;
  projectPage({this.projectid}); 
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<projectPage>{
  var jsondata, token, projectid, jsonp, jsont,week, proj = 0, index =0;
  double barheight = 0;
  final storage = new FlutterSecureStorage();
  var datee = new DateTime.now().toString();
  @override
  void initState() {
    super.initState();
    proData();
  }
  Future<String> proData() async{
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    projectid = widget.projectid;
    var presponse = await http.get("https://testing.timestint.com/tsapi/v1/project/"+projectid.toString()+"/", headers: <String, String>{'authorization':"Token "+token});
    jsonp = json.decode(presponse.body);

    var tresponse = await http.get("https://testing.timestint.com/tsapi/v1/task/?project="+projectid.toString(), headers: <String, String>{'authorization':"Token "+token});
    jsont = json.decode(tresponse.body);
    proj = jsont['count'];
    setState(() { token; jsonp; jsont;  });
  }
  // Future<String> proTime() async{
  //   var response = await http.get("https://testing.timestint.com/tsapi/v1/week/", headers: <String, String>{'authorization':"Token "+token});
  //   jsondata = json.decode(response.body);
  //   week = ((jsondata['results'][0]['current_week']).length);
  //   setState(() { jsondata; });
  // }
  @override  
  Widget build(BuildContext context){
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,
        title: Text('Project', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: new SingleChildScrollView(
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            if(jsonp != null)                 
            Row(children: [
              Padding(padding: EdgeInsets.fromLTRB(10,10,0,0)),
              Image.asset('assets/images/st-1024-logo.png', width: 40, height: 30),
              Text(jsonp['companies']['name'] ?? 'default', style: TextStyle(fontSize: 18)),
            ]),
            if(jsonp != null)
            Padding(padding: EdgeInsets.fromLTRB(50,0,0,0),
              child: new Text(jsonp['title'] ?? 'default', style: TextStyle(fontSize:12)),
            ),
            if(jsondata != null)
            Padding(padding: EdgeInsets.fromLTRB(0,30,170,0),
              child: Text(jsondata['results'][0]['today_date']['current_date'] ?? datee.substring(0,10), style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 5.0),
            if(jsondata != null)
            if(week != null)
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 70, width: 360,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: week,
                  itemBuilder: (BuildContext context, int i) =>
                  Card(
                    elevation: 80,
                    child: Container(
                      width: 100.0,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
                        Text(jsondata['results'][0]['current_week'][i]['day'].toString() ?? 'day', style: TextStyle(color: Colors.blue,fontSize: 18)),
                        Text(jsondata['results'][0]['current_week'][i]['current_week'].toString() ?? 'current_week', style: TextStyle(color: Colors.blue, fontSize: 12)),
                        Text(jsondata['results'][0]['current_week'][i]['day_time'].toString() ?? '', style: TextStyle(color: Colors.blue, fontSize: 12)),
                      ]),
                    ),
                  ),
                ),
              ),
            ]),
            DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                Container(
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(child: Text("My Tasks",style: TextStyle(fontWeight: FontWeight.bold))),
                      Tab(child: Text('Team',style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Container(
                  height: 400, //height of TabBarView
                  decoration: BoxDecoration( border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                  ),
                  child: TabBarView(children: <Widget>[
                    Padding(padding: const EdgeInsets.all(10.0),
                      child: Table( children: [
                        TableRow(children: [
                          TableCell(child: Center(child: Text('START TASK', style: TextStyle(fontWeight: FontWeight.bold)))),
                          TableCell(child: Center(child: Text('TIME SPEND', style: TextStyle(fontWeight: FontWeight.bold)))),
                          TableCell(child: Center(child: Text('STATUS', style: TextStyle(fontWeight: FontWeight.bold),))),
                        ]),
                        TableRow(children: <Widget>[
                          Container(
                            child: Column(
                              children: List.generate(proj, (index) {
                                return Container(
                                  height: barheight+70,
                                  padding: EdgeInsets.fromLTRB(0,10,0,0),
                                  child: Text(jsont['results'][index]['title'].toString() ?? 'default'),
                                );
                              }),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: List.generate(proj, (index) {
                                return Container(
                                  height: barheight+70,
                                  padding: EdgeInsets.fromLTRB(0,10,0,0),
                                  child: Text(jsont['results'][index]['time'].toString() ?? 'default'),
                                );
                              }),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: List.generate(proj, (index) {
                                return Container(
                                  height: barheight+70,
                                  padding: EdgeInsets.fromLTRB(0,10,0,0),
                                  child: Text(jsont['results'][index]['status'].toString() ?? 'default', style: TextStyle(color: Colors.blue)),
                                );
                              }),
                            ),
                          ),
                        ])
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10,20,0,0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int i) =>
                        Card(
                          elevation: 0.0,
                          child: InkWell(
                            onTap: () {},
                            child: Column(children: <Widget>[
                              Row(children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10,0,0,0),
                                  height: 220, width: 200,
                                  child: Card(
                                    elevation: 10,
                                    child: Column(children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0,20,0,0)),
                                      new CircleAvatar(
                                        radius: 50,
                                        backgroundImage: new NetworkImage("http://itzmejyoti.com/images/about/IMG-4232.JPG"),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,15,20,0),
                                        child: Center(child: Text('Jyoti Yadav', style: TextStyle(fontSize: 20))),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,0,20,0),
                                        child: Text('Senoir Developer', style: TextStyle(color: Colors.blue, fontSize: 13)),
                                      ),
                                    ]),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10,0,0,0),
                                  height: 220, width: 200,
                                  child: Card(
                                    elevation: 10,
                                    child: Column(children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0,20,0,0)),
                                      new CircleAvatar(
                                        radius: 50,
                                        backgroundImage: new NetworkImage("http://itzmejyoti.com/images/about/IMG-4232.JPG"),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,15,20,0),
                                        child: Center(child: Text('Naveen Lawaniya', style: TextStyle(fontSize: 18))),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,0,20,0),
                                        child: Text('Designer', style: TextStyle(color: Colors.blue, fontSize: 13)),
                                      ),
                                    ]),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10,0,0,0),
                                  height: 220, width: 200,
                                  child: Card(
                                    elevation: 10,
                                    child: Column(children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0,20,0,0)),
                                      new CircleAvatar(
                                        radius: 50,
                                        backgroundImage: new NetworkImage("http://itzmejyoti.com/images/about/IMG-4232.JPG"),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,15,20,0),
                                        child: Center(child: Text('Jyoti Yadav', style: TextStyle(fontSize: 20))),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,0,20,0),
                                        child: Text('Senoir Developer', style: TextStyle(color: Colors.blue, fontSize: 13)),
                                      ),
                                    ]),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10,0,0,0),
                                  height: 220, width: 200,
                                  child: Card(
                                    elevation: 10,
                                    child: Column(children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(0,20,0,0)),
                                      new CircleAvatar(
                                        radius: 50,
                                        backgroundImage: new NetworkImage("http://itzmejyoti.com/images/about/IMG-4232.JPG"),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,15,20,0),
                                        child: Center(child: Text('Jyoti Yadav', style: TextStyle(fontSize: 20))),
                                      ),
                                      Container( padding: EdgeInsets.fromLTRB(20,0,20,0),
                                        child: Text('Senoir Developer', style: TextStyle(color: Colors.blue, fontSize: 13)),
                                      ),
                                    ]),
                                  ),
                                ),
                              ]),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ])
            ),
          ]),
        ),
      ),
    );
  }
}