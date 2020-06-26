import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("About"),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: ListView(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.only(bottom: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        elevation: 5.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Developed By"),
                            ),
                            Divider(
                                thickness: 2.0,
                                height: 5.0,
                                endIndent: 5.0,
                                indent: 5.0),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Mohammad Zaid Quaraishi",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                thickness: 2.0,
                                height: 5.0,
                                endIndent: 30.0,
                                indent: 5.0),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "mzq7080@gmail.com",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                thickness: 2.0,
                                height: 5.0,
                                endIndent: 60.0,
                                indent: 5.0),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "github.com/Qzoz",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0)
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(bottom: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        elevation: 5.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("API Used"),
                            ),
                            Divider(
                                thickness: 2.0,
                                height: 5.0,
                                endIndent: 5.0,
                                indent: 5.0),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "api.covid19api.com",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            Divider(
                                thickness: 2.0,
                                height: 5.0,
                                endIndent: 15.0,
                                indent: 15.0),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "restcountries.eu",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
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
        ));
  }
}
