import 'package:flutter/material.dart';  
import 'dart:async';
import 'dart:convert';
import 'project.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class timerPage extends StatefulWidget {  
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<timerPage> {
  var token,jsondata, comp, project, compnyid, projectid, tjsondata, weeklength, index =0, proj = 0, date, time;
  List companies = [];
  Map<String, dynamic> jsond;
  String valuee = 'Segno Tech';
  final storage = new FlutterSecureStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  var datee = new DateTime.now().toString();
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async{
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    var response = await http.get("https://testing.timestint.com/tsapi/v1/company/",headers: <String,String>{'authorization':"Token "+token});
    jsondata = json.decode(response.body);
    comp = jsondata['results'];
    for (int i=0;i< comp.length;i++) {
      companies.add(comp[i]['name']);                      // companies name
    }
    setState(() { token; jsondata; TimeData(); });
  }
  Future<String> TimeData() async{
    var response = await http.get("https://testing.timestint.com/tsapi/v1/week/", headers: <String, String>{'authorization':"Token "+token});
    tjsondata = json.decode(response.body);
    if(tjsondata['results'].length == 0){ }
    else{
      date = tjsondata['results'][0]['today_date']['current_day'] +" "+ tjsondata['results'][0]['today_date']['current_date'].toString();
      time = tjsondata['results'][0]['today_date']['current_day_time'];
      var week = tjsondata['results'][0]['current_week'];
      weeklength = (week.length);
    }
    setState(() { tjsondata; });
  }
  Future<String> compData(int compnyid) async{
    var response = await http.get("https://testing.timestint.com/tsapi/v1/project/?company="+compnyid.toString(), headers: <String, String>{'authorization':"Token "+token});
    jsond = json.decode(response.body);
    proj = jsond['count'];
    for(int x=0;x< jsond.length; x++){
      setState((){
        project = (jsond['results'][x]['title']);
      });
    }
    setState(() { token; jsond; project; });    
  }
  @override  
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    print('size: ${deviceInfo.size}');
    print('padding: ${deviceInfo.padding}'); 
    List<String> prodata = [project];
    return new Scaffold(
      drawer: NavDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(iconTheme: new IconThemeData(color: Colors.blue), backgroundColor: Colors.white, elevation: 0.0),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Column(children: <Widget>[
            Row(children: [
              Container( padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(date ?? datee.substring(0,10), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ]),
            Row(children: [
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.symmetric(horizontal: 78.0,vertical: 0),
                height: 160,
                decoration: BoxDecoration( color: Colors.blue),
                child: Center(child: Text(time ?? '00:00', style: TextStyle(color: Colors.white, fontSize: 65))),
              ),
            ]),
            if(weeklength != null && weeklength != 0 && weeklength != '')
            if(tjsondata != null)
            Row(children: <Widget>[
              Container(
                height: 50,  width: 344,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weeklength ?? '7',
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) =>
                  Container(
                    width: 40.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Text(tjsondata['results'][0]['current_week'][i]['current_week'].toString().substring(8) ?? 'default', style: TextStyle(fontSize: 15)),
                      Text(tjsondata['results'][0]['current_week'][i]['day'].toString() ?? 'default', style: TextStyle(fontSize: 13)),
                      Text(tjsondata['results'][0]['current_week'][i]['day_time'].toString() ?? 'default', style: TextStyle(fontSize: 13)),
                    ]),
                  ),
                ),
              ),
            ]),
            Row(children: [
              Padding(padding: EdgeInsets.fromLTRB(15,0, 0, 0),),
              Container(
                width: 330,
                padding: EdgeInsets.fromLTRB(0,10, 0, 0),
                child: DropdownButton(
                  isExpanded: true,
                  onChanged: (String changedValue) {
                    valuee=changedValue;
                    setState(() {
                      valuee;                    
                      compnyid = (comp[companies.indexOf(valuee)]['id']);
                    });
                    compData(compnyid);
                  },
                  value: valuee,
                  style: new TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  items: companies.map(
                    (item) {
                      return new DropdownMenuItem<String>(
                        value: item,
                        child: new Text(item ?? 'default'),
                      );
                    },
                  ).toList(),
                ),
              ),
            ]),
            if(jsond != null) 
            Column(children: [
              Container(
                child: Column(
                  children: List.generate(proj, (index) {
                    scrollDirection: Axis.horizontal;
                    return RaisedButton(
                      color: Colors.white, elevation: 0.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => projectPage(projectid:jsond['results'][index]['id']),
                          ),
                        );
                        _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(duration: new Duration(seconds: 4), content:
                            new Row( children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("  Please wait")
                            ]),
                          ),
                        );
                      },
                      child: Row(children: <Widget>[
                        Image.asset('assets/images/st-1024-logo.png', width: 20, height: 20),
                        Column(children: [
                          Text(jsond['results'][index]['title'].toString() ?? 'default', overflow: TextOverflow.ellipsis, maxLines: 3),
                        ]),
                      ]),                
                    );
                  }),
                ),
              ),                
            ]),
          ]),
        ),
      ),
    );
  }
}