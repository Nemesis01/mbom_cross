import 'package:flutter/material.dart';

enum Menu {
  Home,
  Smartphones,
  Tablets,
  Accessories,
  Cart,
  Favourites,
  Inbox,
  Settings,
  About,
  My_Account,
}

const Duration _kExpand = Duration(milliseconds: 300);

class ExpansionMenu extends StatefulWidget {
  //
  final Menu menu;
  final Widget trailing;
  final List<Widget> children;
  final ValueChanged<bool> onExpansionChanged;
  final Color backgroundColor;
  final bool initiallyExpanded;

  //
  const ExpansionMenu({
    Key key,
    @required this.menu,
    this.trailing,
    this.children = const <Widget>[],
    this.onExpansionChanged,
    this.backgroundColor,
    this.initiallyExpanded = false,
  })  : assert(menu != null),
        assert(initiallyExpanded != null),
        super(key: key);

  @override
  _ExpansionMenuState createState() => _ExpansionMenuState();
}

class _ExpansionMenuState extends State<ExpansionMenu>
    with TickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _headerColor;
  ColorTween _iconColor;
  ColorTween _backgroundColor;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation = new CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _easeInAnimation = new CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _headerColor = ColorTween();
    _backgroundColor = ColorTween();
    _iconColor = ColorTween();
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _headerColor
      ..begin = theme.textTheme.subhead.color
      ..end = theme.accentColor;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Container(
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.children,
                //mainAxisSize: MainAxisSize.max,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded)
        _controller.forward();
      else
        _controller.reverse().then<void>((value) {
          setState(() {});
        });
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    final Color titleColor = _headerColor.evaluate(_easeInAnimation);

    return Container(
      decoration: BoxDecoration(
        color:
            _backgroundColor.evaluate(_easeOutAnimation) ?? Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(
              color: _iconColor.evaluate(_easeInAnimation),
            ),
            child: GestureDetector(
              onTap: _handleTap,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(color: titleColor),
                      child: Text(widget.menu.toString()),
                    ),
                    SizedBox(width: 24.0),
                    widget.trailing ??
                        RotationTransition(
                          turns: _iconTurns,
                          child: Icon(Icons.expand_more),
                        ),
                  ],
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
