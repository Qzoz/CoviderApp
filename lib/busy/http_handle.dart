import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

const String URL_COUNTRY_ALL = "https://restcountries.eu/rest/v2/all";
const String URL_COVID_SUMMARY = "https://api.covid19api.com/summary";

Future<List> getDataFromResponseOnURL(String url) async {
  try {
    http.Response response = await http.get(url).timeout(Duration(seconds: 60));
    return [response.statusCode, response.body];
  } on TimeoutException {
    return [0, "Request Timeout (Slow Internet)"];
  } on SocketException {
    return [1, "No Network Connection"];
  } catch (e) {
    return [-1, "Error"];
  }
}

List getResponseList(List list) {
  if (list[0] == 200) return [true, list[1]];
  else return [false, list[1]];
}

Future<List> getCountryData() async {
  List response = await getDataFromResponseOnURL(URL_COUNTRY_ALL);
  return Future.value(getResponseList(response));
}

Future<List> getCovidData() async {
  List response = await getDataFromResponseOnURL(URL_COVID_SUMMARY);
  return Future.value(getResponseList(response));
}
