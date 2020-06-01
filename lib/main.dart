import 'package:flutter/material.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:bedtime/AwesomeBottomNav/AwesomeBottomNavigationBar.dart';

import 'appbar.dart';
import 'settings.dart';
import 'GetUp.dart';
import 'Normal.dart';
import 'ToBed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.pink,
              primaryColor: Colors.pink[200],
              brightness: brightness,
              canvasColor: Colors.pink[200]
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bed Time',
            theme: theme,
            home: new MyHomePage(title: 'Bed Time'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int _selectedIndex = 1;
  Color circleColor;
  Color iconColor;
  Color backgroundColor;

  void _getIconColor() {
    if (Theme.of(context).brightness == Brightness.dark) {
      iconColor = Colors.white;
    } else {
      iconColor = Colors.black;
    }
  }

  void _getBackgroundColor() {
    if (Theme.of(context).brightness == Brightness.dark) {
      backgroundColor = Color.fromARGB(255, 50, 50, 50);
    } else {
      backgroundColor = Colors.white;
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getIconColor();
    _getBackgroundColor();
    return new Scaffold(
        appBar: TopBar(
          backgroundColor: backgroundColor,
          title: "Bed Time",
          child: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
        bottomNavigationBar: Container(
          child: AwesomeBottomNavigationBar(
            icons: [
              Icons.brightness_3,
              Icons.hotel,
              Icons.wb_sunny,
            ],
            iconColor: iconColor,
            circleColor: Theme.of(context).primaryColor,
            tapCallback: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              _pageController.animateToPage(_selectedIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            selectedIndex: _selectedIndex,
            bodyBackgroundColor: backgroundColor,
            
          ),
        ),
        body: Container(
          color: backgroundColor,
          child: PageView(
            children: <Widget>[GetUp(), Normal(), ToBed()],
            controller: _pageController,
            onPageChanged: (num) {
              setState(() {
                _selectedIndex = num;
              });
            },
          )
        )
    );
  }
}
