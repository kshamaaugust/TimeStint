import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';

class reportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<reportPage> {
  @override  
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);  
    return new Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,
        title: Text('Report' ?? 'default', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Row(children: [
            Padding(padding: EdgeInsets.fromLTRB(10,10,0,0)),
            Image.asset('assets/images/st-1024-logo.png', width: 40,height: 30),
            Container(
              child: Text("compname" ?? 'default', style: TextStyle(fontSize: 18)),
            ),
          ]),
          Row(children: [
            Container(
              padding: EdgeInsets.fromLTRB(50,0, 0, 0),
              child: Text('projname' ?? 'default', style: TextStyle(fontSize: 12),),
            ),
          ]),
          Row(children: [
            Container(
              padding: EdgeInsets.fromLTRB(50, 30, 0, 0),
              child: Text('Aug 2020' ?? 'default', style: TextStyle(color: Colors.black, fontSize: 15),),
            ),
          ]),
          Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 70,
                child: Card(
                  color: Colors.blue,
                  elevation: 50,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,15,20,0),
                          child: Center(child: Text('MON', style: TextStyle(color: Colors.white, fontSize: 15),),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,0,20,0),
                          child: Text('08', style: TextStyle(color: Colors.white, fontSize: 12),),
                        ),
                      ],
                    ),
                  ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 50,             
                child: Card(
                  color: Colors.grey[400],
                  elevation: 50,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,5,20,0),
                          child: Center(child: Text('TUE', style: TextStyle(color: Colors.blue, fontSize: 15),),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,0,20,0),
                          child: Text('08', style: TextStyle(color: Colors.blue, fontSize: 12),),
                        ),
                      ],
                    ),
                  ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 50,              
                child: Card(
                  color: Colors.grey[400],
                  elevation: 50,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,5,20,0),
                          child: Center(child: Text('TUE', style: TextStyle(color: Colors.blue, fontSize: 15),),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,0,20,0),
                          child: Text('08', style: TextStyle(color: Colors.blue, fontSize: 12),),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10,0,0,0),
                height: 50,             
                child: Card(
                  color: Colors.grey[400],
                  elevation: 50,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,5,20,0),
                          child: Center(child: Text('TUE', style: TextStyle(color: Colors.blue, fontSize: 15),),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20,0,20,0),
                          child: Text('08', style: TextStyle(color: Colors.blue, fontSize: 12),),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
          ]),
          Row(
            children: [
              Container(
               padding: EdgeInsets.fromLTRB(20,30,0,0),
                 child: Text('My Tasks', style: TextStyle(color: Colors.black, fontSize: 30),),
              ),
            ],
          ), 
          Row(
            children: [
              Container(
               padding: EdgeInsets.fromLTRB(20,30,0,0),
                 child: Text('Completed', style: TextStyle(color: Colors.black, fontSize: 15),),
              ),
              Container(
               padding: EdgeInsets.fromLTRB(20,30,0,0),
                 child: Text('Overdue', style: TextStyle(color: Colors.black, fontSize: 15),),
              ),
              Container(
               padding: EdgeInsets.fromLTRB(20,30,0,0),
                 child: Text('Ongoing', style: TextStyle(color: Colors.black, fontSize: 15),),
              ),
              Container(
               padding: EdgeInsets.fromLTRB(20,30,0,0),
                 child: Text('Newtasks', style: TextStyle(color: Colors.black, fontSize: 15),),
              ),
            ],
          ),       
          new Divider(color: Colors.green),
        ]),
      ),
    );
  }
}