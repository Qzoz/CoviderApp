import 'package:flutter/material.dart';

class GlobalDataRow extends StatelessWidget {
  GlobalDataRow(this.text, this.countVal, this.countColor);

  final String text;
  final double textSize = 14.0;
  final int countVal;
  final double countSize = 16.0;
  final Color countColor;
  final double hpad = 25.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: this.hpad,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.text,
            style: TextStyle(
              fontSize: this.textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            this.countVal.toString(),
            style: TextStyle(
              fontSize: this.countSize,
              fontFamily: 'u_m',
              fontWeight: FontWeight.bold,
              color: this.countColor,
            ),
          ),
        ],
      ),
    );
  }
}
