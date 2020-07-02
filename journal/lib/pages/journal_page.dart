import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/custom_widgets/journal_emoji.dart';

class JournalPageRoute extends MaterialPageRoute {

  final Map<String, dynamic> journal;

  JournalPageRoute({@required this.journal})
      : super(builder: (context) {
          return JournalPage(
            journal: journal,
          );
        });

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return ScaleTransition(
      scale: Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastLinearToSlowEaseIn,
        )
      ),
      child: JournalPage(
        journal: this.journal,
      ),
    );
  }
}

class JournalPage extends StatelessWidget {

  final Map<String, dynamic> journal;

  JournalPage({@required this.journal});

  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.fromMillisecondsSinceEpoch(journal['createdAt'].seconds * 1000);
    final month = DateFormat('MMM');
    final day = DateFormat('dd');

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top + 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              BackButton(
                color: Colors.white70,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    month.format(date) + ' ' + day.format(date),
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    date.year.toString(),
                    style: TextStyle(

                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  JournalEmoji(journal['emoticon']),
                  Text(
                    journal['emoticon'].toString() + '/10',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            journal['title'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white70,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: journal['content'].toString().substring(0,1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white70,
                    ),
                  ),
                  TextSpan(
                    text: journal['content'].toString().substring(1,journal['content'].length),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white70,
                    ),
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
