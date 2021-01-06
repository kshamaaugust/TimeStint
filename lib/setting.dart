import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class settingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<settingPage> {
  String myActivity;
  final formKey = new GlobalKey<FormState>();
  @override  
  void initState() {
    super.initState();
    myActivity = '';
  }
  _saveForm() {
    var form = formKey.currentState;
    setState(() { myActivity; });
  }
  @override  
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);  
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,
        title: Text('SETTINGS', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          // height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
          child: Column(children: <Widget>[
            Container( 
              child: Form(
                key: formKey,
                child: Column(
                  key: formKey,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16), 
                      child: DropDownFormField(
                        titleText: 'Company',
                        hintText: 'Default Company',
                        value: myActivity,
                        onSaved: (value) {
                          setState(() { myActivity = value; });
                        },
                        onChanged: (value) {
                          setState(() { myActivity = value; });
                        },
                        dataSource: [
                          {
                            "display": "Segno Tech",
                            "value": "Segno Tech",
                          },
                          {
                            "display": "Security Troops",
                            "value": "Security Troops",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(5,40,0,0),
                height: 250, width: 350,
                child: Card(
                  elevation: 10,
                  child: Column( children: [
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,0,0,0),
                        child: Text("E-Mail Notification", style: TextStyle(fontSize: 18)),
                      ),
                      Container(padding: EdgeInsets.fromLTRB(30,0,0,0)),
                      LiteRollingSwitch(
                        //initial value
                        value: true,
                        // textOn: 'disponible',
                        // textOff: 'ocupado',
                        colorOn: Colors.blue,
                        colorOff: Colors.grey,
                        // iconOn: Icons.done,
                        // iconOff: Icons.remove_circle_outline,
                        // textSize: 16.0,
                        onChanged: (bool state) {},
                      ),
                    ]),
                    new Divider(color: Colors.grey),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,0,0,0),
                        child: Text("Push Notification", style: TextStyle(fontSize: 18)),
                      ),
                      Container(padding: EdgeInsets.fromLTRB(30,0,0,0)),
                      LiteRollingSwitch(
                        value: true,
                        colorOn: Colors.blue,
                        colorOff: Colors.grey,
                        onChanged: (bool state) {},
                      ),
                    ]),
                    new Divider(color: Colors.grey),
                    Row(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20,0,0,0),
                        child: Text("SMS Notification", style: TextStyle(fontSize: 18)),
                      ),
                      Container(padding: EdgeInsets.fromLTRB(30,0,0,0)),
                      LiteRollingSwitch(
                        value: true,
                        colorOn: Colors.blue,
                        colorOff: Colors.grey,
                        onChanged: (bool state) {},
                      ),
                    ]),
                  ]),
                ),
              ),
            ]),
            Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(5,40,0,0),
                height: 100,
                width: 350,
                child: Card(
                  elevation: 10,
                  child: Row(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20,0,0,0),
                      child: Text("Logout From All Devices", style: TextStyle(fontSize: 18)),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(80,0,0,0)),
                    Icon(Icons.power_settings_new, color: Colors.blue),
                  ]),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}