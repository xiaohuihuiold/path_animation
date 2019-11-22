import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_animation/path_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<List<Offset>> _animation;

  Path _getPath() {
    Path path = Path();
    path.moveTo(200, 300);
    for (int i = 0; i < 360*5; i++) {
      double x = sin(i / 180 * pi) * 40 * (i / 360);
      double y = cos(i / 180 * pi) * 40 * (i / 360);
      path.lineTo(x + 200, y + 300);
    }
    return path;
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    _animation = PathTween(path: _getPath()).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          _controller.reset();
          _controller.forward();
        },
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: _animation,
            builder: (buildContext, child) {
              return Positioned(
                left: _animation.value[0].dx,
                top: _animation.value[0].dy,
                child: Icon(Icons.account_circle),
              );
            },
          ),
        ],
      ),
    );
  }
}
