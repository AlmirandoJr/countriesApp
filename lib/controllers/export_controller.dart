import 'dart:io';
import 'package:challenge2ibi/controllers/home_controller.dart';
import 'package:challenge2ibi/models/country_model.dart';
import 'package:challenge2ibi/services/permission_service.dart';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';

final HomeController _homeController = Get.put(HomeController());
final PermissionService _permissionController = Get.put(PermissionService());

Future <void> exportToCsv() async{

  List<CountryModel> listData = await _homeController.countryFuture;

  List<List<String>> csvData = [
    <String>[
      'Nome do Pais',
      'Capital',
      'Região',
      'Habitantes',
      'Fuso-horário'
    ],
    ...listData.map((e) => [
      e.name,
      e.capital,
      e.region,
      e.population.toString(),
      e.timezones.toString()
    ])
  ];

  String csv;

  if(csvData != null){
    csv = const ListToCsvConverter().convert(csvData);
  }

  _permissionController.requestWriteExternalStoragePermission();

  final String dir = (await getExternalStorageDirectory()).path;
  
  print("$dir");

  final String path = '$dir/countries_list.csv';
  
  final File file = File(path);
  
  await file.writeAsString(csv);
  print("exported");
}

Future<void> exportToXml() async{

  List<CountryModel> listData = await _homeController.countryFuture;

  final builder = XmlBuilder();

  var countries = listData.map((e) => [
    e.name,
    e.capital,
    e.region,
    e.population.toString(),
    e.timezones.toString()
  ]);

  builder.processing('xml', 'version="1.0"');

  builder.element('Paises', nest: () {
    countries.forEach((element) {  
    
      builder.element('Pais', nest: () {
        builder.element('Nome', nest: () {
          builder.text(element[0]);
        });
        builder.element('Capital', nest:(){
           builder.text(element[1]);          
        });
        builder.element('Regiao', nest:(){
           builder.text(element[2]);          
        });
        builder.element('Populacao', nest:(){
           builder.text(element[3]);          
        });
        builder.element('Time', nest:(){
           builder.text(element[4]);          
        });
      });
    });
  });
  
  final countriesXml = builder.build();

  _permissionController.requestWriteExternalStoragePermission();

  final String dir = (await getExternalStorageDirectory()).path;
  
  print("$dir");

  final String path = '$dir/countries_list.xml';

  final File file = File(path);
  await file.writeAsString(countriesXml.toString());
  print("exported");

}

Future<void> exportToXls() async{
  print("XLS TODO");
}