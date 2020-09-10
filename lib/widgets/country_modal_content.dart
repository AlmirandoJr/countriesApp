import 'package:challenge2ibi/widgets/modal_tiles.dart';
import 'package:challenge2ibi/widgets/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class ModalFit extends StatelessWidget {
  final ScrollController scrollController;
  final cover;
  final countryName;
  final countryCapital;
  final countryRegion;
  final countrySubRegion;
  final countryPopulation;
  final countryArea;
  final countryTimeZone;
  final countryNativeName;

  const ModalFit({
    Key key,
    this.scrollController, 
    this.cover, 
    this.countryName, 
    this.countryRegion, 
    this.countrySubRegion, 
    this.countryPopulation, 
    this.countryArea, 
    this.countryTimeZone, 
    this.countryNativeName, this.countryCapital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Container(
              width: Get.height*0.55,
              height: Get.height*0.55,
              child: SvgPicture.network(
                cover.toString(),
                fit: BoxFit.cover,
                placeholderBuilder: (context) => circularProgress(context),
                height: 8.0,
              ),
              decoration: BoxDecoration(          
                //color: Colors.white70,
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5)
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                modalTile(title: "Nome do Pais", value: countryName),
                modalTile(title: "Capital do Pais", value: countryCapital),
                modalTile(title: "Região", value: countryRegion),
                modalTile(title: "Sub-Região", value: countrySubRegion),
                modalTile(title: "População", value: countryPopulation),
                modalTile(title: "Área", value: countryArea),
                modalTile(title: "Fuso Horário", value: countryTimeZone),
                modalTile(title: "Nome nativo", value: countryNativeName),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}