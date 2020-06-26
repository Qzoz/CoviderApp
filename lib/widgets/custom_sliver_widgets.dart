import 'package:flutter/material.dart';

class CoviderSliverWidget extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Size screenHeight;
  final String title;
  final Function onBackPressed;

  CoviderSliverWidget(
      this.expandedHeight, this.title, this.screenHeight, {this.onBackPressed});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 64.0,
                ),
                Expanded(
                  child: Text(
                    this.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Material(
              borderRadius: BorderRadius.circular(50.0),
              color: Theme.of(context).primaryColor,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  this.onBackPressed();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
