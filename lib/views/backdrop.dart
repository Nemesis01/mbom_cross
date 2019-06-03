import 'package:flutter/material.dart';
import 'package:mbom/custom/menu_item.dart';
import 'package:mbom/models/product.dart';

const double flingVelocity = 2.0;

class BackDrop extends StatefulWidget {
  // Members
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  final Category currentCategory;
  final Menu currentMenu;

  // Constructor(s)
  BackDrop({
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
    @required this.currentCategory,
    @required this.currentMenu,
  })  : assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null),
        assert(currentCategory != null);

  _BackDropState createState() => new _BackDropState();
}

class _BackDropState extends State<BackDrop>
    with SingleTickerProviderStateMixin {
  //
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'backdropKey');

  AnimationController _animationController;

  //****************************************************************************
  //
  // LIFECYCLE METHODS
  //
  //****************************************************************************
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 4000),
      value: 2.0,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(BackDrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentMenu != oldWidget.currentMenu) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _animationController.fling(velocity: flingVelocity);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      backgroundColor: Theme.of(context).primaryColor.withAlpha(20),
      elevation: 0.0,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      title: _BackDropTitle(
        listenable: _animationController.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.view_stream), onPressed: () {}),
        //AnimatedIcon(icon: AnimatedIcons.list_view, progress: ),
        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    //
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;
    //
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_animationController.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            child: widget.frontLayer,
            onTap: _toggleBackdropLayerVisibility,
            //onTitleChanged: ,
          ),
        ),
      ],
    );
  }

  //****************************************************************************
  //
  bool get _frontLayerVisible {
    final AnimationStatus _animationStatus = _animationController.status;
    return _animationStatus == AnimationStatus.completed ||
        _animationStatus == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _animationController.fling(
      velocity: _frontLayerVisible ? -flingVelocity : flingVelocity,
    );
  }
}

class _FrontLayer extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  //final ValueChanged<String> onTitleChanged;

  const _FrontLayer({
    Key key,
    //this.title,
    this.child,
    this.onTap,
    //@required this.onTitleChanged,
  }) : //assert(onTitleChanged != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0), // 24.0
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Stack(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                child: child,
              ),
            ],
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          //Text('BLABLA', style: Theme.of(context).textTheme.title),
        ],
      ),
    );
  }
}

class _BackDropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackDropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;
    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      child: Row(
        children: <Widget>[
          // Branded icon
          SizedBox(
            width: 72.0,
            child: IconButton(
              padding: EdgeInsets.only(right: 8.0),
              onPressed: this.onPress,
              icon: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: animation,
              ),
            ),
          ),

          // Custom animation between front and back titles
          // Creates a smooth fade
          Stack(
            children: <Widget>[
              Opacity(
                opacity: CurvedAnimation(
                  parent: ReverseAnimation(animation),
                  curve: Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(0.5, 0.0),
                  ).evaluate(animation),
                  child: backTitle,
                ),
              ),
              Opacity(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.5, 1.0),
                ).value,
                child: FractionalTranslation(
                  translation: Tween<Offset>(
                    begin: Offset(-0.25, 0.0),
                    end: Offset.zero,
                  ).evaluate(animation),
                  child: frontTitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
