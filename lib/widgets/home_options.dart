import 'package:flutter/material.dart';

class HomeOptions extends StatefulWidget {
  HomeOptions(this.onPressed, this.isLeft, this.imageURL, this.textDisp,
      {this.textDisp2});

  final Function onPressed;
  final bool isLeft;
  final String imageURL;
  final String textDisp;
  final String textDisp2;

  @override
  _HomeOptionsState createState() => _HomeOptionsState();
}

class _HomeOptionsState extends State<HomeOptions> {
  Widget getHeadText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget getSmallText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10.0,
        color: Colors.white70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> textList = [getHeadText(widget.textDisp)];
    List<Widget> rowList = [
      Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: (widget.textDisp2 != null)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: textList,
          ),
        ),
      )
    ];

    var roundedBorder;

    if (widget.isLeft) {
      roundedBorder = BorderRadius.only(
        topLeft: Radius.circular(50.0),
        bottomLeft: Radius.circular(50.0),
      );
    } else {
      roundedBorder = BorderRadius.only(
        topRight: Radius.circular(50.0),
        bottomRight: Radius.circular(50.0),
      );
    }

    if (widget.textDisp2 != null) {
      textList.add(getSmallText(widget.textDisp2));
    }

    if (widget.isLeft) {
      rowList.insert(
          1,
          Image(
            image: AssetImage(widget.imageURL),
          ));
    } else {
      rowList.insert(
          0,
          Image(
            image: AssetImage(widget.imageURL),
          ));
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: Material(
        color: Colors.black,
        borderRadius: roundedBorder,
        child: InkWell(
          borderRadius: roundedBorder,
          splashColor: Colors.blueGrey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: roundedBorder,
            ),
            color: Colors.transparent,
            child: Container(
              height: 75.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: rowList,
              ),
            ),
            elevation: 5,
          ),
          onTap: widget.onPressed,
        ),
      ),
    );
  }
}
