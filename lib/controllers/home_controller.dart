import 'package:challenge2ibi/models/country_model.dart';
import 'package:challenge2ibi/services/countries_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  Future<List<CountryModel>> countryFuture;
  CountriesService _service;
  @override
  void onInit() {
    _service = CountriesService();
    countryFuture = _service.getAllCountries();
    super.onInit();
  }
  
}