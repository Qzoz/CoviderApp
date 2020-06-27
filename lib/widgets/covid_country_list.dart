import 'package:covider/models/country.dart';
import 'package:covider/models/covid.dart';
import 'package:covider/services/data_service.dart';
import 'package:flutter/material.dart';

class CovidCountryDataListView extends StatefulWidget {
  final List<CountryData> covidDataList;
  final DataService dataService;

  CovidCountryDataListView(this.covidDataList, this.dataService);

  @override
  _CovidCountryDataListViewState createState() =>
      _CovidCountryDataListViewState();
}

class _CovidCountryDataListViewState extends State<CovidCountryDataListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        CountryData covidData = widget.covidDataList[index];
        CountryDetails countryDetails =
            widget.dataService.getCountryDataByCode(covidData.countryCode);
        Widget iconWidget = Image.asset(countryDetails.getFlagPathInAssets());
        return InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          hoverColor: Colors.black,
          splashColor: Colors.blueGrey,
          onTap: () {
            Navigator.pushNamed(context, '/countryFull',
                arguments: {'details': countryDetails});
          },
          onLongPress: () {
            setState(() {
              widget.dataService.updateBookmark(
                  covidData.countryCode, covidData.isBookrmarked == true);
              covidData.isBookrmarked =
                  (covidData.isBookrmarked == true) ? false : true;
            });
          },
          child: ListTile(
            title: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0, bottom: 3.0),
                  child: Text(covidData.country),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    (covidData.isBookrmarked == true)
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 5.0,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Confirmed: "),
                      Text(
                        covidData.totalConfirmed.toString(),
                        style: TextStyle(
                          color: Colors.amber[700],
                          fontFamily: 'u_m',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Deaths: "),
                      Text(
                        covidData.totalDeaths.toString(),
                        style: TextStyle(
                          color: Colors.red[700],
                          fontFamily: 'u_m',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Recovered: "),
                      Text(
                        covidData.totalRecovered.toString(),
                        style: TextStyle(
                          color: Colors.green[700],
                          fontFamily: 'u_m',
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 5.0,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Population: "),
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
            leading: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                SizedBox(
                  height: 64,
                  width: 64,
                  child: Hero(
                      tag: 'hero-img-' + countryDetails.a3Code,
                      child: iconWidget),
                ),
                Positioned(
                  top: -21.0,
                  left: -16.0,
                  child: Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        topLeft: Radius.circular(10.0),
                      ),
                      side: BorderSide(
                        color: Colors.white,
                        width: 3.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Text((index + 1).toString()),
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.black,
                    labelStyle: TextStyle(
                        color: Colors.white, fontFamily: 'u_m', fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 2,
          height: 8.0,
        );
      },
      itemCount:
          (widget.covidDataList == null) ? 0 : widget.covidDataList.length,
    );
  }
}
