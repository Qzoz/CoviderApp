import 'package:covider/busy/file_handle.dart';
import 'package:covider/busy/http_handle.dart';

Future<List> updateCountryData() async {
  List respList = await getCountryData();
  if (!respList[0]) {
    return Future.value(respList);
  }
  bool res = await setDataToCountryCached(respList[1]);
  if (!res) return Future.value([false]);
  return Future.value([respList[0]]);
}

Future<List> updateCovidData() async {
  List respList = await getCovidData();
  if (!respList[0]) {
    return Future.value(respList);
  }
  bool res = await setDataToCovidCached(respList[1]);
  if (!res) return Future.value([false]);
  return Future.value([respList[0]]);
}

