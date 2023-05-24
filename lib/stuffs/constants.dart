import 'dart:ui';

var pixelRatio = window.devicePixelRatio;
var deviceSize = window.physicalSize / pixelRatio;
var deviceWidth = deviceSize.width;
var deviceHeight = deviceSize.height;

const double kTextSize = 38;
const Color kTextColorGrey = Color.fromARGB(255, 116, 84, 84);

const Color kOrangeColor = Color.fromARGB(255, 255, 163, 88);
const Color kBlueColor = Color.fromARGB(255, 118, 200, 255);
const Color kGreenColor = Color.fromARGB(255, 155, 255, 188);

const Color kColorBackGround1 = Color.fromARGB(255, 193, 221, 246);
const Color kColorBackGround2 = Color.fromARGB(255, 16, 32, 126);
const Color kColorBackGround3 = Color.fromARGB(255, 63, 5, 60);

const List<String> complexityList = <String>[
  'test',
  'veryEasy',
  'easy',
  'normal',
  'hard',
  'veryHard',
  'death',
  'unreal',
  'ultra'
];