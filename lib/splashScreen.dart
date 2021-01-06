import 'dart:async';
import 'package:flutter/material.dart';
import 'timer.dart';
import 'login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class Splash extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<Splash> {
  final storage = new FlutterSecureStorage();
  var user;
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => getData());
  }
  getData()  async{
    var readData   = await storage.read(key: 'loginData');
    if(readData == null){
      Navigator.push(  
        this.context,  
        MaterialPageRoute(builder: (context) => LoginPage()),  
      );
    }
    var jsonLogin  = json.decode(readData);
    user  = jsonLogin['username'];
    if(user != null){
      Navigator.push(  
        this.context,  
        MaterialPageRoute(builder: (context) => timerPage()),  
      );
    }
    else{
      Navigator.push(  
        this.context,  
        MaterialPageRoute(builder: (context) => LoginPage()),  
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/256.png'),
      ),
    );
  }
}