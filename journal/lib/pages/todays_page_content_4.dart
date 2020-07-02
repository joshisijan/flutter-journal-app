import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journal/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todays4 extends StatelessWidget {
  final PageController pageController;

  final FirebaseUser firebaseUser;

  Todays4({@required this.pageController, @required this.firebaseUser});

  final Firestore fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          fillColor: Theme.of(context).buttonColor,
          elevation: 20.0,
          padding: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Text(
            'Post today\'s story',
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            postStory(context);
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        RawMaterialButton(
          child: Text(
            'Or change something',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
            ),
          ),
          onPressed: () {
            pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeIn,
            );
          },
        ),
      ],
    );
  }

  postStory(BuildContext context) async {
    SharedPreferences.getInstance().then((value){
      int rating = value.getInt('emoticon') ?? 5;
      String title = value.getString('title') ?? '';
      String content = value.getString('content') ?? '';

      fireStore.collection('journals').document().setData({
        'userId' : this.firebaseUser.uid,
        'emoticon' : rating,
        'title' : title,
        'content' : content,
        'photoUrl' : 'https://media3.s-nbcnews.com/j/newscms/2019_41/3047866/191010-japan-stalker-mc-1121_06b4c20bbf96a51dc8663f334404a899.fit-760w.JPG',
        'createdAt' : FieldValue.serverTimestamp(),
      }, merge: true).then((value2) async {
        await value.setInt('rating', 5);
        await value.setString('title', '');
        await value.setString('content', '');
        Navigator.pushAndRemoveUntil(context, HomePageRoute(
          firebaseUser: this.firebaseUser,
        ), (route) => false);
      });
    });
  }

}
