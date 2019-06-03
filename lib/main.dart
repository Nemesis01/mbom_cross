import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbom/views/screen_home.dart';
import 'package:mbom/views/screen_login.dart';
import 'package:mbom/views/screen_register.dart';

import 'models/product.dart';

void main() => runApp(MbomApp());

class MbomApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MbomAppState createState() => _MbomAppState();
}

class _MbomAppState extends State<MbomApp> {
  Category _currentCategory = Category.ALL;

  @override
  Widget build(BuildContext context) {
    // The following provides a way to change the status bar properties
    // like Color or Brightness.

    if (Navigator.canPop(context)) Navigator.pop(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.white,
        //backgroundColor: Colors.blueAccent,
        fontFamily: "EncodeSansCondensed",
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          //textTheme: TextTheme(),
        ),
        textTheme: TextTheme(
          display1: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black),
          display2: TextStyle(fontSize: 26.0, color: Colors.black),
          display3: TextStyle(),
          display4: TextStyle(),
          headline: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
          title: TextStyle(fontSize: 24.0),
          subhead: TextStyle(),
          body1: TextStyle(),
          body2: TextStyle(fontSize: 16.0),
          caption: TextStyle(),
          button: TextStyle(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w500),
          subtitle: TextStyle(),
          overline: TextStyle(),
        ),
        primaryTextTheme: TextTheme(
          headline: TextStyle(fontSize: 36.0),
          title: TextStyle(fontSize: 24.0),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          minWidth: 100.0,
          buttonColor: Colors.blueAccent,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          splashColor: Colors.lightBlueAccent,
        ),
        buttonColor: Colors.blueAccent,
      ),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  void _onCategorySelected(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(settings, new LoginScreen());
      case '/login':
        return _buildRoute(settings, new LoginScreen());
      case '/register':
        return _buildRoute(settings, new RegisterScreen());
      case '/home':
        return _buildRoute(settings, new HomeScreen());
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      builder: (BuildContext context) => builder,
      settings: settings,
      fullscreenDialog: true,
    );
  }
}
