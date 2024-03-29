import 'package:challenge2ibi/core/models/country_model.dart';
import 'package:challenge2ibi/core/services/urls.dart';

import 'utils/custom_dio.dart';

class CountriesService {
  Future<List<CountryModel>> getAllCountries() async {
    var dio = CustomDio.withoutAuthentication().instance;
    var url = "$baseUrl$allCountries";

    return dio.get(url).then((res) {
      return (res.data as List)
          .map((item) => CountryModel.fromJson(item))
          .toList();
    }).catchError((err) {
      print(err);
      return err;
    });
  }
}
