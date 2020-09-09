import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';

Padding modalTile({String title, String value}){
  return Padding(
    padding: EdgeInsets.only(
      left: 8,
      right: 8,
      top: 2,
      bottom: 2
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            "$title:",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: textFont,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value ?? " - ",
            maxLines: 2,
            style: TextStyle(
              fontFamily: textFont,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}