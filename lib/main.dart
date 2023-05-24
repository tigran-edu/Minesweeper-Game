import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:saper/pages/initial_page.dart';
import 'package:saper/stuffs/providers/flag_provider.dart';
import 'package:saper/stuffs/providers/theme_provider.dart';
import 'package:saper/tests.dart';
import 'package:saper/research/statistics.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
      ChangeNotifierProvider<FlagProvider>(create: (context) => FlagProvider()),
    ],
    child: const MaterialApp(
      home: InitialPage(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
