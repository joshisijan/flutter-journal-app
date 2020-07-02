import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todays2 extends StatefulWidget {

  final PageController pageController;

  Todays2({@required this.pageController});

  @override
  _Todays2State createState() => _Todays2State();
}

class _Todays2State extends State<Todays2> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 150.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Summary of your day',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 50.0),
          child: TextFormField(
            inputFormatters:[
              LengthLimitingTextInputFormatter(50),
            ],
            controller: titleController,
            maxLines: 2,
            minLines: 1,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white70,
            ),
            decoration: InputDecoration(
              hintText: 'title(optional)',
              hintStyle: TextStyle(
                color: Theme.of(context).buttonColor.withAlpha(150),
                fontSize: 18.0,
              ),
              border: InputBorder.none,
            ),
            onChanged: (value) async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('title', titleController.text.trim());
            },
            onFieldSubmitted: (value){
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 50.0),
          child: TextFormField(
            inputFormatters:[
              LengthLimitingTextInputFormatter(3000),
            ],
            minLines: 1,
            maxLines: 1000,
            controller: contentController,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
            ),
            decoration: InputDecoration(
              hintText: 'About  you day..',
              hintStyle: TextStyle(
                color: Theme.of(context).buttonColor.withAlpha(150),
                fontSize: 16.0,
              ),
              border: InputBorder.none,
            ),
            onChanged: (value) async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString('content', contentController.text.trim());
            },
            onFieldSubmitted: (value){
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    titleController.text = pref.getString('title');
    contentController.text = pref.getString('content');
  }
}
