import 'dart:io';

import 'package:challenge2ibi/controllers/home_controller.dart';
import 'package:challenge2ibi/models/country_model.dart';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

Future <void> exportToCsv() async{
  final HomeController _homeController = Get.put(HomeController());
  
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

  String csv = const ListToCsvConverter().convert(csvData);

  final String dir = (await getExternalStorageDirectory()).path;
  
  print("$dir");

  final String path = '$dir/countries.dart';
  

  final File file = File(path);

  await file.writeAsString(csv);
  print("exported");

}