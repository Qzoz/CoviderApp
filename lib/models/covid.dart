import 'package:json_annotation/json_annotation.dart';

part 'covid.g.dart';

@JsonSerializable()
class GlobalData {
  @JsonKey(name: "NewConfirmed")
  int newConfirmed;
  @JsonKey(name: "TotalConfirmed")
  int totalConfirmed;
  @JsonKey(name: "NewDeaths")
  int newDeaths;
  @JsonKey(name: "TotalDeaths")
  int totalDeaths;
  @JsonKey(name: "NewRecovered")
  int newRecovered;
  @JsonKey(name: "TotalRecovered")
  int totalRecovered;

  GlobalData(this.newConfirmed, this.totalConfirmed, this.newDeaths,
      this.totalDeaths, this.newRecovered, this.totalRecovered);

  factory GlobalData.fromJson(Map<String, dynamic> json) =>
      _$GlobalDataFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalDataToJson(this);
}

@JsonSerializable()
class CountryData {
  @JsonKey(name: "Country")
  String country;
  @JsonKey(name: "CountryCode")
  String countryCode;
  @JsonKey(name: "Slug")
  String slug;
  @JsonKey(name: "NewConfirmed")
  int newConfirmed;
  @JsonKey(name: "TotalConfirmed")
  int totalConfirmed;
  @JsonKey(name: "NewDeaths")
  int newDeaths;
  @JsonKey(name: "TotalDeaths")
  int totalDeaths;
  @JsonKey(name: "NewRecovered")
  int newRecovered;
  @JsonKey(name: "TotalRecovered")
  int totalRecovered;
  @JsonKey(
      name: "Date",
      fromJson: _fromStringToDateTime,
      toJson: _fromDateTimeToString)
  DateTime date;
  @JsonKey(ignore: true)
  bool isBookrmarked;

  CountryData(
      this.country,
      this.countryCode,
      this.slug,
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered,
      this.date);

  factory CountryData.fromJson(Map<String, dynamic> json) =>
      _$CountryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountryDataToJson(this);
}

@JsonSerializable()
class CovidData {
  @JsonKey(name: "Global")
  GlobalData global;
  @JsonKey(name: "Countries")
  List<CountryData> countries;
  @JsonKey(
      name: "Date",
      fromJson: _fromStringToDateTime,
      toJson: _fromDateTimeToString)
  DateTime date;

  CovidData(this.global, this.countries, this.date);

  factory CovidData.fromJson(Map<String, dynamic> json) =>
      _$CovidDataFromJson(json);
  Map<String, dynamic> toJson() => _$CovidDataToJson(this);
}

DateTime _fromStringToDateTime(String dateString) {
  return DateTime.parse(dateString);
}

String _fromDateTimeToString(DateTime date) {
  return date.toIso8601String();
}
