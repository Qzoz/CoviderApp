import 'package:covider/models/country.dart';
import 'package:covider/models/covid.dart';

abstract class DataService {
  Future<bool> isCountryDataReady();
  Future<bool> isCovidDataReady();
  Future<List> syncCountryData();
  Future<List> syncCovidData();
  CovidData getCovidData();
  CountryData getCovidDataByCode(String code);
  CountryDetails getCountryDataByIndex(int index);
  CountryDetails getCountryDataByCode(String code);
  CountryDetails getCountryDataByCode3(String code);
  List<CountryDetails> getCountryDataList();
  int getCountryMapedPos(String code);
  Set<String> getBookmark();
  void updateBookmark(String code, bool isChecked);
  void deleteCountryCache();
  void deleteCovidCache();
}