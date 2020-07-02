import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/constants/strings.dart';
import 'package:journal/pages/home_page.dart';
import 'package:journal/pages/start_base.dart';
import 'package:journal/theme/theme.dart';

void main() {
  runApp(MyAppBase());
}


class MyAppBase extends StatelessWidget {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: kTheme,
      home: StreamBuilder(
        stream: firebaseAuth.onAuthStateChanged,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HomePage(
              firebaseUser: snapshot.data,
            );
          }else{
            return StartBase();
          }
        }
      ),
    );
  }
}
