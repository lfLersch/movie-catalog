import 'package:flutter/material.dart';
import 'package:movie_catalog/constants.dart';

class FullLineTextBox extends StatelessWidget {
  final String subject, data;
  const FullLineTextBox(this.subject, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colours.gray08,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),),
      child: Row(children: [
        Text(subject+': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colours.gray03)),
        Flexible(child: Text(data, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colours.gray01)))
      ]),
    );
  }
}
