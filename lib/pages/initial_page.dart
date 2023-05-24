import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saper/pages/game_page.dart';
import 'package:saper/stuffs/providers/theme_provider.dart';
import 'package:saper/stuffs/constants.dart';
import 'dart:math' as math;

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  int currentComplexityIndex = 0;
  bool startToSelectComplexity = false;

  @override
  Widget build(BuildContext context) {
    Color themeColor = Provider.of<ThemeProvider>(context).themeColor;
    Color themeBackgroundColor = Provider.of<ThemeProvider>(context).themeBackgroundColor;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: themeBackgroundColor,
            image: const DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: deviceHeight*0.72, left: deviceWidth*0.1, right: deviceWidth*0.1),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      scale: 2,
                      image: AssetImage("assets/logo_grid.png")
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: deviceHeight*0.5, left: deviceWidth*0.1, right: deviceWidth*0.1),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo_name.png")
                    )
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 9), // changes position of shadow
                            ),
                          ]
                        ),
                        child: TextButton(
                          onPressed: () {
                            startToSelectComplexity 
                              ? Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(complexity: complexityList[currentComplexityIndex],),)) 
                              : showSelectCompDialog();
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text('Start', style: TextStyle(fontSize: kTextSize, letterSpacing: 4.0,fontWeight: FontWeight.w600, color: kTextColorGrey,), textAlign: TextAlign.center,)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 9), // changes position of shadow
                            ),
                          ]
                        ),
                        child: startToSelectComplexity ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Transform.rotate(
                                angle: -90 * math.pi / 180,
                                child: IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.triangle_fill,
                                    color: kTextColorGrey,
                                  ),
                                  onPressed: () {
                                    if (currentComplexityIndex != 0) {
                                      setState(() {
                                        currentComplexityIndex--;
                                      });
                                    } else {
                                      setState(() {
                                        currentComplexityIndex = complexityList.length - 1;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(complexityList[currentComplexityIndex], style: const TextStyle(fontSize: kTextSize, letterSpacing: 1.0,fontWeight: FontWeight.w400, color: kTextColorGrey,), textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Transform.rotate(
                                angle: 90 * math.pi / 180,
                                child: IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.triangle_fill,
                                    color: kTextColorGrey,
                                  ),
                                  onPressed: () {
                                    if (currentComplexityIndex != complexityList.length - 1) {
                                      setState(() {
                                        currentComplexityIndex++;
                                      });
                                    } else {
                                      setState(() {
                                        currentComplexityIndex = 0;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ) : GestureDetector(
                          onTap: () {
                            setState(() {
                              startToSelectComplexity = true;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text('Select level', style: TextStyle(fontSize: kTextSize, letterSpacing: 4.0,fontWeight: FontWeight.w600, color: kTextColorGrey,), textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ) 
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<ThemeProvider>(context, listen: false).themeOrange();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: kOrangeColor,
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 9), // changes position of shadow
                                ),
                              ]
                            ),
                            child: SizedBox(height: 60, width: 60, 
                              child: themeColor == kOrangeColor ? const Icon(Icons.check, color: Colors.white,) : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<ThemeProvider>(context, listen: false).themeBlue();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kBlueColor,
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 9), // changes position of shadow
                                  ),
                                ]
                              ),
                              child: SizedBox(height: 60, width: 60, 
                                child: themeColor == kBlueColor ? const Icon(Icons.check, color: Colors.white,) : null,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<ThemeProvider>(context, listen: false).themeGreen();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: kGreenColor,
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 9), // changes position of shadow
                                ),
                              ]
                            ),
                            child: SizedBox(height: 60, width: 60, 
                              child: themeColor == kGreenColor ? const Icon(Icons.check, color: Colors.white,) : null,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        )
      )
    );
  }

  showSelectCompDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Для начала выберете сложность',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Ок', style: TextStyle(color: kTextColorGrey, fontSize: kTextSize*0.5),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}