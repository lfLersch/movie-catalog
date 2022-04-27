import 'package:flutter/material.dart';
import 'package:movie_catalog/constants.dart';

class GenericTextBox extends StatelessWidget {
  final String subject, data;
  const GenericTextBox(this.subject, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(10) ,
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colours.gray08,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),),
      child: Row(children: [
        Text(subject+': ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colours.gray03)),
        Text(data, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colours.gray01))
      ]),
    );
  }
}
