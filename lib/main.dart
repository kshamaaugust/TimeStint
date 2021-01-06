import "package:flutter/material.dart";
import 'splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  	return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
		    return MaterialApp(
		      debugShowCheckedModeBanner: false,
		      theme: ThemeData(primarySwatch: Colors.blue), home: Splash()
		    );
		  },
		);
	  },
	);
  }
}
class SizeConfig { 
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
        print(_screenWidth);
        print(_screenHeight);
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;
    print(_blockSizeHorizontal);
    print(_blockSizeVertical);
  }
}