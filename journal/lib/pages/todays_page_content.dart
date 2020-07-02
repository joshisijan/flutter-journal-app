import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journal/custom_widgets/dots.dart';
import 'package:journal/pages/todays_page_content_1.dart';
import 'package:journal/pages/todays_page_content_2.dart';
import 'package:journal/pages/todays_page_content_3.dart';
import 'package:journal/pages/todays_page_content_4.dart';


class TodaysPageContentRoute extends MaterialPageRoute{

  final FirebaseUser firebaseUser;

  TodaysPageContentRoute({@required this.firebaseUser})
      : super(builder: (BuildContext context) => TodaysPageContent(
    firebaseUser: firebaseUser,
  ));

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return FadeTransition(
      opacity: Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInCubic,
          )
      ),
      child: ScaleTransition(
        scale: Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInCubic,
            )
        ),
        child: TodaysPageContent(
          firebaseUser: this.firebaseUser,
        ),
      ),
    );
  }
}

//main content below this

class TodaysPageContent extends StatefulWidget {

  final FirebaseUser firebaseUser;

  TodaysPageContent({@required this.firebaseUser});

  @override
  _TodaysPageContentState createState() => _TodaysPageContentState();
}

class _TodaysPageContentState extends State<TodaysPageContent> {
  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index){
              setState(() {
                pageIndex = index;
              });
            },
            children: <Widget>[
              Todays1(
                pageController: pageController,
              ),
              Todays2(
                pageController: pageController,
              ),
              Todays3(
                pageController: pageController,
              ),
              Todays4(
                pageController: pageController,
                firebaseUser: this.widget.firebaseUser,
              ),
            ],
          ),
          Positioned(
            top: 20.0,
            right: 20.0,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_up,
                    color: Theme.of(context).buttonColor,
                    size: 30.0,
                  ),
                  onPressed: (){
                    onPrevious();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).buttonColor,
                    size: 30.0,
                  ),
                  onPressed: (){
                    onNext(pageIndex);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Dots(4, pageIndex),
          ),
        ],
      ),
    );
  }

  onNext(page){
    if(page == 1){
      FocusScope.of(context).unfocus();
      Timer(Duration(milliseconds: 500), (){
        this.pageController.nextPage(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }else{
      this.pageController.nextPage(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    }
  }

  onPrevious(){
    this.pageController.previousPage(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }
}
