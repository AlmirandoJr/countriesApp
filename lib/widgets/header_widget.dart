import 'package:challenge2ibi/core/controllers/export_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

var localCover = "assets/img/un.jpg";

SliverAppBar header(context, {String title}) {
  return SliverAppBar(
    expandedHeight: Get.height * 0.38,
    pinned: true,
    floating: false,
    centerTitle: false,
    title: Text(
      title,
      style: TextStyle(fontSize: Get.height * 0.038, fontFamily: textFont),
    ),
    backgroundColor: bodyColor,
    elevation: 2,
    actions: <Widget>[
      /*
      IconButton(
        icon: Icon(Icons.more_vert, color: Colors.white),
        onPressed: null
      ),  
      */
      PopupMenuButton<String>(
        onSelected: handleClick,
        color: bodyColor,
        itemBuilder: (BuildContext context) {
          return {'Exportar XLS', 'Exportar CSV', 'Exportar XML'}
              .map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(
                choice,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 15,
                  //color: Colors.white
                ),
              ),
            );
          }).toList();
        },
      ),
    ],
    flexibleSpace: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(localCover), fit: BoxFit.cover)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              appColor.withOpacity(0.85),
              appColor.withOpacity(0.25),
              bodyColor.withOpacity(0.25),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: Get.height / 9,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Countries App',
                    //"Drake",
                    style: TextStyle(
                        fontFamily: textFont,
                        fontSize: Get.height * 0.040,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 7, right: 7),
                    child: Text(
                      'Aplicativo para dispositivos Android e iOS que mostra a lista de paises da CountriesAPI',
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      //"Drake",
                      style: TextStyle(
                          fontFamily: textFont,
                          fontSize: Get.height * 0.030,
                          //fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Expanded(child: SizedBox(height: 1))
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void handleClick(String value) {
  switch (value) {
    case 'Exportar XLS':
      print("XLS");
      exportToXls();
      break;
    case 'Exportar CSV':
      print("CSV");
      exportToCsv();
      break;
    case 'Exportar XML':
      print("XML");
      exportToXml();
      break;
  }
}
