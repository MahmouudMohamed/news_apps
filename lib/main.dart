import 'package:flutter/material.dart';
import 'package:news_app/splash.dart';

import 'home/home_screen.dart';
import 'home/news/news_details.dart';
import 'my_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MyThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        SplashScreen.routeName:(context)=>SplashScreen(),
        NewsDetails.routeName:(context)=>NewsDetails(),
      },
    );
  }
}
