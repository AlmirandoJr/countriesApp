import 'dart:io';

import 'package:challenge2ibi/widgets/constants.dart';
import 'package:challenge2ibi/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Column countryWidget(context,
  {String countryName, String countryRegion, String cover, /*bool isCover*/}
){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Container(
          width: Get.height*0.55,
          height: Get.height*0.55,
          child: SvgPicture.network(
            "$cover",
            headers: {HttpHeaders.contentTypeHeader: "application/json"},
            semanticsLabel: "Flag",
            fit: BoxFit.cover,
            placeholderBuilder: (context) => circularProgress(context),
            height: 8,
          ),

          decoration: BoxDecoration(          
            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),     
      Padding(
        padding: const EdgeInsets.only(left: 0.0, top: 1),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$countryName \n',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: textFont
                )
              ),
              TextSpan(
                text: '$countryRegion \n',
                style: TextStyle(fontSize: 14, color: Colors.black)),
            ],
          ),
        ),
      ),
  
    ],
    
  );
}