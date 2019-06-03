import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mbom/models/product.dart';

class PresentationPage extends StatefulWidget {
  @override
  _PresentationPageState createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  final List<String> _sections = [
    Category.ACCESSORIES.toString().split('.')[1],
    Category.SMARTPHONES.toString().split('.')[1],
    Category.TABLETS.toString().split('.')[1],
    //Category.ACCESSORIES.toString().split('.')[1],
  ];

  int _currentPage = 0;
  double _barHeight;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(padding: EdgeInsets.only(top: 50.0)),
              _buildCarousel(context),
              _buildHeader(context),
              _buildSections(context),
            ],
          ),
        ),
        /*SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => _buildSections(context)),
        ),*/
      ],
    );
  }

  /// TODO: Add items parameter
  Widget _buildCarousel(BuildContext context, {List<Object> items}) {
    final ThemeData theme = Theme.of(context);

    List<_CarouselPage> _items = [
      _CarouselPage(
        background: Container(color: Colors.black),
        headline: 'REDMI NOTE 7',
        subhead: 'La puissance entre vos mains',
      ),
      _CarouselPage(
        background: Container(color: Colors.white30),
        headline: 'ONE PLUS 7 PLUS',
        subhead: 'Le petit nouveau',
      ),
      _CarouselPage(
        background: Container(color: Colors.white30),
        headline: 'ONE PLUS 7 PLUS',
        subhead: 'Le petit nouveau',
      ),
      _CarouselPage(
        background: Container(color: Colors.white30),
        headline: 'ONE PLUS 7 PLUS',
        subhead: 'Le petit nouveau',
      ),
    ];

    double _carouselHeight = MediaQuery.of(context).size.width * 1.33;

    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 10.0),
      //height: _carouselHeight,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            height: _carouselHeight,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            initialPage: _items.length ~/ 2,
            autoPlay: true,
            items: _items,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          Positioned(
            left: 0.0,
            top: _carouselHeight - 50.0,
            right: 0.0,
            height: 40.0,
            child: Container(
              alignment: Alignment.center,
              //decoration: BoxDecoration(color: Colors.black38),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _map(_items, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _map(List<_CarouselPage> list, BuildContext context) {
    List<Widget> _mappedItems = [];
    double barWidth = MediaQuery.of(context).size.width * 0.5;

    for (var i = 0; i < list.length; i++) {
      _mappedItems.add(
        _currentPage == i
            ? Container(
                width: barWidth / list.length + 40.0,
                height: 4.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              )
            : Container(
                width: barWidth / list.length,
                height: 3.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              ),
      );
    }

    return _mappedItems;
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// TODO: Create convert into Strings class constant
          Text(
            'NOS PRODUITS',
            style: Theme.of(context).textTheme.display1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'DES GAMMES VARIEES, DES PRIX COMPETITIFS',
              style: Theme.of(context)
                  .textTheme
                  .display2
                  .copyWith(letterSpacing: 1.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.,
      children:
          _sections.map((section) => _buildSection(context, section)).toList(),
    );
  }

  Widget _buildSection(BuildContext context, String sectionName) {
    final double _padding = MediaQuery.of(context).size.width * 0.1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sectionName,
            style: Theme.of(context).textTheme.display1,
            //textAlign: TextAlign.end,
          ),
          Padding(
            padding: EdgeInsets.only(top: 14.0),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  height: 300.0,
                  child: Image.asset(
                    'assets/images/photos/IMG_0000.JPG',
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('VIEW ALL',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  color: Colors.blueAccent,
                  textColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// TODO: Create class CarouselPage with a constructor taking a Product class param in its own file
class _CarouselPage extends StatelessWidget {
  /// TODO: add onTap callback to handle taps on pages

  final Widget background;
  final String headline;
  final String subhead;

  _CarouselPage({this.background, this.headline, this.subhead})
      : assert(headline != null),
        assert(subhead != null);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      color: theme.accentColor,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          background,
          Column(
            children: <Widget>[
              Text(
                headline,
                style: theme.textTheme.display1.copyWith(color: Colors.white),
              ),
              Text(
                subhead,
                style: theme.textTheme.display2.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum IndicatorType { BAR, DOT }

class _CarouselIndicator extends StatelessWidget {
  final IndicatorType type;

  _CarouselIndicator([this.type = IndicatorType.BAR]);

  @override
  Widget build(BuildContext context) {
    return Positioned();
  }
}
