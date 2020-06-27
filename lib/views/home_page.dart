import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:covider/models/country.dart';
import 'package:covider/models/covid.dart';
import 'package:covider/services/data_service.dart';
import 'package:covider/services/data_service_impl.dart';
import 'package:covider/views/about_covid.dart';
import 'package:covider/widgets/popup_menu.dart';
import 'package:covider/widgets/home_options.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.dataService}) : super(key: key);

  final String title;
  final DataService dataService;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();

  Set<String> bookmarked;
  String updateTime = "";
  String updateTimeNews = "";
  DataService dataService;
  DateTime lastBackPress;

  @override
  void initState() {
    bookmarked = Set();
    this.dataService = widget.dataService;
    super.initState();
  }

  void displayInSnackBar(String text, int duraSec) {
    globalScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: duraSec),
    ));
  }

  void updateAll() {
    dataService.isCovidDataReady().then((res) {
      if (res) {
        this.setState(() {
          bookmarked = dataService.getBookmark();
          var date = dataService.getCovidData().date;
          updateTime = getReadableDate(date);
        });
      }
    });
  }

  Future<bool> _closeAppOn2ndTap() {
    DateTime now = DateTime.now();
    if (lastBackPress == null || now.difference(lastBackPress).inSeconds > 2) {
      lastBackPress = now;
      displayInSnackBar("Press Again To Exit", 2);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget getSlideWidget(String tag,
      {bool isBlackBox = true,
      double tagSize = 16.0,
      ImageProvider headImage,
      String headIcon,
      Function onClick}) {
    Color fgColor, bgColor;
    Widget head;
    (isBlackBox) ? fgColor = Colors.white : fgColor = Colors.black;
    (isBlackBox) ? bgColor = Colors.black : bgColor = Colors.grey[300];
    if (headIcon != null) {
      head = Text(
        headIcon,
        style: TextStyle(color: fgColor, fontSize: 20.0, fontFamily: 'u_m'),
      );
    }
    if (headImage != null) {
      head = Image(
        image: headImage,
        height: 50.0,
        width: 50.0,
      );
    }
    Widget container = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                head,
                SizedBox(height: 10),
                Text(
                  tag,
                  style: TextStyle(color: fgColor, fontSize: tagSize),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return (onClick == null)
        ? container
        : InkWell(
            child: container,
            onTap: () => onClick(),
          );
  }

  Widget getValWithUpdateVal(int val, int uVal, Color valColor,
      {double fSize = 15.0, double iSize = 16.0}) {
    var iconsWidget;
    if (uVal > 0)
      iconsWidget = Icons.arrow_upward;
    else if (uVal < 0)
      iconsWidget = Icons.arrow_downward;
    else
      iconsWidget = Icons.remove;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Text(
            val.toString(),
            textAlign: TextAlign.right,
            style:
                TextStyle(color: valColor, fontFamily: 'u_m', fontSize: fSize),
          ),
        ),
        Expanded(
          flex: 6,
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              children: [
                TextSpan(
                  text: (uVal == 0) ? "" : uVal.toString(),
                  style: TextStyle(
                      color: Colors.black, fontSize: fSize, fontFamily: 'u_m'),
                ),
                WidgetSpan(
                  child: Icon(iconsWidget, size: iSize),
                ),
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container())
      ],
    );
  }

  Future<void> confirmRemoveBookmarked(
      CountryData countryData, String flag) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          titleTextStyle:
              TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: 'm_a'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          title: Text('Confirm to Remove'),
          content: Container(
            height: 100,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 26.0,
                        backgroundImage: AssetImage(flag),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 5.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      countryData.country,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Divider(
                                thickness: 1,
                                height: 10.0,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: getValWithUpdateVal(
                                  countryData.totalConfirmed,
                                  countryData.newConfirmed,
                                  Colors.amber[700],
                                  fSize: 12.0,
                                  iSize: 14.0),
                            ),
                            Expanded(
                              flex: 1,
                              child: getValWithUpdateVal(
                                  countryData.totalDeaths,
                                  countryData.newDeaths,
                                  Colors.red[700],
                                  fSize: 12.0,
                                  iSize: 14.0),
                            ),
                            Expanded(
                              flex: 1,
                              child: getValWithUpdateVal(
                                  countryData.totalRecovered,
                                  countryData.newRecovered,
                                  Colors.green[500],
                                  fSize: 12.0,
                                  iSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              textColor: Colors.white,
              onPressed: () {
                removeFromBookmark(countryData);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void removeFromBookmark(CountryData countryData) {
    setState(() {
      dataService.updateBookmark(
          countryData.countryCode, countryData.isBookrmarked == true);
      countryData.isBookrmarked =
          (countryData.isBookrmarked == true) ? false : true;
      bookmarked.remove(countryData.countryCode);
    });
  }

  Widget getBookmarkedCarousel() {
    if (bookmarked.isEmpty) {
      return Text("No Bookmark Added",
          style: TextStyle(color: Colors.grey[500]));
    }
    return CarouselSlider.builder(
      itemCount: bookmarked.length,
      itemBuilder: (BuildContext context, int index) {
        CountryData countryData =
            dataService.getCovidDataByCode(bookmarked.elementAt(index));
        CountryDetails countryDetails =
            dataService.getCountryDataByCode(bookmarked.elementAt(index));
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            hoverColor: Colors.black,
            splashColor: Colors.blueGrey,
            onTap: () {
              Navigator.pushNamed(context, '/countryFull',
                  arguments: {'details': countryDetails});
            },
            onLongPress: () {
              confirmRemoveBookmarked(
                  countryData, countryDetails.getFlagPathInAssets());
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'hero-img-' + countryDetails.a3Code,
                    child: CircleAvatar(
                      radius: 42.0,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 38.0,
                        backgroundImage:
                            AssetImage(countryDetails.getFlagPathInAssets()),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    countryData.country,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Divider(
                              thickness: 1,
                              height: 10.0,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: getValWithUpdateVal(
                                countryData.totalConfirmed,
                                countryData.newConfirmed,
                                Colors.amber[700]),
                          ),
                          Expanded(
                            flex: 1,
                            child: getValWithUpdateVal(countryData.totalDeaths,
                                countryData.newDeaths, Colors.red[700]),
                          ),
                          Expanded(
                            flex: 1,
                            child: getValWithUpdateVal(
                                countryData.totalRecovered,
                                countryData.newRecovered,
                                Colors.green[500]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
          height: 135,
          viewportFraction: 0.9,
          initialPage: 0,
          autoPlay: true,
          scrollDirection: Axis.vertical,
          autoPlayInterval: Duration(seconds: 5),
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enableInfiniteScroll: false),
    );
  }

  void showCovidInfo() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CovidInfoModalFullScreen()));
  }

  @override
  Widget build(BuildContext context) {
    updateAll();
    return WillPopScope(
      onWillPop: _closeAppOn2ndTap,
      child: Scaffold(
        key: globalScaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        body: Column(
          children: <Widget>[
            getBookmarkedCarousel(),
            (bookmarked.length == 0)
                ? SizedBox(
                    height: 20.0,
                  )
                : Text(
                    "Long Press to Remove",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 130.0,
                            viewportFraction: 0.7,
                            initialPage: 0,
                            autoPlay: true,
                            autoPlayCurve: Curves.ease,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          ),
                          items: [
                            getSlideWidget("Fight COVID 19",
                                isBlackBox: false,
                                headImage:
                                    AssetImage("assets/images/covid19.png")),
                            getSlideWidget("Wash Your Hands",
                                headImage: AssetImage(
                                    "assets/images/hand_wash_white.png")),
                            getSlideWidget("Stay Home",
                                isBlackBox: false,
                                headImage:
                                    AssetImage("assets/images/stay_home.png")),
                            getSlideWidget("Keep Distance",
                                headImage: AssetImage(
                                    "assets/images/social_distance_white.png")),
                            getSlideWidget("Cover Your Nose",
                                isBlackBox: false,
                                headImage:
                                    AssetImage("assets/images/cover_nose.png")),
                            getSlideWidget(
                                "Felling Sick?\nConsult Your Doctor.",
                                headImage: AssetImage(
                                    "assets/images/sick_person_white.png")),
                            getSlideWidget("Fever, Cough, Shortness of breath",
                                isBlackBox: false,
                                headIcon: "Symptoms ?", onClick: () {
                              showCovidInfo();
                            }),
                            getSlideWidget("Fight COVID 19",
                                headImage: AssetImage(
                                    "assets/images/covid19_white.png")),
                            getSlideWidget("Wash Your Hands",
                                isBlackBox: false,
                                headImage:
                                    AssetImage("assets/images/hand_wash.png")),
                            getSlideWidget("Stay Home",
                                headImage: AssetImage(
                                    "assets/images/stay_home_white.png")),
                            getSlideWidget("Keep Distance",
                                isBlackBox: false,
                                headImage: AssetImage(
                                    "assets/images/social_distance.png")),
                            getSlideWidget("Cover Your Nose",
                                headImage: AssetImage(
                                    "assets/images/cover_nose_white.png")),
                            getSlideWidget(
                                "Felling Sick?\nConsult Your Doctor.",
                                isBlackBox: false,
                                headImage: AssetImage(
                                    "assets/images/sick_person.png")),
                            getSlideWidget("Fever, Cough, Shortness of breath",
                                headIcon: "Symptoms ?", onClick: () {
                              showCovidInfo();
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.0),
                      HomeOptions(() {
                        Navigator.pushNamed(context, '/globalData');
                      }, true, "assets/images/growth.png", "Global Data",
                          textDisp2: "Last Updated: " + updateTime),
                      HomeOptions(() {
                        Navigator.pushNamed(context, '/countryList');
                      }, false, "assets/images/map.png", "Country Data",
                          textDisp2: "Last Updated: " + updateTime),
                      HomeOptions(() {
                        showCovidInfo();
                      }, true, "assets/images/news.png", "COVID-19 ?"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
