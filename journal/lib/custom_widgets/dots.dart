import 'package:flutter/material.dart';

class Dots extends StatelessWidget {

  final int total;
  final int index;

  Dots(this.total, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(this.total, (index){
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.only(bottom: 10.0, right: Theme.of(context).buttonTheme.padding.horizontal),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: index == this.index ? Theme.of(context).buttonColor : Theme.of(context).buttonColor.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}
