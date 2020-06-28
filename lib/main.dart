import 'package:covider/services/data_service.dart';
import 'package:covider/services/data_service_impl.dart';
import 'package:covider/views/about_covid.dart';
import 'package:covider/views/about_page.dart';
import 'package:covider/views/countries_data_page.dart';
import 'package:covider/views/country_full_page.dart';
import 'package:covider/views/global_data_page.dart';
import 'package:covider/views/home_page.dart';
import 'package:covider/views/splash_screen.dart';
import 'package:device_simulator/device_simulator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataService dataService = DataServiceImpl();
    return MaterialApp(
      title: 'Covid Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
        fontFamily: 'm_a',
      ),
      initialRoute: '/splashScreen',
      routes: {
        '/splashScreen': (BuildContext ctx) => CovidSplashPage(
              dataService: dataService,
            ),
        '/home': (BuildContext ctx) =>
            MyHomePage(dataService: dataService, title: "Home"),
        '/globalData': (BuildContext ctx) =>
            GlobalDataPage(dataService: dataService, title: "Global Data"),
        '/countryList': (BuildContext ctx) => CountryDataListPage(
            dataService: dataService, title: "Country List"),
        '/countryFull': (BuildContext ctx) => CountryFullPage(
              dataService: dataService,
            ),
        '/about': (BuildContext ctx) => AboutPage(),
        '/aboutCovid': (BuildContext ctx) => CovidInfoModalFullScreen(),
      },
    );
  }
}
