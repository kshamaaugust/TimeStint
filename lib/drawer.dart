import 'package:flutter/material.dart';  
import 'dart:async';
import 'dart:convert';
import 'timer.dart';
import 'screenshots.dart';
import 'login_screen.dart';
import 'profile.dart';
import 'dashboard.dart';
import 'about.dart';
import 'report.dart';
import 'setting.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NavDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<NavDrawer>{
  var image, jsonLogin, first, mail;
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
    mail = jsonLogin['email'];
    first = jsonLogin['first_name'];
    setState(() { jsonLogin; }); 
  }
  @override  
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);  
    return Drawer(
      child: new ListView( children: <Widget>[
        new UserAccountsDrawerHeader(
          currentAccountPicture: new GestureDetector(
            onTap: () =>  Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => profilePage()),  
            ) ,
            child: new CircleAvatar(
              backgroundImage: new NetworkImage(image ?? 'default'),
            ),
          ),
          decoration: BoxDecoration(color: Colors.white),
          accountName: new Text(first ?? 'default', style: TextStyle(color: Colors.black)),
          accountEmail: new Text(mail ?? 'default', style: TextStyle(color: Colors.blue)),
        ),
        new ListTile(  
          title: Text('Timer', style: TextStyle(color: Colors.black, fontSize: 15)),
          contentPadding: EdgeInsets.symmetric(horizontal: 35.0), 
          onTap: () => Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => timerPage()),  
          ), 
        ),
        new ListTile(  
          title: Text('Dashboard', style: TextStyle(color: Colors.black, fontSize: 15)),
          contentPadding: EdgeInsets.symmetric(horizontal: 35.0),  
          onTap: () =>  Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => dashboardPage()),  
          ),
        ),
        new ListTile(  
          title: Text('Report', style: TextStyle(color: Colors.black, fontSize: 15)),  
          contentPadding: EdgeInsets.symmetric(horizontal: 35.0),  
          onTap: () => Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => reportPage()),  
          ),
        ),
        new ListTile(  
          title: Text('Screenshots', style: TextStyle(color: Colors.black, fontSize: 15)), 
          contentPadding: EdgeInsets.symmetric(horizontal: 35.0),
          onTap: () => Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => screenshotPage()),  
          ),   
        ),    
        new ListTile(  
          title: Text('About', style: TextStyle(color: Colors.black, fontSize: 15)), 
          contentPadding: EdgeInsets.symmetric(horizontal: 35.0),  
          onTap: () => Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => aboutPage()),  
          ),
        ),
        new ListTile(  
          title: Text('Settings', style: TextStyle(color: Colors.black, fontSize: 15)), 
          contentPadding: EdgeInsets.symmetric(horizontal: 35.0),  
          onTap: () => Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => settingPage()),  
          ),
        ),        
        new Divider(), 
        new ListTile(  
          leading: Icon(Icons.power_settings_new, color: Colors.black),
          title: Text('Logout', style: TextStyle(color: Colors.black, fontSize: 20)),
          onTap: () => Navigator.push(  
            context,  
            MaterialPageRoute(builder: (context) => LoginPage()),  
          ), 
        ), 
      ]),
    );
  }
} 