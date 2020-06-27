import 'package:covider/services/data_service.dart';
import 'package:covider/services/data_service_impl.dart';
import 'package:flutter/material.dart';

class CovidSplashPage extends StatefulWidget {
  CovidSplashPage({this.dataService});

  final DataService dataService;

  @override
  _CovidSplashPageState createState() => _CovidSplashPageState();
}

class _CovidSplashPageState extends State<CovidSplashPage>
    with SingleTickerProviderStateMixin {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  double borderAnim = 0.0;
  AnimationController _controller;
  Animation _animation;
  Widget _loading;

  @override
  void initState() {
    _loading = SizedBox(
      height: 80.0,
    );
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _controller.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          borderAnim = _animation.value;
        });
      });
    checkForData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void displayInSnackBar(String text, int duraSec) {
    Widget widget = Icon(
      Icons.network_check,
      size: 40.0,
      color: Colors.grey,
    );
    setState(() {
      _loading = widget;
    });
    globalScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: duraSec),
    ));
  }

  void checkForData() async {
    await Future.delayed(Duration(seconds: 2));
    List res = await syncData(widget.dataService);
    if (!res[0])
      displayInSnackBar(res[1], 3);
    else
      setState(() {
        _loading = CircularProgressIndicator(
          strokeWidth: 10.0,
        );
      });
    await Future.delayed(Duration(seconds: 4));
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: globalScaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _loading,
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "by Qzoz",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[300], fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 2.0,
                    width: MediaQuery.of(context).size.width / 3,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 50.0,
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                height: 192.0,
                width: 192.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.lerp(
                      Border.all(color: Colors.amber, width: 1.0),
                      Border.all(color: Colors.red[700], width: 20.0),
                      borderAnim),
                  borderRadius: BorderRadius.all(Radius.circular(96.0)),
                ),
                child: Center(
                  child: Container(
                    height: 128.0,
                    width: 128.0,
                    child: Opacity(
                      opacity: borderAnim,
                      child:
                          Image(image: AssetImage("assets/images/covid.png")),
                    ),
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
