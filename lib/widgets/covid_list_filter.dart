import 'package:flutter/material.dart';

class CovidDataListFilter extends StatefulWidget {
  final Function updateFilterMap;
  final List<double> maxCDR;

  CovidDataListFilter(this.maxCDR, this.updateFilterMap);

  @override
  _CovidDataListFilterState createState() => _CovidDataListFilterState();
}

class _CovidDataListFilterState extends State<CovidDataListFilter> {
  _CovidDataListFilterState();

  static const int steps = 10000;

  double cMin = 0.0, cmin = 0.0, cMax = 100000.0, cmax = 100000.0;
  double dMin = 0.0, dmin = 0.0, dMax = 100000.0, dmax = 100000.0;
  double rMin = 0.0, rmin = 0.0, rMax = 100000.0, rmax = 100000.0;
  bool isAlphaSortAsc = true;
  Map sortMap = {"type": "", "flag": false, "isLowHigh": false};
  String countryNameOrLetter = "";

  void initAllLimits() {
    setState(() {
      cMax = cmax = widget.maxCDR[0];
      dMax = dmax = widget.maxCDR[1];
      rMax = rmax = widget.maxCDR[2];
    });
  }

  @override
  void initState() {
    super.initState();
    initAllLimits();
  }

  Widget getDivider() {
    return Divider(
      color: Colors.grey[500],
      thickness: 1.0,
      height: 5.0,
    );
  }

  Widget getRangeFilter(double min, double max, double tmin, double tmax,
      Color color, Function callback, Function callbackUpdate) {
    return RangeSlider(
      min: min,
      max: max,
      divisions: steps,
      values: RangeValues(tmin, tmax),
      activeColor: color,
      inactiveColor: Colors.grey[700],
      onChanged: (rangeValues) {
        callback(rangeValues.start, rangeValues.end);
      },
      onChangeEnd: (rangeValues) {
        callbackUpdate(rangeValues.start, rangeValues.end);
      },
    );
  }

  Widget getExpTextFieldFilterRange(double tnum, Color color,
      {Function callback}) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        controller: TextEditingController(text: tnum.round().toString()),
        style: TextStyle(color: color),
        textAlign: TextAlign.center,
        onSubmitted: (text) {
          double temp = tnum;
          try {
            temp = double.tryParse(text);
            callback(false, temp);
          } catch (e) {
            callback(true, 0.0);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      children: <Widget>[
        Card(
          color: Colors.black,
          elevation: 15.0,
          shadowColor: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                "Sort By Contry Name",
                style: TextStyle(color: Colors.white),
              ),
              getDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FilterChip(
                    label: Text(
                      "Ascending",
                      style: TextStyle(
                        color: isAlphaSortAsc ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: isAlphaSortAsc,
                    checkmarkColor: Colors.white,
                    selectedColor: Colors.black,
                    onSelected: (isSelected) {
                      this.setState(() {
                        isAlphaSortAsc = isSelected;
                        widget.updateFilterMap(
                            "sort: alphaAsc", isAlphaSortAsc);
                      });
                    },
                  ),
                  FilterChip(
                    label: Text(
                      "Descending",
                      style: TextStyle(
                        color: !isAlphaSortAsc ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: !isAlphaSortAsc,
                    checkmarkColor: Colors.white,
                    selectedColor: Colors.black,
                    onSelected: (isSelected) {
                      setState(() {
                        isAlphaSortAsc = !isSelected;
                        widget.updateFilterMap(
                            "sort: alphaAsc", isAlphaSortAsc);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Card(
          color: Colors.black,
          elevation: 15.0,
          shadowColor: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                "Sort By",
                style: TextStyle(color: Colors.white),
              ),
              getDivider(),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: FilterChip(
                      label: Text(
                        "Confirmed",
                        style: TextStyle(
                            color: sortMap["type"] == "Confirmed" &&
                                    sortMap["flag"] == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      selected: sortMap["type"] == "Confirmed" &&
                          sortMap["flag"] == true,
                      checkmarkColor: Colors.white,
                      selectedColor: Colors.black,
                      onSelected: (isSelected) {
                        setState(() {
                          sortMap["type"] = "Confirmed";
                          sortMap["flag"] = isSelected;
                          widget.updateFilterMap("sort: type", "Confirmed");
                          widget.updateFilterMap(
                              "sort: typeSel", sortMap["flag"]);
                          widget.updateFilterMap(
                              "sort: typeAsc", sortMap["isLowHigh"]);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: FilterChip(
                      label: Text(
                        "Deaths",
                        style: TextStyle(
                            color: sortMap["type"] == "Deaths" &&
                                    sortMap["flag"] == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      selected:
                          sortMap["type"] == "Deaths" && sortMap["flag"] == true,
                      checkmarkColor: Colors.white,
                      selectedColor: Colors.black,
                      onSelected: (isSelected) {
                        setState(() {
                          sortMap["type"] = "Deaths";
                          sortMap["flag"] = isSelected;
                          widget.updateFilterMap("sort: type", "Deaths");
                          widget.updateFilterMap(
                              "sort: typeSel", sortMap["flag"]);
                          widget.updateFilterMap(
                              "sort: typeAsc", sortMap["isLowHigh"]);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: FilterChip(
                      label: Text(
                        "Recovered",
                        style: TextStyle(
                            color: sortMap["type"] == "Recovered" &&
                                    sortMap["flag"] == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      selected: sortMap["type"] == "Recovered" &&
                          sortMap["flag"] == true,
                      checkmarkColor: Colors.white,
                      selectedColor: Colors.black,
                      onSelected: (isSelected) {
                        setState(() {
                          sortMap["type"] = "Recovered";
                          sortMap["flag"] = isSelected;
                          widget.updateFilterMap("sort: type", "Recovered");
                          widget.updateFilterMap(
                              "sort: typeSel", sortMap["flag"]);
                          widget.updateFilterMap(
                              "sort: typeAsc", sortMap["isLowHigh"]);
                        });
                      },
                    ),
                  ),
                ],
              ),
              getDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FilterChip(
                    label: Text(
                      "Low to High",
                      style: TextStyle(
                          color: sortMap["flag"] == true &&
                                  sortMap["isLowHigh"] == true
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected:
                        sortMap["flag"] == true && sortMap["isLowHigh"] == true,
                    checkmarkColor: Colors.white,
                    selectedColor: Colors.black,
                    onSelected: (isSelected) {
                      setState(() {
                        sortMap["isLowHigh"] = isSelected;
                        widget.updateFilterMap(
                            "sort: typeAsc", sortMap["isLowHigh"]);
                      });
                    },
                  ),
                  FilterChip(
                    label: Text(
                      "High to Low",
                      style: TextStyle(
                          color: sortMap["flag"] == true &&
                                  sortMap["isLowHigh"] == false
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected: sortMap["flag"] == true &&
                        sortMap["isLowHigh"] == false,
                    checkmarkColor: Colors.white,
                    selectedColor: Colors.black,
                    onSelected: (isSelected) {
                      setState(() {
                        sortMap["isLowHigh"] = !isSelected;
                        widget.updateFilterMap(
                            "sort: typeAsc", sortMap["isLowHigh"]);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Card(
          color: Colors.black,
          elevation: 15.0,
          shadowColor: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                "Filter By Country Name",
                style: TextStyle(color: Colors.white),
              ),
              getDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Name (or Letters)... " + countryNameOrLetter,
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (text) {
                    this.setState(() {
                      this.countryNameOrLetter = text;
                      widget.updateFilterMap("filter: country", text);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Card(
          color: Colors.black,
          elevation: 15.0,
          shadowColor: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                "Filter By",
                style: TextStyle(color: Colors.white),
              ),
              getDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Confirmed",
                      style: TextStyle(color: Colors.amber[700]),
                    ),
                  ],
                ),
              ),
              getRangeFilter(cmin, cmax, cMin, cMax, Colors.amber[700], (a, b) {
                setState(() {
                  cMin = a;
                  cMax = b;
                });
              }, (x, y) {
                widget.updateFilterMap(
                    "filter: confirmed", {"min": x.round(), "max": y.round()});
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    getExpTextFieldFilterRange(cMin, Colors.amber[700],
                        callback: (err, res) {
                      if (!err) {
                        if (res > cmax || res > cMax) res = cMax;
                        if (res < cmin) res = cmin;
                        setState(() {
                          cMin = res;
                          widget.updateFilterMap("filter: confirmed",
                              {"min": res.round(), "max": cMax.round()});
                        });
                      }
                    }),
                    getExpTextFieldFilterRange(cMax, Colors.amber[700],
                        callback: (err, res) {
                      if (!err) {
                        if (res > cmax) res = cmax;
                        if (res < cmin || res < cMin) res = cMin;
                        setState(() {
                          cMax = res;
                          widget.updateFilterMap("filter: confirmed",
                              {"min": cMin.round(), "max": res.round()});
                        });
                      }
                    }),
                  ],
                ),
              ),
              getDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Deaths",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  ],
                ),
              ),
              getRangeFilter(dmin, dmax, dMin, dMax, Colors.red, (a, b) {
                setState(() {
                  dMin = a;
                  dMax = b;
                });
              }, (x, y) {
                widget.updateFilterMap(
                    "filter: deaths", {"min": x.round(), "max": y.round()});
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    getExpTextFieldFilterRange(dMin, Colors.red,
                        callback: (err, res) {
                      if (!err) {
                        if (res > dmax || res > dMax) res = dMax;
                        if (res < dmin) res = dmin;
                        setState(() {
                          dMin = res;
                          widget.updateFilterMap("filter: deaths",
                              {"min": res.round(), "max": dMax.round()});
                        });
                      }
                    }),
                    getExpTextFieldFilterRange(dMax, Colors.red,
                        callback: (err, res) {
                      if (!err) {
                        if (res > dmax) res = dmax;
                        if (res < dmin || res < dMin) res = dMin;
                        setState(() {
                          dMax = res;
                          widget.updateFilterMap("filter: deaths",
                              {"min": dMin.round(), "max": res.round()});
                        });
                      }
                    }),
                  ],
                ),
              ),
              getDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Recovered",
                      style: TextStyle(color: Colors.green[300]),
                    ),
                  ],
                ),
              ),
              getRangeFilter(rmin, rmax, rMin, rMax, Colors.green[300], (a, b) {
                setState(() {
                  rMin = a;
                  rMax = b;
                });
              }, (x, y) {
                widget.updateFilterMap(
                    "filter: recovered", {"min": x.round(), "max": y.round()});
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    getExpTextFieldFilterRange(rMin, Colors.green[300],
                        callback: (err, res) {
                      if (!err) {
                        if (res > rmax || res > rMax) res = rMax;
                        if (res < rmin) res = rmin;
                        setState(() {
                          rMin = res;
                          widget.updateFilterMap("filter: recovered",
                              {"min": res.round(), "max": rMax.round()});
                        });
                      }
                    }),
                    getExpTextFieldFilterRange(rMax, Colors.green[300],
                        callback: (err, res) {
                      if (!err) {
                        if (res > rmax) res = rmax;
                        if (res < rmin || res < rMin) res = rMin;
                        setState(() {
                          rMax = res;
                          widget.updateFilterMap("filter: recovered",
                              {"min": rMin.round(), "max": res.round()});
                        });
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60.0,
        ),
      ],
    );
  }
}
