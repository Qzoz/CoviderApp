import 'package:covider/models/country.dart';
import 'package:covider/models/covid.dart';
import 'package:covider/services/data_service.dart';
import 'package:flutter/material.dart';

class CovidCountryDataGridView extends StatefulWidget {
  final List<CountryData> covidDataList;
  final DataService dataService;

  CovidCountryDataGridView(this.covidDataList, this.dataService);

  @override
  _CovidCountryDataGridViewState createState() =>
      _CovidCountryDataGridViewState();
}

class _CovidCountryDataGridViewState extends State<CovidCountryDataGridView> {
  String getAdjustedCountryName(String name) {
    String str = "";
    int ctr = 0;
    for (int i = 0; i < name.length; i++) {
      if (name[i] == '(') {
        ctr += 1;
      }
      if (ctr == 0) {
        str += name[i].toString();
      }
      if (name[i] == ')') {
        ctr -= 1;
      }
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.covidDataList.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.8,
      ),
      itemBuilder: (BuildContext context, int index) {
        CountryData covidData = widget.covidDataList[index];
        CountryDetails countryDetails =
            widget.dataService.getCountryDataByCode(covidData.countryCode);
        if (index == 0) {
          Chip(label: Text("Long Press to Bookmark"));
        }
        return GridTile(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            elevation: 4.0,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              hoverColor: Colors.black,
              splashColor: Colors.blueGrey,
              onTap: () {
                Navigator.pushNamed(context, '/countryFull', arguments: {
                  'details': countryDetails,
                });
              },
              onLongPress: () {
                setState(() {
                  widget.dataService.updateBookmark(
                      covidData.countryCode, covidData.isBookrmarked == true);
                  covidData.isBookrmarked =
                      (covidData.isBookrmarked == true) ? false : true;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      child: Hero(
                        tag: 'hero-img-' + countryDetails.a3Code,
                        child: Image(
                          semanticLabel: "Flag of " + countryDetails.name,
                          image:
                              AssetImage(countryDetails.getFlagPathInAssets()),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, right: 0.0),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                ),
                              ),
                              label: Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Text((index + 1).toString()),
                              ),
                              backgroundColor: Colors.black,
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'u_m',
                                  fontSize: 18.0),
                            ),
                            Expanded(
                              child: Tooltip(
                                message:
                                    getAdjustedCountryName(covidData.country),
                                waitDuration: Duration(seconds: 1),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    getAdjustedCountryName(covidData.country),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: -15,
                          child: Icon(
                            (covidData.isBookrmarked == true)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Confirmed: ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                covidData.totalConfirmed.toString(),
                                style: TextStyle(
                                  color: Colors.amber[700],
                                  fontFamily: 'u_m',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Deaths: ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                covidData.totalDeaths.toString(),
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontFamily: 'u_m',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Recovered: ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                covidData.totalRecovered.toString(),
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontFamily: 'u_m',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Population",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    countryDetails.population.toString(),
                                    style: TextStyle(
                                      fontFamily: 'u_m',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
