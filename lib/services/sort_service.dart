import 'package:covider/models/covid.dart';

bool _isAlphaAsc = true;
bool _isSortType = false;
bool _isSortTypeAsc = false;
String _sortType;

bool _isByCountry = false;
String _searchText;

bool _isByRange = false;
int _cmin = 0, _dmin = 0, _rmin = 0, _cmax = -1, _dmax = -1, _rmax = -1;

void initAll() {
  _isAlphaAsc = true;
  _isSortType = false;
  _isSortTypeAsc = false;
  _isByCountry = false;
  _isByRange = false;
}

void _prepareFilters(Map filters) {
  if (filters["sort: alphaAsc"] != null) {
    _isAlphaAsc = filters["sort: alphaAsc"];
  }
  if (filters["sort: type"] != null) {
    _sortType = filters["sort: type"];
    _isSortType = filters["sort: typeSel"];
    _isSortTypeAsc = filters["sort: typeAsc"];
  }
  if (filters["filter: country"] != null) {
    _isByCountry = true;
    _searchText = filters["filter: country"];
  }
  if (filters["filter: confirmed"] != null) {
    _isByRange = true;
    _cmin = filters["filter: confirmed"]["min"];
    _cmax = filters["filter: confirmed"]["max"];
  }
  if (filters["filter: deaths"] != null) {
    _isByRange = true;
    _dmin = filters["filter: deaths"]["min"];
    _dmax = filters["filter: deaths"]["max"];
  }
  if (filters["filter: recovered"] != null) {
    _isByRange = true;
    _rmin = filters["filter: recovered"]["min"];
    _rmax = filters["filter: recovered"]["max"];
  }
}

int _compareAlphaLex(String a, String b) {
  return _isAlphaAsc ? a.compareTo(b) : b.compareTo(a);
}

int _compareNumSortType(int a, int b) {
  return _isSortTypeAsc ? a.compareTo(b) : b.compareTo(a);
}

int _compareBySortType(CountryData a, CountryData b) {
  if (_isSortType == false) return 0;
  if (_sortType == "Confirmed") {
    return _compareNumSortType(a.totalConfirmed, b.totalConfirmed);
  }
  if (_sortType == "Deaths") {
    return _compareNumSortType(a.totalDeaths, b.totalDeaths);
  }
  if (_sortType == "Recovered") {
    return _compareNumSortType(a.totalRecovered, b.totalRecovered);
  }
  return -1;
}

bool _isDataInFilterRange(CountryData data) {
  bool conf = true, dead = true, reco = true;
  
  if (data.totalConfirmed < _cmin) conf = false;
  if (_cmax != -1 && data.totalConfirmed > _cmax) conf = false;
  
  if (data.totalDeaths < _dmin) dead = false;
  if (_dmax != -1 && data.totalDeaths > _dmax) dead = false;
  
  if (data.totalRecovered < _rmin) reco = false;
  if (_rmax != -1 && data.totalRecovered > _rmax) reco = false;

  return conf && dead && reco;
}

List<CountryData> _filterList(List<CountryData> list) {
  List<CountryData> filteredList = List<CountryData>();
  if (_isByCountry) {
    list.forEach((country) {
      if (country.country.contains(RegExp(r'' + _searchText, caseSensitive: false))) {
        filteredList.add(country);
      }
    });
  } else if (_isByRange) {
    list.forEach((country) {
      if (_isDataInFilterRange(country)) {
        filteredList.add(country);
      }
    });
  } else {
    filteredList.addAll(list);
    return filteredList;
  }
  return filteredList;
}

int _customSortFn(CountryData a, CountryData b) {
  int sortTypeRes = _compareBySortType(a, b);
  if (sortTypeRes == 0) {
    return _compareAlphaLex(a.country, b.country);
  }
  return sortTypeRes;
}

List<CountryData> getFilteredCovidDataList(
    List<CountryData> list, Map filters) {
  initAll();
  try {
    _prepareFilters(filters);
  } catch (e) {}
  List<CountryData> filteredList = _filterList(list);
  filteredList.sort((CountryData a, CountryData b) => _customSortFn(a, b));
  return filteredList;
}

List<double> getMaxCDR(List<CountryData> list) {
  int mC = -1, mD = -1, mR = -1;
  list.forEach((cdr) {
    if (cdr.totalConfirmed > mC) mC = cdr.totalConfirmed;
    if (cdr.totalDeaths > mD) mD = cdr.totalDeaths;
    if (cdr.totalRecovered > mR) mR = cdr.totalRecovered;
  });
  return [mC.roundToDouble(), mD.roundToDouble(), mR.roundToDouble()];
}
