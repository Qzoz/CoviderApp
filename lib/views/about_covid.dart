import 'package:covider/busy/file_handle.dart';
import 'package:flutter/material.dart';

class CovidInfoModalFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeData.primaryColor,
        appBar: AppBar(
          backgroundColor: themeData.primaryColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: themeData.accentColor,
              size: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "COVID 19",
            style: TextStyle(color: themeData.accentColor),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: ListView(
                    padding: EdgeInsets.only(
                        top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                    children: <Widget>[
                      FutureBuilder(
                        builder: (context, snapshot) {
                          return (snapshot.data != null)
                              ? Text(
                                  snapshot.data,
                                  textAlign: TextAlign.justify,
                                )
                              : Text("Unable to load data");
                        },
                        future: readAssetsAboutCovidFile(),
                        initialData: "Unable to load data",
                      ),
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
