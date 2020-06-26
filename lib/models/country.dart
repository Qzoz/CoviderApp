import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Currency {
  String code;
  String name;
  String symbol;

  Currency(this.code, this.name, this.symbol);

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable()
class Language {
  String iso639_1;
  String iso639_2;
  String name;
  String nativeName;

  Language(this.iso639_1, this.iso639_2, this.name, this.nativeName);

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class RegionalBlock {
  String acronym;
  String name;
  List<String> otherAcronym;
  List<String> otherNames;

  RegionalBlock(this.acronym, this.name, this.otherAcronym, this.otherNames);

  factory RegionalBlock.fromJson(Map<String, dynamic> json) =>
      _$RegionalBlockFromJson(json);
  Map<String, dynamic> toJson() => _$RegionalBlockToJson(this);
}

@JsonSerializable()
class CountryDetails {
  String name;
  @JsonKey(name: "topLevelDomain")
  List<String> tlds;
  @JsonKey(name: "alpha2Code")
  String a2Code;
  @JsonKey(name: "alpha3Code")
  String a3Code;
  @JsonKey(name: "callingCodes")
  List<String> callCodes;
  String capital;
  List<String> altSpellings;
  String region;
  @JsonKey(name: "subregion")
  String subRegion;
  int population;
  @JsonKey(name: "latlng")
  List<double> latlang;
  String demonym;
  double area;
  double gini;
  @JsonKey(name: "timezones")
  List<String> timeZones;
  List<String> borders;
  String nativeName;
  @JsonKey(name: "numericCode")
  String numCode;
  List<Currency> currencies;
  List<Language> languages;
  Map<String, String> translations;
  @JsonKey(name: "flag")
  String flagUrl;
  List<RegionalBlock> regionalBlocs;
  String cioc;

  CountryDetails(
      this.name, //done
      this.tlds, //done
      this.a2Code, //done
      this.a3Code, //done
      this.callCodes, //done
      this.capital, //done
      this.altSpellings, //done
      this.region, //done
      this.subRegion, //done
      this.population, //done
      this.latlang, //done
      this.demonym, //done
      this.area, //done
      this.gini, //done
      this.timeZones, //done
      this.borders,
      this.nativeName, //done
      this.numCode, //done
      this.currencies, //done
      this.languages, //done
      this.translations, //----
      this.flagUrl,
      this.regionalBlocs, //done
      this.cioc //done
      );

  factory CountryDetails.fromJson(Map<String, dynamic> json) =>
      _$CountryDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CountryDetailsToJson(this);

  String getFlagPathInAssets() {
    return "assets/country_flags/" + this.a3Code + ".png";
  }
}

@JsonSerializable()
class CountryDetailsList {
  List<CountryDetails> countryList;

  CountryDetailsList(this.countryList);

  factory CountryDetailsList.fromJson(json) {
    if (json == null) return CountryDetailsList(List<CountryDetails>());
    return CountryDetailsList((json as List)
        ?.map((countryJson) => countryJson == null
            ? null
            : CountryDetails.fromJson(countryJson as Map<String, dynamic>))
        ?.toList());
  }
  
}
