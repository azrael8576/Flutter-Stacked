import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterstacked/logger.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutterstacked/ui/views/draggable_scrollable_sheet/scrollable_exhibition_bottom_sheet.dart';

final log = getLogger('DraggableScrollableSheetView');

class DraggableScrollableSheetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: 'SF Pro Display'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 8),
                  Header(),
                  SizedBox(height: 40),
                  Tabs(),
                  SizedBox(height: 8),
                  SlidingCardsView(),
                ],
              ),
            ),
            ScrollableExhibitionSheet(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'Shenzhen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  final List<String> tabs = ['Nearby', 'Recent', 'Notice'];
  int onTapKeyIndex = 1;
  List<GlobalKey<_MyTabState>> keys;

  bool _isButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: <Widget>[
            ...tabs.map((String tabText) {
              int tabTextIndex = tabs.indexOf(tabText);
              return MyTab(
                key: keys[tabTextIndex],
                tabText: tabText,
                isSelect: onTapKeyIndex == tabTextIndex ? true : false,
                onTap: (offset) => onTap(tabTextIndex, offset),
              );
            }),
          ],
        ),
      ),
    );
  }

  void onTap(int keyIndex, Offset offset) async {
    for (GlobalKey<_MyTabState> key in keys) {
      if (keys.indexOf(key) == keyIndex) {
        if (!key.currentState.getIsSelect()) {}
        key.currentState.setIsSelect(true);
      } else {
        key.currentState.setIsSelect(false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    keys = List.generate(
      3,
      (_) => GlobalKey<_MyTabState>(),
    );

    _isButtonTapped = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MyTab extends StatefulWidget {
  final String tabText;
  bool isSelect;
  final Function onTap;

  MyTab({Key key, this.tabText, this.isSelect, this.onTap}) : super(key: key);

  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RenderBox object = context.findRenderObject();
        Offset globalPosition = object.localToGlobal(Offset.zero);
        widget.onTap(globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.tabText,
              style: TextStyle(
                fontSize: widget.isSelect ? 16 : 14,
                fontWeight: widget.isSelect ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: widget.isSelect ? Colors.red : Colors.white,
              ),
              height: 6,
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  bool getIsSelect() {
    return widget.isSelect;
  }

  void setIsSelect(bool isSelect) {
    setState(() {
      widget.isSelect = isSelect;
    });
  }
}

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            name: 'Shenzhen GLOBAL DESIGN AWARD 2018',
            date: '4.20-30',
            assetName: 'steve-johnson.jpeg',
            amount: '0.00\$',
            offset: pageOffset,
          ),
          SlidingCard(
            name: 'Shenzhen GLOBAL DESIGN AWARD 2018',
            date: '4.20-30',
            assetName: 'efe-kurnaz.jpg',
            amount: '4.00\$',
            offset: pageOffset - 1,
          ),
          SlidingCard(
            name: 'Dawan District, Guangdong Hong Kong and Macao',
            date: '4.28-31',
            assetName: 'rodion-kutsaev.jpeg',
            amount: '2.00\$',
            offset: pageOffset - 2,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final String amount;
  final double offset; //<-- How far is page from being displayed

  const SlidingCard(
      {Key key, this.name, this.date, this.assetName, this.amount, this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) /
        0.08)); //<--caluclate Gaussian function
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      //<-- Translate the cards to make space between them
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        //<--custom shape
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0), //<-- Set the alignment
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: CardContent(
                name: this.name,
                date: this.date,
                amount: this.amount,
                offset: gauss, //<-- Pass the gauss as offset
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final String amount;
  final double offset; //<-- add the offset

  const CardContent({Key key, this.name, this.date, this.amount, this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0), //<-- translate the name label
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(
            height: 8.0,
          ),
          Transform.translate(
            offset: Offset(32 * offset, 0), //<-- translate the price label
            child: Text(date, style: TextStyle(color: Colors.grey)),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(48 * offset, 0), //<-- translate the button
                  child: RaisedButton(
                    color: Color(0xFF162A49),
                    child: Text('Reserve'),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: () {},
                  ),
                ),
                Spacer(),
                Transform.translate(
                  offset: Offset(32 * offset, 0),
                  //<-- translate the price label
                  child: Text(
                    amount,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollableExhibitionSheet extends StatefulWidget {
  @override
  _ScrollableExhibitionSheetState createState() =>
      _ScrollableExhibitionSheetState();
}

class _ScrollableExhibitionSheetState extends State<ScrollableExhibitionSheet> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 100,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
          color: AppColors.mediumBlue,
        ),
      ),
    );
  }
}