import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class JournalEmoji extends StatelessWidget {

  final int value;

  JournalEmoji(this.value);

  @override
  Widget build(BuildContext context) {
    switch(value){
      case 1:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.sadCry,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 2:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.sadTear,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 3:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.frown,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 4:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.meh,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 5:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.smile,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 6:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.smileBeam,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 7:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.grin,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 8:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.grinBeam,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 9:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.grinStars,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      case 10:{
        return Container(
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.grinStars,
            size: 40.0,
            color: Colors.white70,
          ),
        );
      }
      default:{
        return Icon(
          Icons.thumb_up,
          size: 40.0,
          color: Colors.white70,
        );
      }
    }
  }
}
