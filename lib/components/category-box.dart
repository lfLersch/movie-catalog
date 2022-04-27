import 'package:flutter/material.dart';
import 'package:movie_catalog/constants.dart';

class CategoryBox extends StatelessWidget {
  final String data;
  const CategoryBox(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(10) ,
      padding: EdgeInsets.all(15),
      decoration:  BoxDecoration(
        border: Border.all(color: Colours.gray07),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),),
      child: Text(data, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colours.gray02)),
    );
  }
}
