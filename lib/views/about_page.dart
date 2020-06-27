import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: themeData.accentColor,
            size: 30.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
                  padding: EdgeInsets.only(
                      top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.only(bottom: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "About App",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2.0,
                            height: 5.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "   Covidata 19 provides the user with information on all country COVID 19 and other data. With a smooth and simple UI, you can traverse the app easily and all information is accessible to the user in a simple manner.\n\n" +
                                  "   App provides features that make access easy to all the data such as bookmarks, filters, and sorts. These features are also accessible when offline, as it creates a copy of data for offline use and you may update by going to the menu in the top right corner and selecting sync when you are online.",
                              style: TextStyle(color: Colors.grey[700]),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Divider(height: 5.0),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Features",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.done),
                                      SizedBox(width: 5.0),
                                      Expanded(
                                        child: Text(
                                          "Filters list or grid.",
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.done),
                                      SizedBox(width: 5.0),
                                      Expanded(
                                        child: Text(
                                          "Sort data as needed.",
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.done),
                                      SizedBox(width: 5.0),
                                      Expanded(
                                        child: Text(
                                          "Bookmarks to displayed on Home Screen.",
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.done),
                                      SizedBox(width: 5.0),
                                      Expanded(
                                        child: Text(
                                          "Works offline (with last updated data).",
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "NOTE: Since data is coming from different servers, therefore a difference in data may occur for some small duration.",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(bottom: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("API Used"),
                          ),
                          Divider(thickness: 2.0, height: 5.0),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.all_inclusive),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Text(
                                    "api.covid19api.com",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.all_inclusive),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Text(
                                    "restcountries.eu",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(bottom: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Developed By"),
                          ),
                          Divider(thickness: 2.0, height: 5.0),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Qzoz",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Chip(
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.black87,
                                    foregroundColor: Colors.white,
                                    child: Text("@"),
                                  ),
                                  label: Text(
                                    "github.com/Qzoz",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0)
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
