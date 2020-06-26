// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    json['code'] as String,
    json['name'] as String,
    json['symbol'] as String,
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return Language(
    json['iso639_1'] as String,
    json['iso639_2'] as String,
    json['name'] as String,
    json['nativeName'] as String,
  );
}

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'iso639_1': instance.iso639_1,
      'iso639_2': instance.iso639_2,
      'name': instance.name,
      'nativeName': instance.nativeName,
    };

RegionalBlock _$RegionalBlockFromJson(Map<String, dynamic> json) {
  return RegionalBlock(
    json['acronym'] as String,
    json['name'] as String,
    (json['otherAcronym'] as List)?.map((e) => e as String)?.toList(),
    (json['otherNames'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$RegionalBlockToJson(RegionalBlock instance) =>
    <String, dynamic>{
      'acronym': instance.acronym,
      'name': instance.name,
      'otherAcronym': instance.otherAcronym,
      'otherNames': instance.otherNames,
    };

CountryDetails _$CountryDetailsFromJson(Map<String, dynamic> json) {
  return CountryDetails(
    json['name'] as String,
    (json['topLevelDomain'] as List)?.map((e) => e as String)?.toList(),
    json['alpha2Code'] as String,
    json['alpha3Code'] as String,
    (json['callingCodes'] as List)?.map((e) => e as String)?.toList(),
    json['capital'] as String,
    (json['altSpellings'] as List)?.map((e) => e as String)?.toList(),
    json['region'] as String,
    json['subregion'] as String,
    json['population'] as int,
    (json['latlng'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    json['demonym'] as String,
    (json['area'] as num)?.toDouble(),
    (json['gini'] as num)?.toDouble(),
    (json['timezones'] as List)?.map((e) => e as String)?.toList(),
    (json['borders'] as List)?.map((e) => e as String)?.toList(),
    json['nativeName'] as String,
    json['numericCode'] as String,
    (json['currencies'] as List)
        ?.map((e) =>
            e == null ? null : Currency.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['languages'] as List)
        ?.map((e) =>
            e == null ? null : Language.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['translations'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    json['flag'] as String,
    (json['regionalBlocs'] as List)
        ?.map((e) => e == null
            ? null
            : RegionalBlock.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['cioc'] as String,
  );
}

Map<String, dynamic> _$CountryDetailsToJson(CountryDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'topLevelDomain': instance.tlds,
      'alpha2Code': instance.a2Code,
      'alpha3Code': instance.a3Code,
      'callingCodes': instance.callCodes,
      'capital': instance.capital,
      'altSpellings': instance.altSpellings,
      'region': instance.region,
      'subregion': instance.subRegion,
      'population': instance.population,
      'latlng': instance.latlang,
      'demonym': instance.demonym,
      'area': instance.area,
      'gini': instance.gini,
      'timezones': instance.timeZones,
      'borders': instance.borders,
      'nativeName': instance.nativeName,
      'numericCode': instance.numCode,
      'currencies': instance.currencies,
      'languages': instance.languages,
      'translations': instance.translations,
      'flag': instance.flagUrl,
      'regionalBlocs': instance.regionalBlocs,
      'cioc': instance.cioc,
    };

