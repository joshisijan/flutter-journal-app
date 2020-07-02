import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartPage1 extends StatefulWidget {

  final PageController pageController;

  StartPage1({@required this.pageController});

  @override
  _StartPage1State createState() => _StartPage1State();
}

class _StartPage1State extends State<StartPage1> with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();

  int _nameLength = 0;


  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
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
                  'What should I call you?',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Theme.of(context).buttonColor.withAlpha(220),
                  ),
                ),
              ),
              SizedBox(
                height: 150.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: ScaleTransition(
                  scale: Tween(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastLinearToSlowEaseIn,
                  )),
                  child: TextFormField(
                    inputFormatters:[
                      LengthLimitingTextInputFormatter(20),
                    ],
                    controller: _nameController,
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'I am ..',
                      hintStyle: TextStyle(
                        color: Theme.of(context).buttonColor.withAlpha(150),
                        fontSize: 24.0,
                      ),
                      counterText: _nameLength.toString() + '/20',
                      counterStyle: TextStyle(
                        color: Theme.of(context).buttonColor.withAlpha(150),
                        fontSize: 16.0,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).buttonColor.withAlpha(150),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).buttonColor.withAlpha(150),
                        ),
                      ),
                    ),
                    onChanged: (value){
                      setState(() {
                        _nameLength = _nameController.text.length;
                      });
                    },
                    onFieldSubmitted: (value){
                      FocusScope.of(context).unfocus();
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'what should i call you?';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
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
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).buttonColor,
                    size: 30.0,
                  ),
                  onPressed: (){
                    onDone(_nameController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onDone(String value){
    value = value.trim();
    FocusScope.of(context).unfocus();
    Timer(Duration(milliseconds: 500),() async {
      if(value.length > 0){
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('name', value).then((value){
          this.widget.pageController.nextPage(
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        });
      }
    });
  }
  onBack(){
    FocusScope.of(context).unfocus();
    this.widget.pageController.previousPage(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _nameController.text = pref.getString('name');
    setState(() {
      _nameLength = _nameController.text.length;
    });
  }

}
