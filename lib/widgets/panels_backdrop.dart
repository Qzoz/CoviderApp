import 'package:flutter/material.dart';

class MyPanelsBackdrop extends StatefulWidget {
  final AnimationController controller;
  final Widget frontPanelWidget;
  final Widget backPanelWidget;
  final Widget middleWidget;

  MyPanelsBackdrop(
      {this.controller,
      this.frontPanelWidget,
      this.backPanelWidget,
      this.middleWidget});

  @override
  _MyPanelsBackdropState createState() => _MyPanelsBackdropState();
}

class _MyPanelsBackdropState extends State<MyPanelsBackdrop> {
  static const double frontPanelHideHeight = 50.0;

  Animation<RelativeRect> getPanelDropAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - frontPanelHideHeight;
    final frontPanelHeight = -frontPanelHideHeight;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(CurvedAnimation(
      parent: widget.controller,
      curve: Curves.decelerate,
      reverseCurve: Curves.decelerate,
    ));
  }

  Widget getBothPanels(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: double.infinity,
            color: theme.primaryColor,
            child: widget.backPanelWidget,
          ),
          PositionedTransition(
            rect: getPanelDropAnimation(constraints),
            child: Container(
              color: theme.primaryColor,
              child: Material(
                elevation: 10.0,
                color: Colors.grey[700],
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: frontPanelHideHeight,
                        child: widget.middleWidget,
                      ),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          color: theme.accentColor,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: widget.frontPanelWidget,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: getBothPanels);
  }
}
