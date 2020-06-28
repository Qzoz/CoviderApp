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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double aspectRatio = 1 / 1.8;
    int gridChildPerRow = 2;
    if (width > 360) {
      aspectRatio = 1 / 1.65;
    }
    if (width > 400) {
      aspectRatio = 1 / 1.55;
    }
    if (width > 479) {
      aspectRatio = 1 / 1.30;
    }
    if (width >= 540) {
      gridChildPerRow = 3;
      aspectRatio = 1 / 1.75;
    }
    if (width >= 600) {
      gridChildPerRow = 3;
      aspectRatio = 1 / 1.55;
    }
    if (width >= 768) {
      gridChildPerRow = 4;
      aspectRatio = 1 / 1.55;
    }
    if (width >= 800) {
      gridChildPerRow = 4;
      aspectRatio = 1 / 1.50;
    }
    return GridView.builder(
      itemCount: widget.covidDataList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridChildPerRow,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (BuildContext context, int index) {
        CountryData covidData = widget.covidDataList[index];
        CountryDetails countryDetails =
            widget.dataService.getCountryDataByCode(covidData.countryCode);
        var population = <Widget>[
          Divider(
            thickness: 2,
          ),
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
        ];
        if (width < 360) {
          population = <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Population",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    countryDetails.population.toString(),
                    style: TextStyle(
                      fontFamily: 'u_m',
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ];
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
                                message: covidData.country,
                                waitDuration: Duration(seconds: 1),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    covidData.country,
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
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Confirmed: ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  covidData.totalConfirmed.toString(),
                                  style: TextStyle(
                                    color: Colors.amber[700],
                                    fontFamily: 'u_m',
                                  ),
                                  textAlign: TextAlign.end,
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
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Deaths: ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  covidData.totalDeaths.toString(),
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontFamily: 'u_m',
                                  ),
                                  textAlign: TextAlign.end,
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
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Recovered: ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  covidData.totalRecovered.toString(),
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontFamily: 'u_m',
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: population),
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
