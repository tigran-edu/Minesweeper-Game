import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:saper/State.dart';
import 'package:saper/stuffs/providers/flag_provider.dart';
import 'package:saper/stuffs/constants.dart';
import 'dart:math' as math;

import '../grid/grid.dart';
import '../stuffs/providers/theme_provider.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.complexity});

  final String complexity;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late int currentFlagCount;
  late var grid;
  BannerAd? banner;

  void createBannerAd() {
    banner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('${ad.runtimeType} loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('${ad.runtimeType} opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed');
          ad.dispose();
          createBannerAd();
          print('${ad.runtimeType} reloaded');
        },
        // Called when an ad is in the process of leaving the application.
        //onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    grid = Grid(complexity: widget.complexity);
    FlagProvider().flagInit(grid.totalMines);
    createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    int currentFlagCount = Provider.of<FlagProvider>(context).flagCount;
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
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Provider.of<FlagProvider>(context, listen: false).flagRestart();
                    Navigator.pop(context);
                  },
                  child: Transform.rotate(
                    angle: -90 * math.pi / 180,
                    child: Icon(
                      CupertinoIcons.triangle_fill,
                      color: themeColor,
                      size: 30,
                    ),
                  ),
                )
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: deviceHeight*0.07,
                  height: deviceHeight*0.06,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 4),
                    child: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              children: const [
                                Text('Вскрыть мину'),
                                Spacer(),
                                Icon(Icons.lock_open_outlined, color: kTextColorGrey,)
                              ],
                            ),
                            onTap: () {
                              
                            },
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: const [
                                Text('Обозначить шансы'),
                                Spacer(),
                                Icon(Icons.account_tree_outlined, color: kTextColorGrey,)
                              ],
                            ),
                            onTap: () {
                              
                            },
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: const [
                                Text('Случайная клетка'),
                                Spacer(),
                                Icon(Icons.radar_outlined, color: kTextColorGrey,)
                              ],
                            ),
                            onTap: () {
                              
                            },
                          ),
                        ];
                      },
                      child: const Icon(Icons.question_mark_outlined, size: 25, color: kTextColorGrey,)
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        //width: deviceWidth*0.2,
                        height: deviceHeight*0.07,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 3,),
                              const Icon(Icons.flag_outlined, color: kTextColorGrey, size: kTextSize*0.9,),
                              const SizedBox(width: 10,),
                              Text('$currentFlagCount', style: const TextStyle(color: kTextColorGrey, fontSize: kTextSize*0.9,),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: InteractiveViewer(
                      child: SaperGrid(complexity: widget.complexity,)
                    ),
                  ),
                  banner != null 
                    ? SizedBox(
                        height: banner!.size.height.toDouble(),
                        child: AdWidget(
                          ad: banner!
                        ),
                      ) 
                    : const SizedBox()
                ],
              ),
            ],
          )
        )
      )
    );
  }
}