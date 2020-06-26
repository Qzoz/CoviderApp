import 'package:covider/models/covid.dart';
import 'package:covider/services/data_service.dart';
import 'package:covider/services/data_service_impl.dart';
import 'package:covider/widgets/popup_menu.dart';
import 'package:covider/widgets/global_data_widget.dart';
import 'package:flutter/material.dart';

class GlobalDataPage extends StatefulWidget {
  GlobalDataPage({Key key, this.title, this.dataService}) : super(key: key);

  final String title;
  final DataService dataService;

  @override
  _GlobalDataPageState createState() => _GlobalDataPageState();
}

class _GlobalDataPageState extends State<GlobalDataPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();

  DataService dataService;
  int totalConfirmed = 0;
  int totalDeaths = 0;
  int totalRecovered = 0;
  int newConfirmed = 0;
  int newDeaths = 0;
  int newRecovered = 0;
  String lastUpdateDate = "";

  @override
  void initState() {
    this.dataService = widget.dataService;
    super.initState();
  }

  void update(int conf, int death, int recover, int nconf, int ndeath,
      int nrecover, String date) {
    this.setState(() {
      this.totalConfirmed = conf;
      this.totalDeaths = death;
      this.totalRecovered = recover;
      this.newConfirmed = nconf;
      this.newDeaths = ndeath;
      this.newRecovered = nrecover;
      this.lastUpdateDate = date;
    });
  }

  void displayInSnackBar(String text, int duraSec) {
    globalScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: duraSec),
    ));
  }

  Widget getDividerForMyCard() {
    return Divider(
      height: 20.0,
      indent: 15.0,
      endIndent: 15.0,
      thickness: 2.0,
    );
  }

  void updateAll() {
    dataService.isCovidDataReady().then((res) {
      if (res) {
        CovidData covidData = dataService.getCovidData();
        this.update(
            covidData.global.totalConfirmed,
            covidData.global.totalDeaths,
            covidData.global.totalRecovered,
            covidData.global.newConfirmed,
            covidData.global.newDeaths,
            covidData.global.newRecovered,
            getReadableDateTime(covidData.date));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    updateAll();
    var borderAllCircle50 = BorderRadius.all(
      Radius.circular(50.0),
    );
    return Scaffold(
      key: globalScaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor,
          size: 24.0,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          MyPopUpMenuWidget((selected) {
            if (selected == PopupMenuVals.menu1[0]) {
              syncData(dataService).then((res) {
                if (res[0]) {
                  displayInSnackBar("Done", 2);
                  this.updateAll();
                } else
                  displayInSnackBar(res[1], 3);
              });
            }
            if (selected == PopupMenuVals.menu2[0]) {
              Navigator.pushNamed(context, '/about');
            }
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200], borderRadius: borderAllCircle50),
              child: ClipRRect(
                borderRadius: borderAllCircle50,
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50.0),
                          bottomLeft: Radius.circular(50.0),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      child: Center(
                        child: Text(
                          "Updated: " + lastUpdateDate,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: borderAllCircle50,
                      ),
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: borderAllCircle50,
                            child: Image(
                              image: AssetImage("assets/images/worldmap.png"),
                            ),
                          ),
                          getDividerForMyCard(),
                          GlobalDataRow("Total Confirmed", this.totalConfirmed,
                              Colors.amber[700]),
                          GlobalDataRow("Total Deaths", this.totalDeaths,
                              Colors.red[700]),
                          GlobalDataRow("Total Recovered", this.totalRecovered,
                              Colors.green[700]),
                          getDividerForMyCard(),
                          GlobalDataRow("New Confirmed", this.newConfirmed,
                              Colors.amber[700]),
                          GlobalDataRow(
                              "New Deaths", this.newDeaths, Colors.red[700]),
                          GlobalDataRow("New Recovered", this.newRecovered,
                              Colors.green[700]),
                          getDividerForMyCard(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ButtonBar(
                                children: <Widget>[
                                  FlatButton.icon(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 10.0,
                                    ),
                                    icon: Icon(
                                      Icons.view_list,
                                      size: 20.0,
                                    ),
                                    label: Text(
                                      "Country List",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/countryList');
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
