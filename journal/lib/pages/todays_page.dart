import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/pages/home_page.dart';
import 'package:journal/pages/todays_page_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodaysPageRoute extends MaterialPageRoute {
  final FirebaseUser firebaseUser;

  TodaysPageRoute({@required this.firebaseUser})
      : super(
            builder: (BuildContext context) => TodaysPage(
                  firebaseUser: firebaseUser,
                ));

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInCubic,
      )),
      child: TodaysPage(
        firebaseUser: this.firebaseUser,
      ),
    );
  }
}

class TodaysPage extends StatefulWidget {
  final FirebaseUser firebaseUser;

  TodaysPage({@required this.firebaseUser});

  @override
  _TodaysPageState createState() => _TodaysPageState();
}

class _TodaysPageState extends State<TodaysPage> with TickerProviderStateMixin {
  AnimationController _animationControllerCard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationControllerCard = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationControllerCard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 350), () => _animationControllerCard.forward());

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            left: 30.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Good Evening,',
                  style: TextStyle(
                    color: Colors.black54.withAlpha(100),
                    fontSize: 16.0,
                  ),
                ),
                FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        this.widget.firebaseUser.displayName ?? '',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      );
                    } else {
                      return Text(
                        '',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            right: 40.0,
            child: IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black54,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    HomePageRoute(
                      firebaseUser: this.widget.firebaseUser,
                    ));
              },
            ),
          ),
          ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _animationControllerCard,
              curve: Curves.fastLinearToSlowEaseIn,
            )),
            child: Container(
              child: Center(
                child: RawMaterialButton(
                  child: Card(
                    elevation: 20.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            color: Theme.of(context).buttonColor.withAlpha(220),
                            size: 50.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Add today\'s story',
                            style: TextStyle(
                              color:
                                  Theme.of(context).buttonColor.withAlpha(220),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        TodaysPageContentRoute(
                          firebaseUser: this.widget.firebaseUser,
                        ));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
