import 'package:flutter/material.dart';  
import 'dart:async';
import 'dart:convert';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class screenshotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<screenshotPage> {
  var token, jsondata, result, nexturl= "https://testing.timestint.com/tsapi/v1/screenshot/", proj = 0;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    this._loadData();
  }
  Future<String> getData(url) async{
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    var response = await http.get(url, headers: <String, String>{'authorization':"Token "+token});
    jsondata = json.decode(response.body);
    proj = jsondata['count'];
    result = jsondata['results'];
    nexturl = jsondata['next'];
    setState(() { token; jsondata; });
  }
  List items = [];
  bool isLoading = false;
  Future _loadData() async {
    try{
      if(nexturl != null){
        getData(nexturl);
        await new Future.delayed(new Duration(seconds: 2));
        setState(() {
          items.addAll(result);
          isLoading = false;
        });
      }
      if(nexturl == null){
        setState(() { isLoading = false; });
      }
    }catch(error) { print(error); }
  }
  @override  
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);  
    return new Scaffold(
      drawer: new NavDrawer(),
      appBar: new AppBar( iconTheme: new IconThemeData(color: Colors.blue), backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,  title: Text('ScreenShots', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      body: new Column(children: <Widget>[
        new Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                _loadData();
                setState(() {  isLoading = true;  });
              }
            },
            child: new GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.fromLTRB(0,10,0,10),
              children: List.generate(items.length, (i) {
                return Center(
                  child: Card(
                    elevation: 100,
                    child: Container(
                      width: 170.0,
                      child: Column(children: <Widget>[
                        if(jsondata != null)
                        Column(children: [
                          Text(items[i]['cmpny'] ?? 'default'),
                          Image.network(items[i]['image'], width:140 ?? 'default'),
                          Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(8,0,0,0),
                              child: new Text(items[i]['time'].toString().substring(11,19) ?? 'default', style: TextStyle(color: Colors.grey)),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(30,0,0,0),
                              child: new Text(items[i]['time'].toString().substring(0,10) ?? 'default', style: TextStyle(color: Colors.grey)),
                            ),
                          ]),
                          Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(15,0,0,0),
                              child: Text('keyboard'),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(50,0,0,0),
                              child: Text(items[i]['keyboard'].toString() ?? 'default'),
                            ),
                          ]),
                          LinearPercentIndicator(width: 160.0, lineHeight: 8.0, percent: 0.5, backgroundColor: Colors.grey, progressColor: Colors.yellow),
                          Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(15,0,0,0),
                              child: Text('mouse'),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(55,0,0,0),
                              child: Text(items[i]['mouse'].toString() ?? 'default'),
                            ),
                          ]),
                          LinearPercentIndicator(width: 160.0,lineHeight: 8.0, percent: 0.5,backgroundColor: Colors.grey, progressColor: Colors.blue),
                        ]),
                      ]),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        new Container(
          height: isLoading ? 50.0 : 0,
          color: Colors.transparent,
          child: Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      ]),
    );
  }
}