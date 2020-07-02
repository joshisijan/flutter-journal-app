import 'package:flutter/material.dart';

class Todays3 extends StatelessWidget {

  final PageController pageController;

  Todays3({@required this.pageController});

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
            'Photo to describe your day',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: RawMaterialButton(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Icon(
                    Icons.add_photo_alternate,
                    color: Theme.of(context).primaryColor,
                    size: 80.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Add photo',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                ],
              ),
              onPressed: (){

              },
            ),
          ),
        ),
      ],
    );
  }
}
