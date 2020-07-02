import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:journal/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage2 extends StatefulWidget {
  
  final PageController pageController;

  StartPage2({@required this.pageController});

  @override
  _StartPage2State createState() => _StartPage2State();
}

class _StartPage2State extends State<StartPage2> with SingleTickerProviderStateMixin {
  
  AnimationController animationController;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
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

    Timer(Duration(milliseconds: 350), () => animationController.forward());

    return Container(
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(
                height: 150.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: Text(
                  'Add account:',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Theme.of(context).buttonColor.withAlpha(220),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: ScaleTransition(
                  scale: Tween(
                      begin: 0.0,
                      end: 1.0
                  ).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastLinearToSlowEaseIn,
                  )),
                  child: RawMaterialButton(
                    fillColor: Theme.of(context).buttonColor,
                    elevation: 20.0,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'Facebook',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      facebookLogin();
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0,),
                child: Text(
                  'Or',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Theme.of(context).buttonColor.withAlpha(220),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: ScaleTransition(
                  scale: Tween(
                    begin: 0.0,
                    end: 1.0
                  ).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastLinearToSlowEaseIn,
                  )),
                  child: RawMaterialButton(
                    fillColor: Theme.of(context).buttonColor,
                    elevation: 20.0,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'Google',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      googleLogin(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 20.0,
            top: 20.0,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_up,
                    color: Theme.of(context).buttonColor,
                    size: 30.0,
                  ),
                  onPressed: (){
                    onBack();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onBack(){
    this.widget.pageController.previousPage(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  onDone(BuildContext context, FirebaseUser firebaseUser){
    Navigator.pushAndRemoveUntil(context, HomePageRoute(firebaseUser: firebaseUser), (Route<dynamic> route) => false);
  }

  googleLogin(BuildContext context) async {

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    firebaseAuth.signInWithCredential(authCredential).then((value1) async {

      SharedPreferences pref = await SharedPreferences.getInstance();

      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = pref.getString('name') ?? value1.user.displayName;
      value1.user.updateProfile(info).then((value){
        onDone(context, value1.user);
      });
    });

  }

  facebookLogin(){

  }

}
