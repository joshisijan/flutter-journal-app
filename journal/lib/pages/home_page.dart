import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:journal/pages/journal_page.dart';
import 'package:journal/pages/start_base.dart';
import 'package:journal/pages/todays_page.dart';

class HomePageRoute extends MaterialPageRoute {
  final FirebaseUser firebaseUser;

  HomePageRoute({@required this.firebaseUser})
      : super(
            builder: (BuildContext context) => HomePage(
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
      child: HomePage(
        firebaseUser: this.firebaseUser,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final FirebaseUser firebaseUser;

  HomePage({@required this.firebaseUser});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final Firestore fireStore = Firestore.instance;

  final rng = Random();

  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Timer(Duration(milliseconds: 350), (){
      animationController.forward();
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ScaleTransition(
                  scale: Tween(
                    begin: 0.0,
                    end: 1.0
                  ).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastLinearToSlowEaseIn,
                  )),
                  child: IconButton(
                    tooltip: 'View Journal',
                    icon: FaIcon(
                      FontAwesomeIcons.calendar,
                      color: Colors.white70,
                    ),
                    onPressed: () {},
                  ),
                ),
                ScaleTransition(
                  scale: Tween(
                      begin: 0.0,
                      end: 1.0
                  ).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastLinearToSlowEaseIn,
                  )),
                  child: IconButton(
                    tooltip: 'Add new Journal',
                    icon: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(TodaysPageRoute(
                        firebaseUser: this.widget.firebaseUser,
                      ));
                    },
                  ),
                ),
                ScaleTransition(
                  scale: Tween(
                      begin: 0.0,
                      end: 1.0
                  ).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastLinearToSlowEaseIn,
                  )),
                  child: IconButton(
                    tooltip: 'Log out',
                    icon: FaIcon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            titlePadding: EdgeInsets.all(20.0),
                            contentPadding: EdgeInsets.all(20.0),
                            actionsPadding: EdgeInsets.all(20.0),
                            title: Icon(
                              FontAwesomeIcons.signOutAlt,
                              color: Colors.black54,
                            ),
                            content: Text(
                              'Do you want to signout?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            actions: <Widget>[
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.check,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  signOut();
                                  Navigator.of(context).pop();
                                },
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.times,
                                  color: Theme.of(context).errorColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          FadeTransition(
            opacity: Tween(
                begin: 0.0,
                end: 1.0
            ).animate(CurvedAnimation(
              parent: animationController,
              curve: Curves.fastLinearToSlowEaseIn,
            )),
            child: Text(
              'Good Evening, ' + this.widget.firebaseUser.displayName.toString(),
              style: TextStyle(
                fontSize: 16.6,
                color: Colors.white70,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: fireStore
                  .collection('journals')
                  .where('userId', isEqualTo: this.widget.firebaseUser.uid).orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (_, journalSnapshot) {
                if (journalSnapshot.hasData) {
                  var data = journalSnapshot.data.documents;
                  if (data.length > 0 && data != null) {
                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: data.length,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(
                            data[index]['createdAt'].seconds * 1000);
                        final month = DateFormat('MMM');
                        final day = DateFormat('dd');
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(JournalPageRoute(
                              journal: data[index].data,
                            ));
                          },
                          child: ScaleTransition(
                            scale: Tween(
                                begin: 0.0,
                                end: 1.0
                            ).animate(CurvedAnimation(
                              parent: animationController,
                              curve: Curves.fastLinearToSlowEaseIn,
                            )),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(data[index]['photoUrl']),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                          color: Colors.black26,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              month.format(date) +
                                                  ' ' +
                                                  day.format(date),
                                              style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              date.year.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(1, rng.nextInt(75) / 100 + 1),
                      padding: EdgeInsets.all(20.0),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.infinity,
                          color: Colors.white70,
                          size: 60.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'No journals yet',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    );
                  }
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  signOut(){
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    firebaseAuth.signOut().then((value){
      googleSignIn.disconnect();
    }).then((value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => StartBase(),
      ), (route) => false);
    });

  }
}
