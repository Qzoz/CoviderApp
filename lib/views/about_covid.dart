import 'package:covider/busy/file_handle.dart';
import 'package:flutter/material.dart';

class CovidInfoModalFullScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
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
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                builder: (context, snapshot) {
                  return (snapshot.data != null)
                      ? Text(snapshot.data)
                      : Text("Unable to load data");
                },
                future: readAssetsAboutCovidFile(),
                initialData: "Unable to load data",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
