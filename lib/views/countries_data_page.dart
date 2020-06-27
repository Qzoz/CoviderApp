import 'dart:async';

import 'package:covider/models/covid.dart';
import 'package:covider/services/data_service.dart';
import 'package:covider/services/data_service_impl.dart';
import 'package:covider/services/sort_service.dart';
import 'package:covider/widgets/covid_country_grid.dart';
import 'package:covider/widgets/covid_country_list.dart';
import 'package:covider/widgets/covid_list_filter.dart';
import 'package:covider/widgets/panels_backdrop.dart';
import 'package:covider/widgets/popup_menu.dart';
import 'package:flutter/material.dart';

class CountryDataListPage extends StatefulWidget {
  CountryDataListPage({this.title, this.dataService});
  final String title;
  final DataService dataService;

  @override
  _CountryDataListPageState createState() => _CountryDataListPageState();
}

class _CountryDataListPageState extends State<CountryDataListPage>
    with TickerProviderStateMixin {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController animationController;
  AnimationController animationControllerGridList;
  DataService dataService;
  String lastUpdatedDate = "";
  String filterBtnVal = "Filter";
  bool isListViewSel = true;
  bool isBookHintVisible = true;

  List<CountryData> filteredList;
  List<CountryData> covidDataList;
  List<double> maxCDR;

  Map filterMap = {};

  @override
  void initState() {
    this.dataService = widget.dataService;
    filterMap = {};
    this.updateAll();
    animationController = AnimationController(
      vsync: this,
      value: 1.0,
      duration: Duration(milliseconds: 900),
      reverseDuration: Duration(milliseconds: 900),
    );
    animationControllerGridList = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    animationControllerGridList.dispose();
    filteredList = null;
    filterMap = null;
    covidDataList = null;
  }

  bool get isHiddenRevealed {
    final AnimationStatus status = animationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  bool get isListViewDisplayed {
    bool temp = false;
    final AnimationStatus status = animationControllerGridList.status;
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.forward) {
      temp = true;
    }
    this.setState(() {
      this.isListViewSel = temp;
    });
    return isListViewSel;
  }

  void displayInSnackBar(String text, int duraSec) {
    globalScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: duraSec),
    ));
  }

  void updateStateVars() {
    this.setState(() {
      this.lastUpdatedDate =
          getReadableDateTime(dataService.getCovidData().date);
      this.covidDataList = dataService.getCovidData().countries;
      this.filteredList = this.covidDataList.sublist(0);
      this.maxCDR = getMaxCDR(covidDataList);
    });
  }

  void updateAll() {
    dataService.isCovidDataReady().then((res) {
      if (res) {
        updateStateVars();
      }
      Timer(Duration(seconds: 5), () {
        setState(() {
          isBookHintVisible = false;
        });
      });
    });
  }

  Widget getFilterButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          filterBtnVal,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  void _onPanelGesture() {
    isBookHintVisible = false;
    animationController.fling(velocity: isHiddenRevealed ? -1.0 : 1.0);
    if (isHiddenRevealed) {
      setState(() {
        filterBtnVal = "Filter";
        this.filteredList =
            getFilteredCovidDataList(this.covidDataList, this.filterMap);
      });
    } else {
      setState(() {
        filterBtnVal = "Apply";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.view_list,
              progress: animationControllerGridList.view,
            ),
            onPressed: () {
              animationControllerGridList.fling(
                  velocity: (isListViewDisplayed) ? -1.0 : 1.0);
            },
          ),
          MyPopUpMenuWidget((selected) {
            if (selected == PopupMenuVals.menu1[0]) {
              syncData(dataService).then((res) {
                if (res[0]) {
                  displayInSnackBar("Updated", 2);
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
      body: MyPanelsBackdrop(
        controller: animationController,
        frontPanelWidget: Column(
          children: <Widget>[
            Text(
              "Updated: " + lastUpdatedDate,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            (isBookHintVisible)
                ? Chip(
                    label: Text("Long Press to Bookmark"),
                    deleteIcon: Icon(Icons.clear),
                    onDeleted: () {
                      setState(() {
                        isBookHintVisible = !isBookHintVisible;
                      });
                    },
                  )
                : SizedBox(height: 5.0),
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.data == false)
                    return Center(child: Text("No Data Available"));
                  try {
                    if (this.filteredList.length == 0)
                      return Center(child: Text("No Data Matched"));
                  } catch (e) {}
                  if (this.isListViewSel)
                    return CovidCountryDataListView(
                        this.filteredList, dataService);
                  else
                    return CovidCountryDataGridView(
                        this.filteredList, dataService);
                },
                future: dataService.isCovidDataReady(),
              ),
            ),
            Text("Country Count: " +
                (this.filteredList == null
                    ? "0"
                    : this.filteredList.length.toString())),
          ],
        ),
        middleWidget: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80.0),
            topRight: Radius.circular(80.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          onTap: () => _onPanelGesture(),
          splashColor: Colors.black,
          child: getFilterButtonWidget(),
        ),
        backPanelWidget: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return CovidDataListFilter(this.maxCDR, (key, value) {
                filterMap.update(key, (currVal) => value,
                    ifAbsent: () => value);
              });
            }
            return Text("Filter");
          },
          future: dataService.isCovidDataReady(),
        ),
      ),
    );
  }
}
