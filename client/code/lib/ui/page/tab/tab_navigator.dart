import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ving/generated/i18n.dart';

import 'home_page.dart';
import 'message_page.dart';
import 'discover_page.dart';
import 'user_page.dart';
import 'cinema_page.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController = PageController();
  int _selectedIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(I18n.of(context).tabHome),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text(I18n.of(context).tabDiscover),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            title: Text(I18n.of(context).cinema),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text(I18n.of(context).tabMsg),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(I18n.of(context).tabUser),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

List<Widget> pages = <Widget>[
  HomePage(),
  DiscoverPage(),
  CinemaPage(),
  MessagePage(),
  UserPage()
];
