import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_collections/widgets/bottom_navigationBar.dart';
import 'dart:math';
import '../main.dart';
import 'page_coming_soon.dart';
import 'page_login.dart';
import 'page_profile.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'page_search.dart';
import 'page_settings.dart';
import 'page_signup.dart';

class HomePage extends StatefulWidget {
  String email;
  String location;
  HomePage({this.email, this.location});
  @override
  _HomePageState createState() => _HomePageState(email, location);
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String email;
  String location;
  _HomePageState(this.email, this.location);
  int currentTab = 0;
  PageController pageController;
  _changeCurrentTab(int tab) {
    //Changing tabs from BottomNavigationBar
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          colorCurveSecondary, //or set color with: Color(0xFF0000FF)
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: bodyView(currentTab),
          bottomNavigationBar:
              BottomNavBar(changeCurrentTab: _changeCurrentTab)),
    );
  }

  bodyView(currentTab) {
    List<Widget> tabView = [];
    //Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
        //Dashboard Page
        tabView = [SearchPage(email: email)];
        break;
      case 1:
        //Search Page
        tabView = [PageComingSoon()];
        break;
      case 2:
        //Profile Page
        tabView = [ProfilePage(email: email)];
        break;
      case 3:
        //Setting Page
        tabView = [SettingPage()];
        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}
