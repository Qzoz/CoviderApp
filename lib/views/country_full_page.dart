import 'package:covider/models/country.dart';
import 'package:covider/models/covid.dart';
import 'package:covider/services/data_service.dart';
import 'package:covider/services/data_service_impl.dart';
import 'package:covider/widgets/custom_sliver_widgets.dart';
import 'package:flutter/material.dart';

class CountryFullPage extends StatefulWidget {
  CountryFullPage({this.dataService});

  final DataService dataService;

  @override
  _CountryFullPageState createState() => _CountryFullPageState();
}

class _CountryFullPageState extends State<CountryFullPage> {
  double expandedHeight = 200.0;

  DataService dataService;
  double _scrollOffset = 200.0;
  ScrollController scrollController;
  bool isStateStarted = true;

  @override
  void initState() {
    this.dataService = widget.dataService;
    scrollController = ScrollController();
    scrollController.addListener(() {
      _scrollListenerForFlag();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    dataService = null;
    scrollController.dispose();
  }

  Widget getTagText(String text, int flex) {
    return Expanded(flex: flex, child: Text(text));
  }

  Widget getValText(
      String text, String family, double size, bool isLeft, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontFamily: family,
          color: Colors.black,
        ),
        textAlign: isLeft ? TextAlign.start : TextAlign.end,
      ),
    );
  }

  Widget getInfoRow(String tag, String val,
      {String valFamily = "m_a",
      double valSize = 16.0,
      bool isLeft = true,
      tflex = 1,
      vFlex = 1}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          getTagText(tag, tflex),
          getValText(val, valFamily, valSize, isLeft, vFlex)
        ],
      ),
    );
  }

  Widget getInfoRowValCol(String tag, List values, {Function columnFunction}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          getTagText(tag, 1),
          Expanded(
            flex: 1,
            child: Column(
              children: columnFunction(values),
            ),
          )
        ],
      ),
    );
  }

  Widget getValWithUpdateVal(int val, int uVal, Color valColor, Color uValColor,
      {String tag = ""}) {
    var iconsWidget;
    if (uVal > 0)
      iconsWidget = Icons.arrow_upward;
    else if (uVal < 0)
      iconsWidget = Icons.arrow_downward;
    else
      iconsWidget = Icons.remove;

    return Column(
      children: <Widget>[
        Text(tag, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Divider(
          height: 5.0,
        ),
        Text(
          val.toString(),
          style: TextStyle(color: valColor, fontFamily: 'u_m', fontSize: 20.0),
        ),
        Divider(
          height: 5.0,
        ),
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(iconsWidget, size: 16.0),
              ),
              TextSpan(
                text: (uVal == 0) ? "" : uVal.toString(),
                style: TextStyle(
                    color: Colors.grey[700], fontSize: 18.0, fontFamily: 'u_m'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getStringListWidgets(List<String> list) {
    List<Widget> widgetList = [];
    if (list.length == 0)
      widgetList.add(Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text("----"),
      ));
    list.forEach((e) {
      widgetList.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end, children: [Text(e)]),
        ),
      );
      widgetList.add(Divider(thickness: 1.0));
    });
    if (widgetList.length > 1) widgetList.removeLast();
    return widgetList;
  }

  List<Widget> getTimeZonesWidgets(List<String> timeZones) {
    List<Widget> widgetList = [];
    if (timeZones.length == 0)
      widgetList.add(Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text("----"),
      ));
    timeZones.forEach((timeZone) {
      widgetList.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Text(
          timeZone,
          style: TextStyle(
            fontFamily: "u_m",
            fontSize: 18.0,
          ),
        ),
      ));
      widgetList.add(Divider(thickness: 1.0));
    });
    if (widgetList.isNotEmpty) widgetList.removeLast();
    return widgetList;
  }

  List<Widget> getLanguagesWidgets(List<Language> languages) {
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Languages"),
      ),
      Divider(thickness: 2.0)
    ];
    languages.forEach((language) {
      widgetList.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(language.name),
              Text(language.nativeName),
            ],
          ),
        ),
      );
      widgetList.add(Divider(thickness: 1.0));
    });
    widgetList.removeLast();
    return widgetList;
  }

  List<Widget> getCurrenciesWidgets(List<Currency> currencies) {
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Currencies"),
      ),
      Divider(thickness: 2.0)
    ];
    currencies.forEach((currency) {
      widgetList.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(child: Text(currency.code == null ? "" : currency.code)),
              Expanded(
                  child: Text(currency.symbol == null ? "" : currency.symbol)),
              Expanded(child: Text(currency.name == null ? "" : currency.name)),
            ],
          ),
        ),
      );
      widgetList.add(Divider(thickness: 1.0));
    });
    widgetList.removeLast();
    return widgetList;
  }

  List<Widget> getAltSpellsWidgets(List<String> spellings) {
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Alternate Spellings"),
      ),
      Divider(thickness: 2.0)
    ];
    spellings.forEach((spelling) {
      widgetList.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(children: [Expanded(child: Text(spelling))]),
        ),
      );
      widgetList.add(Divider(thickness: 1.0));
    });
    widgetList.removeLast();
    return widgetList;
  }

  List<Widget> getRBsWidgets(List<RegionalBlock> rbs) {
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Regional Blocks"),
      ),
      Divider(thickness: 2.0)
    ];
    rbs.forEach((rb) {
      widgetList.add(ListTile(
        title: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    rb.acronym,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1.0, color: Colors.grey[500]),
            Text(rb.name),
          ],
        ),
      ));
      widgetList.add(Divider(thickness: 1.0));
    });
    widgetList.removeLast();
    return widgetList;
  }

  List<Widget> getBordersWidgets(List<String> borderCodes) {
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Border Countries"),
      ),
      Divider(thickness: 2.0)
    ];
    if (borderCodes.length == 0)
      widgetList.add(Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text("No Neighbours"),
      ));
    borderCodes.forEach((borderCode) {
      final CountryDetails borderCountry =
          dataService.getCountryDataByCode3(borderCode);
      widgetList.add(ListTile(
        onTap: () {
          Navigator.pushNamed(context, '/countryFull', arguments: {
            'details': borderCountry,
          });
        },
        title: Text(borderCountry.name),
        leading: Hero(
          tag: 'hero-img-' + borderCountry.a3Code,
          child: Image.asset(
            borderCountry.getFlagPathInAssets(),
            width: 48.0,
          ),
        ),
      ));
    });
    return widgetList;
  }

  void _scrollListenerForFlag() {
    setState(() {
      _scrollOffset = this.expandedHeight - scrollController.position.pixels;
      if (_scrollOffset < 0.0) _scrollOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Map parentArgs = ModalRoute.of(context).settings.arguments;
    if (parentArgs == null)
      return Scaffold(
        body: Container(
          child: Center(
            child: Text("Unable to load Data"),
          ),
        ),
      );
    CountryDetails countryDetails = parentArgs['details'];
    CountryData countryData =
        dataService.getCovidDataByCode(countryDetails.a2Code);
    List<Widget> covidWidgets = [Text("No Covid Data")];
    String lastUpdateDate = "";
    if (countryData != null) {
      covidWidgets = [
        getValWithUpdateVal(countryData.totalConfirmed,
            countryData.newConfirmed, Colors.amber[700], Colors.amber[700],
            tag: "Confirmed"),
        getValWithUpdateVal(countryData.totalDeaths, countryData.newDeaths,
            Colors.red[700], Colors.red[700],
            tag: "Deaths"),
        getValWithUpdateVal(countryData.totalRecovered,
            countryData.newRecovered, Colors.green[700], Colors.green[700],
            tag: "Recovered")
      ];
      lastUpdateDate = "Updated: " + getReadableDateTime(countryData.date);
    }
    if (isStateStarted) {
      if (width > 410) {
        setState(() {
          isStateStarted = false;
          _scrollOffset = 250.0;
          expandedHeight = 250.0;
        });
      }
      if (width > 600) {
        setState(() {
          isStateStarted = false;
          _scrollOffset = 350.0;
          expandedHeight = 350.0;
        });
      }
    }

    double opacity = _scrollOffset / this.expandedHeight;
    if (opacity <= 0.0) opacity = 0.0;
    if (opacity >= 1.0) opacity = 1.0;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Hero(
                    tag: 'hero-img-' + countryDetails.a3Code,
                    child: Image.asset(
                      countryDetails.getFlagPathInAssets(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            CustomScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: CoviderSliverWidget(
                    this.expandedHeight,
                    countryDetails.name,
                    MediaQuery.of(context).size,
                    onBackPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      getDetailsCard(getBasicDetailsWIdgetList(
                          countryDetails, covidWidgets, lastUpdateDate)),
                      getDetailsCard(getExtraDetailsWidgetList(countryDetails)),
                      getDetailsCard(getMiscDetailsWidgetList(countryDetails)),
                      getDetailsCard(getBordersWidgets(countryDetails.borders)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getDetailsCard(List<Widget> list) {
    return Card(
      margin: EdgeInsets.all(7.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      elevation: 7,
      shadowColor: Colors.grey[100],
      child: Column(
        children: list,
      ),
    );
  }

  List<Widget> getMiscDetailsWidgetList(CountryDetails countryDetails) {
    List<Widget> miscDetails = List();
    if (countryDetails.languages.isNotEmpty)
      miscDetails.addAll(getLanguagesWidgets(countryDetails.languages));
    if (countryDetails.currencies.isNotEmpty) {
      miscDetails.add(SizedBox(height: 10.0));
      miscDetails.add(Divider(thickness: 2.0, color: Colors.black));
      miscDetails.addAll(getCurrenciesWidgets(countryDetails.currencies));
    }
    if (countryDetails.altSpellings.isNotEmpty) {
      miscDetails.add(SizedBox(height: 10.0));
      miscDetails.add(Divider(thickness: 2.0, color: Colors.black));
      miscDetails.addAll(getAltSpellsWidgets(countryDetails.altSpellings));
    }
    if (countryDetails.regionalBlocs.isNotEmpty) {
      miscDetails.add(SizedBox(height: 10.0));
      miscDetails.add(Divider(thickness: 2.0, color: Colors.black));
      miscDetails.addAll(getRBsWidgets(countryDetails.regionalBlocs));
    }
    miscDetails.add(SizedBox(
      height: 10.0,
    ));
    return miscDetails;
  }

  List<Widget> getExtraDetailsWidgetList(CountryDetails countryDetails) {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Extra Details"),
      ),
      Divider(thickness: 2.0),
      getInfoRow("Numeric Code", countryDetails.numCode.toString(),
          valFamily: "u_m", valSize: 18.0, isLeft: false),
      getInfoRow("Population", countryDetails.population.toString(),
          valFamily: "u_m", valSize: 18.0, isLeft: false),
      getInfoRow("Area", countryDetails.area.toString(),
          valFamily: "u_m", valSize: 18.0, isLeft: false),
      getInfoRow("Gini", countryDetails.gini.toString(),
          valFamily: "u_m", valSize: 18.0, isLeft: false),
      Divider(thickness: 1.0),
      getInfoRow("Native Name", countryDetails.nativeName),
      getInfoRow("Demonym", countryDetails.demonym),
      getInfoRow("Country Codes",
          countryDetails.a2Code + " , " + countryDetails.a3Code),
      Divider(thickness: 1.0),
      getInfoRow("Latitude", countryDetails.latlang[0].toString(),
          valFamily: "u_m", valSize: 18.0, isLeft: false),
      getInfoRow("Longitude", countryDetails.latlang[1].toString(),
          valFamily: "u_m", valSize: 18.0, isLeft: false),
      Divider(thickness: 1.0),
      getInfoRow("Region", countryDetails.region),
      getInfoRow("Sub Region", countryDetails.subRegion),
      Divider(thickness: 1.0),
      getInfoRowValCol("Time Zone/s", countryDetails.timeZones,
          columnFunction: getTimeZonesWidgets),
      Divider(thickness: 1.0),
      getInfoRowValCol("Call-Code/s", countryDetails.callCodes,
          columnFunction: getStringListWidgets),
      Divider(thickness: 1.0),
      getInfoRowValCol("Top Level Domain/s", countryDetails.tlds,
          columnFunction: getStringListWidgets),
      SizedBox(
        height: 10.0,
      )
    ];
  }

  List<Widget> getBasicDetailsWIdgetList(CountryDetails countryDetails,
      List<Widget> covidWidgets, String lastUpdateDate) {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Country Details"),
      ),
      Divider(thickness: 2.0),
      getInfoRow("Name", countryDetails.name, tflex: 2, vFlex: 3),
      getInfoRow("Capital", countryDetails.capital, tflex: 2, vFlex: 3),
      Divider(
        thickness: 2.0,
      ),
      Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Covid Status"),
      ),
      Divider(
        thickness: 2.0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: covidWidgets,
        ),
      ),
      Divider(thickness: 2.0),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Text(
          lastUpdateDate,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ),
    ];
  }
}
