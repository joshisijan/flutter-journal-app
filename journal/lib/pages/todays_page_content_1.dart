import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/custom_widgets/range_emoji.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todays1 extends StatefulWidget {

  final PageController pageController;

  Todays1({@required this.pageController});

  @override
  _Todays1State createState() => _Todays1State();
}

class _Todays1State extends State<Todays1> {

  int selectedIndex = 5;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmoticon();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 150.0,
        ),
        Text(
          'How was your day?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        RangeEmoji(selectedIndex),
        SizedBox(
          height: 40.0,
        ),
        Container(
          child: Slider(
            value: this.selectedIndex.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            label: this.selectedIndex.toString(),
            activeColor: Colors.white70,
            inactiveColor: Colors.white30,
            onChanged: (value) async {
              setState(() {
                this.selectedIndex = value.toInt();
              });
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setInt('emoticon', value.toInt());
            },
          ),
        ),
      ],
    );
  }

  getEmoticon() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = pref.getInt('emoticon') ?? 5;
    });
  }

}
