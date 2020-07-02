import 'package:flutter/material.dart';
import 'package:journal/pages/login_page.dart';
import 'package:journal/pages/start_page.dart';
import 'package:journal/pages/start_page_1.dart';
import 'package:journal/pages/start_page_2.dart';
import 'package:journal/theme/colors.dart';



class StartBase extends StatelessWidget {

  final PageController _horizontalPageController = PageController(
    keepPage: false,
    initialPage: 0,
  );

  final PageController _verticalPageController = PageController(
    keepPage: false,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: PageView(
        controller: _horizontalPageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          PageView(
            scrollDirection: Axis.vertical,
            controller: _verticalPageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              StartPage(
                pageControllerHorizontal: _horizontalPageController,
                pageControllerVertical: _verticalPageController,
              ),
              StartPage1(
                pageController: _verticalPageController,
              ),
              StartPage2(
                pageController: _verticalPageController,
              ),
            ],
          ),
          LoginPage(
            pageController: _horizontalPageController,
          ),
        ],
      ),
    );
  }
}
