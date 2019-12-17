import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';

class PhotoHelperPage extends StatefulWidget {
  PhotoHelperPage({Key key, @required this.file}) : super(key: key);
  final FileSystemEntity file;
  @override
  State<StatefulWidget> createState() => _PhotoHelperState();
}

class _PhotoHelperState extends State<PhotoHelperPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  bool _showAppBar = true;
  double _offsetTop = 20.0;

  AnimationController _scaleAnimationController;
  Animation _scaleAnimation;
  double _scale = 1.0;
  bool _scaled = false;
  double _calScale = 1.0;

  double _dx = 0;
  double _dy = 0;

  double _tapDx = 0;
  double _tapDy = 0;

  double _calDx = 0;
  double _calDy = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 20.0, end: -100.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {
        _offsetTop = _animation.value;
      });
    });
    _scaleAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scaleAnimation =
        Tween(begin: 1.0, end: 2.0).animate(_scaleAnimationController);
    _scaleAnimationController.addListener(() {
      setState(() {
        _calScale = _scaleAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _scaleAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _calDx,
            right: -_calDx,
            top: _calDy,
            bottom: -_calDy,
            child: Center(
              child: Hero(
                tag: 'img',
                child: Material(
                  child: Transform.scale(
                    scale: _calScale,
                    child: Image.file(widget.file),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapFunc,
            onDoubleTap: onDoubleTapFunc,
            onScaleStart: (detail) {
              setState(() {
                _tapDx = detail.focalPoint.dx;
                _tapDy = detail.focalPoint.dy;
                _dx = _calDx;
                _dy = _calDy;
                _scale = _calScale;
              });
            },
            onScaleUpdate: (detail) {
              setState(() {
                _calDx = _dx + detail.focalPoint.dx - _tapDx;
                _calDy = _dy + detail.focalPoint.dy - _tapDy;
                _calScale = _scale * detail.scale;
              });
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: _offsetTop,
            child: Container(
              height: 80,
              child: Row(
                children: <Widget>[
                  BackButton(),
                  Text(getFileShortPath(widget.file)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTapFunc() {
    setState(() {
      _showAppBar = !_showAppBar;
    });
    _animationController.fling(velocity: _showAppBar ? -1.0 : 1.0);
  }

  onDoubleTapFunc() {
    _scaleAnimationController.fling(velocity: _scaled ? -1.0 : 1.0);
    setState(() {
      _scaled = !_scaled;
    });
  }
}
