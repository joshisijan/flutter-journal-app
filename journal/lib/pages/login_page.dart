import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {

  final PageController pageController;

  LoginPage({@required this.pageController});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  AnimationController animationController;

  GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
    super.dispose();
    animationController.dispose();
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
                height: 120.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: Text(
                  'Login\nUsing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
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
                      googleLogin();
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 20.0,
            top: 20.0,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).buttonColor,
                    size: 30.0,
                  ),
                  onPressed: (){
                    this.widget.pageController.previousPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  googleLogin() async {

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    firebaseAuth.signInWithCredential(authCredential);

  }

  facebookLogin(){

  }

}
