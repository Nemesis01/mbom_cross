import 'package:flutter/material.dart';
import 'package:mbom/custom/menu_item.dart';

class MenuPage extends StatelessWidget {
  //  MEMBER(S)
  final Menu currentMenu;
  final ValueChanged<Menu> onMenuSelected;
  final List<Menu> _menus = Menu.values;

  const MenuPage({
    Key key,
    @required this.currentMenu,
    @required this.onMenuSelected,
  })  : assert(currentMenu != null),
        assert(onMenuSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.only(top: 64.0),
          children:
              _menus.map((Menu menu) => _buildMenu(menu, context)).toList(),
        ),
      ),
    );
  }

  Widget _buildMenu(Menu menu, BuildContext context) {
    final String _optionString = menu.toString().split('.')[1].toUpperCase();
    final ThemeData theme = Theme.of(context);

    /* if (menu == Menu.My_Account) {
      _optionString = Strings.TEXT_LOGIN_BUTTON.toUpperCase();
      return FlatButton.icon(
        onPressed: () {},
        icon: Icon(Icons.person_outline),
        label: Text(_optionString),
      );
    }
    _optionString = */

    return InkWell(
      splashColor: Colors.blueAccent,
      onTap: () => onMenuSelected(menu),
      child: menu == currentMenu
          ? Column(
              children: <Widget>[
                SizedBox(height: 14.0),
                Text(
                  _optionString,
                  style:
                      theme.textTheme.body2.copyWith(color: theme.accentColor),
                ),
                SizedBox(height: 14.0),
                Container(
                  height: 2.0,
                  width: 70.0,
                  color: theme.accentColor,
                )
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Column(
                children: <Widget>[
                  Text(
                    _optionString,
                    style: theme.textTheme.body2,
                  ),
                ],
              ),
            ),
    );
  }
}
