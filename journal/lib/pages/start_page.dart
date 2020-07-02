import 'package:flutter/material.dart';
import 'package:journal/constants/strings.dart';

class StartPage extends StatefulWidget {
  final PageController pageControllerHorizontal;
  final PageController pageControllerVertical;

  StartPage({@required this.pageControllerHorizontal, @required this.pageControllerVertical});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  AnimationController _animationControllerText1,
      _animationControllerText2,
      _animationControllerText3,
      _animationControllerButton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationControllerText1 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    _animationControllerText2 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    _animationControllerText3 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    _animationControllerButton = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600,
      ),
    );
    _animationControllerText1.forward().whenComplete(() {
      _animationControllerText2.forward().whenComplete(() {
        _animationControllerText3.forward().whenComplete(() {
          _animationControllerButton.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationControllerText1.dispose();
    _animationControllerText2.dispose();
    _animationControllerText3.dispose();
    _animationControllerButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: <Widget>[
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0, 60, 0, 0),
              end: RelativeRect.fromLTRB(0, 50, 0, 0),
            ).animate(CurvedAnimation(
                curve: Curves.easeIn, parent: _animationControllerText1)),
            child: FadeTransition(
              opacity: Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: _animationControllerText1)),
              child: Text(
                'Hi,',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0, 110, 0, 0),
              end: RelativeRect.fromLTRB(0, 100, 0, 0),
            ).animate(CurvedAnimation(
                curve: Curves.easeIn, parent: _animationControllerText2)),
            child: FadeTransition(
              opacity: Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: _animationControllerText2)),
              child: Text(
                'I am $kAppName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 170.0,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(
                  curve: Curves.easeInCubic,
                  parent: _animationControllerText3)),
              child: Text(
                'Your personal journal.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).buttonColor.withAlpha(220),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 100,
            child: ScaleTransition(
              scale: Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: _animationControllerButton,
                curve: Curves.bounceIn,
              )),
              child: RawMaterialButton(
                fillColor: Theme.of(context).buttonColor,
                elevation: 20.0,
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Text(
                  'Start Writting',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  this.widget.pageControllerVertical.nextPage(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: ScaleTransition(
              scale: Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: _animationControllerButton,
                curve: Curves.bounceOut,
              )),
              child: RawMaterialButton(
                child: Text(
                  'Already have an account.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).buttonColor.withAlpha(220),
                  ),
                ),
                onPressed: () {
                  this.widget.pageControllerHorizontal.nextPage(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
