import 'dart:convert';

import 'package:covider/busy/data_handle.dart';
import 'package:covider/busy/file_handle.dart';
import 'package:covider/models/country.dart';
import 'package:covider/models/covid.dart';
import 'package:covider/services/data_service.dart';

class DataServiceImpl extends DataService {
  static final DataServiceImpl _singleton = DataServiceImpl._internal();

  factory DataServiceImpl() {
    return _singleton;
  }

  DataServiceImpl._internal() {
    setCountryDetailsList();
    setCovidDetailsList();
  }

  Map<String, int> countryCodePosMap;
  Map<String, int> countryCodePosMap3;
  Map<String, int> countryCovidPosMap;
  Set<String> countryBookmarks;
  List<CountryDetails> countryDetailsList;

  CovidData covidData;

  bool countryDataArrived = false;
  bool covidDataArrived = false;

  void genMapCountry(List<CountryDetails> countryList) {
    countryCodePosMap = Map();
    countryCodePosMap3 = Map();
    for (int i = 0; i < countryList.length; i++) {
      countryCodePosMap.putIfAbsent(countryList[i].a2Code, () {
        return i;
      });
      countryCodePosMap3.putIfAbsent(countryList[i].a3Code, () {
        return i;
      });
    }
  }

  void genMapCovid(List<CountryData> countryList) {
    countryCovidPosMap = Map();
    for (int i = 0; i < countryList.length; i++) {
      countryCovidPosMap.putIfAbsent(countryList[i].countryCode, () {
        return i;
      });
      if (countryBookmarks.contains(countryList[i].countryCode) == true)
        countryList[i].isBookrmarked = true;
    }
  }

  Future<bool> setCountryDetailsList() async {
    List result = await getDataOfCountryCached();
    countryDataArrived = false;
    if (result[0]) {
      countryDataArrived = true;
      countryDetailsList =
          CountryDetailsList.fromJson(jsonDecode(result[1])).countryList;
      genMapCountry(countryDetailsList);
    }
    return Future.value(countryDataArrived);
  }

  Future<bool> setCovidDetailsList() async {
    List result = await getDataOfCovidCached();
    covidDataArrived = false;
    if (result[0]) {
      covidDataArrived = true;
      covidData = CovidData.fromJson(jsonDecode(result[1]));
      List bookmarkRes = await getDataOfBookmark();
      countryBookmarks = Set();
      if (bookmarkRes[0]) {
        if (bookmarkRes[1] is String && bookmarkRes[1] != "")
          countryBookmarks.addAll(bookmarkRes[1].split(","));
      }
      genMapCovid(covidData.countries);
    }
    return Future.value(covidDataArrived);
  }

  @override
  Future<bool> isCountryDataReady() async {
    if (countryDataArrived) return Future.value(countryDataArrived);
    return await setCountryDetailsList();
  }

  @override
  Future<bool> isCovidDataReady() async {
    if (covidDataArrived) return Future.value(covidDataArrived);
    return await setCovidDetailsList();
  }

  @override
  Future<List> syncCountryData() async {
    List res = await updateCountryData();
    if (!res[0] && res.length == 1) res.add("Some Error Occured");
    if (res[0]) res[0] = await setCountryDetailsList();
    return res;
  }

  @override
  Future<List> syncCovidData() async {
    List res = await updateCovidData();
    if (!res[0] && res.length == 1) res.add("Some Error Occured");
    if (res[0]) res[0] = await setCovidDetailsList();
    return res;
  }

  @override
  CountryData getCovidDataByCode(String code) {
    if (this.countryCovidPosMap[code] == null) return null;
    return covidData.countries[this.countryCovidPosMap[code]];
  }

  @override
  CountryDetails getCountryDataByIndex(int index) {
    return countryDetailsList[index];
  }

  @override
  CountryDetails getCountryDataByCode(String code) {
    return countryDetailsList[this.getCountryMapedPos(code)];
  }

  @override
  CountryDetails getCountryDataByCode3(String code) {
    if (this.countryCodePosMap3[code] == null) return null;
    return countryDetailsList[this.countryCodePosMap3[code]];
  }

  @override
  CovidData getCovidData() {
    return covidData;
  }

  @override
  List<CountryDetails> getCountryDataList() {
    return countryDetailsList;
  }

  @override
  int getCountryMapedPos(String code) {
    return countryCodePosMap[code];
  }

  @override
  Set<String> getBookmark() {
    return this.countryBookmarks;
  }

  @override
  void updateBookmark(String code, bool isChecked) {
    if (isChecked) {
      countryBookmarks.remove(code);
    } else {
      countryBookmarks.add(code);
    }
    setDataToBookmark(countryBookmarks.join(","));
  }

  @override
  void deleteCountryCache() {
    deleteDataOfCountryCached();
  }

  @override
  void deleteCovidCache() {
    deleteDataOfCovidCached();
  }
}

String getReadableDate(DateTime date) {
  return _getZeroedVal(date.day) +
      "-" +
      _getZeroedVal(date.month) +
      "-" +
      _getZeroedVal(date.year);
}

String getReadableTime(DateTime date) {
  return _getZeroedVal(date.hour) + ":" + _getZeroedVal(date.minute);
}

String _getZeroedVal(int val) {
  if (val < 10) return "0" + val.toString();
  return val.toString();
}

String getReadableDateTime(DateTime date) {
  return getReadableDate(date) + " " + getReadableTime(date);
}

Future<List> syncData(DataService dataService) async {
  var res1 = await dataService.syncCountryData();
  if (!res1[0]) return Future.value(res1);
  var res2 = await dataService.syncCovidData();
  if (!res2[0]) return Future.value(res2);
  return Future.value([true]);
}
