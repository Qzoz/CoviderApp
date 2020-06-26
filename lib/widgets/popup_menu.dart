import 'package:flutter/material.dart';

class PopupMenuVals {
  static const List menu1 = ["Sync", Icons.sync];
  static const List menu2 = ["About", Icons.details];

  static List menus = [menu1, menu2];
}

class MyPopUpMenuWidget extends StatelessWidget {

  MyPopUpMenuWidget(this.callback);

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_horiz,
        size: 30.0,
      ),
      itemBuilder: (BuildContext context) => PopupMenuVals.menus.map((e) {
        return PopupMenuItem(
          child: ListTile(
            leading: Icon(e[1]),
            title: Text(e[0]),
          ),
          value: e[0],
        );
      }).toList(),
      onSelected: (selected) {
        this.callback(selected);
      },
    );
  }
}
