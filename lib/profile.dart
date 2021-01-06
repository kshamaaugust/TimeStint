import 'package:flutter/material.dart';  
import 'dart:async';
import 'drawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

class profilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}
class _State extends State<profilePage>{
  var jsonLogin, token, id, first, last, mobile, gender, jsonData;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    this.proData();
  }
  proData() async{
    var readData   = await storage.read(key: 'loginData');
    jsonLogin  = json.decode(readData);
    token = jsonLogin['token'];
    id    = (jsonLogin['id'].toString());
    first = await storage.read(key: 'first_name');  
    last  = await storage.read(key: 'last_name');
    mobile = await storage.read(key: 'mobile');
    gender = await storage.read(key: 'gender');
    var response = await http.get("https://testing.timestint.com/tsapi/v1/users/"+id+"/", headers: <String, String>{'authorization':"Token "+token});
    jsonData = json.decode(response.body);
    await storage.write(key: 'image', value: jsonData['image']);
    setState((){ token; jsonLogin; jsonData; });
  }
  @override  
  Widget build(BuildContext context){
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Scaffold(
      drawer: NavDrawer(),
  	  appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue), backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,                                           title: Text('Profile', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
        actions: <Widget>[
  		    IconButton(icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => _editProfile()),  
            ),
  		    ),
	      ],
      ),
      body: Center(
        child: new SingleChildScrollView(
          child: Column(children: <Widget>[
            if(jsonData != null)
            if(jsonLogin != null)
            Column(children: <Widget>[
            	Column(children: [
          	    Container(
          	      padding: EdgeInsets.fromLTRB(0,20,0,0), width: 280, height: 200,
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(jsonData['image'].toString() ?? 'default'),
                  ),
                ),
          	    Container(
          	    	padding: EdgeInsets.fromLTRB(0,10,0,0),
          	      child: Center(child: new Text(first ?? 'default', style: TextStyle(fontSize: 20))),
          	    ),
          	    Container(
          	      child: Center(child: new Text(jsonLogin['email'].toString() ?? 'default', style: TextStyle(color: Colors.blue, fontSize: 18))),
          	    ),
          	  ]),
              SizedBox(height: 25),
              Row(children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),),
                new Text('First Name  : ', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.fromLTRB(20,0,0,0),),
                new Text(first ?? 'default', style: TextStyle(fontSize: 17)),
              ]),
              Container(padding: EdgeInsets.fromLTRB(0,25,0,0)),
              Row(children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),),
                new Text('Last Name  : ', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.fromLTRB(20,0,0,0),),
                new Text(last ?? 'default', style: TextStyle(fontSize: 17)),
              ]),
              SizedBox(height: 25),
              Row(children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: new Text('Username   :', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                ),
                Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(26, 0, 0, 0),
                    child: Center(child: new Text(jsonLogin['username'].toString() ?? 'default', overflow: TextOverflow.ellipsis, maxLines: 3,style: TextStyle(fontSize: 17))),
                  ),
                ]),
              ]),
              SizedBox(height: 25),
              Row(children: <Widget>[
          	    Container(
          	    	padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          	    	child: new Text('Email  :', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          	    ),
                Column(children: [
            	    Container(
            	    	padding: EdgeInsets.fromLTRB(68, 0, 0, 0),
            	    	child: new Text(jsonLogin['email'].toString() ?? 'default', overflow: TextOverflow.ellipsis, maxLines: 3,style: TextStyle(fontSize: 17)),
            	    ),
                ]),
              ]),
              SizedBox(height: 25),
              Row(children: [
                Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),),
                new Text('Gender  :', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.fromLTRB(50,0,0,0),),
                new Text(gender ?? 'default', style: TextStyle(fontSize: 17)),
              ]),
              SizedBox(height: 25),
            	Row(children: [
        	    	Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),),
        	    	new Text('Phone No.  :', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        	    	Padding(padding: EdgeInsets.fromLTRB(20,0,0,0),),
        	    	new Text(mobile ?? 'default', style: TextStyle(fontSize: 17)),
          	  ]),
            ]),
          ]),
        ),
      ),
    );
  }
}
class _editProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}
class _ProfileState extends State<_editProfile>{  
  var jsonLogin, first, id, last, mail, user, mobile, token, gender, jsondata;
  File _image;
  final storage = new FlutterSecureStorage();
  TextEditingController fnameController; 
  TextEditingController lnameController; 
  TextEditingController genderController;
  TextEditingController noController;    
  @override
  void initState() {
    super.initState();
    this.getData();
  }
  Future<String> getData() async{ 
    var readData   = await storage.read(key: 'loginData');
    jsonLogin  = json.decode(readData);
    mail  = jsonLogin['email'];
    first = await storage.read(key: 'first_name');
    last  = await storage.read(key: 'last_name');
    mobile = await storage.read(key: 'mobile');
    gender = await storage.read(key: 'gender');
    setState(() { jsonLogin; });
    fnameController  = TextEditingController(text: first);
    lnameController  = TextEditingController(text: last);
    noController     = TextEditingController(text: mobile);
    genderController = TextEditingController(text: gender);
  }
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50
    );
    setState(() { _image = image; });
  }
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
    );
    setState(() { _image = image; });
  }
  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(children: <Widget>[
              new ListTile( title: new Text('Gallery')),
              new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text('Photo Library'),
                onTap: () { _imgFromGallery();  Navigator.of(context).pop(); },
              ),
              new ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text('Camera'),
                onTap: () { _imgFromCamera();  Navigator.of(context).pop(); },
              ),
              new ListTile(
                leading: new Icon(Icons.cancel),
                title: new Text('Cancel'),
                onTap: () { Navigator.of(context).pop(); },
              ),
            ]),
          ),
        );
      }
    );
  }
  proData(String first_name, String last_name, String new_gender, String new_mobile, File imageFile) async { 
    var readData   = await storage.read(key: 'loginData');
    var jsonLogin  = json.decode(readData);
    id    = (jsonLogin['id'].toString());
    token = jsonLogin['token'];
    setState(() { token; });
    fnameController  = TextEditingController(text: first);
    lnameController  = TextEditingController(text: last);
    noController     = TextEditingController(text: mobile);
    genderController = TextEditingController(text: gender);

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://testing.timestint.com/tsapi/v1/users/"+id+"/");
    Map<String, String> headers = { "authorization": "Token " +token};
    var request = new http.MultipartRequest("patch", uri);
    request.headers.addAll(headers);
    request.fields['first_name']= first_name;
    request.fields['last_name'] = last_name;
    request.fields['gender']    = new_gender;
    request.fields['mobile']    = new_mobile;
    var multipartFile = new http.MultipartFile('image', stream, length,
      filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) { print(value); });
    var phone  = (request.fields['mobile']);
    var fn     = (request.fields['first_name']);
    var ln     = (request.fields['last_name']);
    var gvalue = (request.fields['gender']);
    await storage.write(key: 'first_name' , value: fn);
    await storage.write(key: 'mobile'     , value: phone.toString());
    await storage.write(key: 'last_name'  , value: ln);
    await storage.write(key: 'gender'     , value: gvalue);
    if(response.statusCode == 200){
      AlertDialog alert = AlertDialog(  
        title: new Text("Simple Alert"),  
        content: new Text("Data submitted successfully."),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.push(
              this.context,
              MaterialPageRoute(builder: (context) => profilePage()),
            ),
            color: Colors.blue,
            child: const Text('Okay'),
          ),
        ],    
      ); 
      showDialog(  
        context: this.context,  
        builder: (BuildContext context) {  
          return alert;  
        },  
      );
    }
    setState(() { token; request.fields; });
  }
  @override  
  Widget build(BuildContext context){
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue), backgroundColor: Colors.transparent, bottomOpacity: 0.0, elevation: 0.0,
        title: Text('Update Profile', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: new Center(
        child: ListView(children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(this.context);
              },
              child: CircleAvatar(
                radius: 55,
                child: _image != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(_image, width: 100, height: 100, fit: BoxFit.fitHeight),
                )
                : Container(
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),
                  width: 100,height: 100,
                  child: Icon(Icons.camera_alt,color: Colors.grey[800]),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0,10,0,0),
            child: Center(child: new Text(first ?? 'default', style: TextStyle(color: Colors.black, fontSize: 20))),
          ),
          Container(
            child: Center(child: new Text(mail ?? 'default', style: TextStyle(color: Colors.blue, fontSize: 18))),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 20.0),
            child: TextField(
              controller: fnameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 20.0),
            child: TextField(
              controller: lnameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 20.0),
            child: TextField(
              controller: genderController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
              ),
            ),
          ),
          Container( padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 20.0),
            child: TextField(
              controller: noController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
              ),
            ),
          ),
          Container(
            width: 180.0, height: 70.0,
            padding: EdgeInsets.symmetric(horizontal:100.0, vertical:10.0),
            child: RaisedButton(
              color: Colors.blue, 
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(35.0)),
              child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 22),),
              onPressed: () => proData(fnameController.text, lnameController.text, genderController.text, noController.text, File(_image.path)),
            ),  
          ),
        ]),  
      ),
    );
  } 
} 