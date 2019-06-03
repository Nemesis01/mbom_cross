import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbom/custom/menu_item.dart';
import 'package:mbom/models/product.dart';
import 'package:mbom/views/backdrop.dart';
import 'package:mbom/views/page_presentation.dart';
import 'package:mbom/views/view_menu.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreen createState() => new _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  //
  Category _currentCategory = Category.ALL;
  Menu _currentMenu = Menu.Smartphones;
  String _title = Menu.Home.toString().split('.')[1];

  void _changeTitle(Object o) {
    setState(() {
      _title = o.toString().split('.')[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    //_setStatusBarColor(context);
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Center(
        child: BackDrop(
          currentCategory: _currentCategory,
          currentMenu: _currentMenu,
          frontLayer: PresentationPage(),
          backLayer: MenuPage(
            currentMenu: _currentMenu,
            onMenuSelected: _onMenuSelected,
          ),
          frontTitle: Text(_title),
          backTitle: Text('Menu'),
        ),
      ),
    );
  }

  void _onMenuSelected(Menu menu) {
    setState(() {
      _currentMenu = menu;
      _changeTitle(menu);
    });
  }

  void _setStatusBarColor(BuildContext context) {
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    });
  }
}
