# ForTimeStint

## Flutter setup on local
	export PATH="$PATH:/Library/WebServer/Documents/flutter/flutter/bin"

## Open Simulator
	open -a Simulator

## make your flutter folder:
	flutter create myApp

## To see all details:
	flutter doctor

## To run flutter app:
	flutter run

## after implement in yaml file:
	flutter pub get

## after import package in amy file:
	flutter packages upgrade

## Upgrade Flutter
	flutter upgrade
	flutter pub upgrade

## for percent Indicator implement in yaml file: 
	dependencies:
		percent_indicator: "^2.1.5"

## To add assets to your application, add an assets section, like this:
	assets:
    - assets/images/

## modify .yaml file for using API:
	http: any
	shared_preferences: any  

## After update yaml file run command: 
	flutter pub get

## for use localstorage update yaml file: 
	dependencies:
		localstorage: ^3.0.0

## for use flutterSEcureStorage update yaml file: 
	dependencies:
		flutter_secure_storage: ^3.3.3

## /var/www/apps/time/ForTimeStint/android/app/build.gradle :
	 minSdkVersion 18

## For upload image, update in yaml:
	dependencies:
		image_picker: ^0.6.6+5

## Import packages, for upload image: 
	import 'package:image_picker/image_picker.dart';
	import 'package:async/async.dart';
	import 'dart:io';
	import 'package:intl/intl.dart';
	import 'package:path/path.dart';

## For change appname while create built:
## Go for path: /var/www/apps/time/ForTimeStint/android/app/main/AndroidManifest.xml
	<application
		android:label="appname"

## Update in yaml, For App logo change:
	dev_dependencies:
		flutter_launcher_icons: "^0.8.1"
	flutter_icons:
	  image_path: "assets/images/256.png" 
	  android: true
	  ios: true
## Run command after update in yaml, for main logo change:
	flutter pub get
	flutter pub run flutter_launcher_icons:main

## For animation Toggle, update in yaml:
	dependencies
		lite_rolling_switch: ^0.1.1
## And Packages: 
	import 'package:lite_rolling_switch/lite_rolling_switch.dart';

## For dropdown, add dependencies in yaml:
	dependencies
		dropdown_formfield: ^0.1.3
	import 'package:dropdown_formfield/dropdown_formfield.dart';