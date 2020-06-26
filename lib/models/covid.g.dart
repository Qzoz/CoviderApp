// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalData _$GlobalDataFromJson(Map<String, dynamic> json) {
  return GlobalData(
    json['NewConfirmed'] as int,
    json['TotalConfirmed'] as int,
    json['NewDeaths'] as int,
    json['TotalDeaths'] as int,
    json['NewRecovered'] as int,
    json['TotalRecovered'] as int,
  );
}

Map<String, dynamic> _$GlobalDataToJson(GlobalData instance) =>
    <String, dynamic>{
      'NewConfirmed': instance.newConfirmed,
      'TotalConfirmed': instance.totalConfirmed,
      'NewDeaths': instance.newDeaths,
      'TotalDeaths': instance.totalDeaths,
      'NewRecovered': instance.newRecovered,
      'TotalRecovered': instance.totalRecovered,
    };

CountryData _$CountryDataFromJson(Map<String, dynamic> json) {
  return CountryData(
    json['Country'] as String,
    json['CountryCode'] as String,
    json['Slug'] as String,
    json['NewConfirmed'] as int,
    json['TotalConfirmed'] as int,
    json['NewDeaths'] as int,
    json['TotalDeaths'] as int,
    json['NewRecovered'] as int,
    json['TotalRecovered'] as int,
    _fromStringToDateTime(json['Date'] as String),
  );
}

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'Country': instance.country,
      'CountryCode': instance.countryCode,
      'Slug': instance.slug,
      'NewConfirmed': instance.newConfirmed,
      'TotalConfirmed': instance.totalConfirmed,
      'NewDeaths': instance.newDeaths,
      'TotalDeaths': instance.totalDeaths,
      'NewRecovered': instance.newRecovered,
      'TotalRecovered': instance.totalRecovered,
      'Date': _fromDateTimeToString(instance.date),
    };

CovidData _$CovidDataFromJson(Map<String, dynamic> json) {
  return CovidData(
    json['Global'] == null
        ? null
        : GlobalData.fromJson(json['Global'] as Map<String, dynamic>),
    (json['Countries'] as List)
        ?.map((e) =>
            e == null ? null : CountryData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    _fromStringToDateTime(json['Date'] as String),
  );
}

Map<String, dynamic> _$CovidDataToJson(CovidData instance) => <String, dynamic>{
      'Global': instance.global,
      'Countries': instance.countries,
      'Date': _fromDateTimeToString(instance.date),
    };
