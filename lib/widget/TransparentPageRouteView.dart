import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TransparentPageRouteViewPage extends StatefulWidget {
  TransparentPageRouteViewPage({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  State<StatefulWidget> createState() => _TransparentPageRouteViewState();
}

class _TransparentPageRouteViewState extends State<TransparentPageRouteViewPage>
    with TickerProviderStateMixin {
  AnimationController _backdropAnimationController;
  Animation<double> _backdropAnimation;
  Animation<double> _contentAnimation;

  double _roundLength = 0;
  double _bottomValue = -100;

  double pythagoreanTheorem(double short, double long) {
    return sqrt(pow(short, 2) + pow(long, 2));
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      backdropFilterAnimate(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _backdropAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context);
    final size = mediaQ.size;
    final r =
        pythagoreanTheorem(size.width, size.height * 2 + mediaQ.padding.top) /
            2;
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          child: Center(
            child: Container(
              height: _roundLength,
              width: _roundLength,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_roundLength / 2),
              ),
              child: GestureDetector(
                onTap: willPopFunc,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(r * 2),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Material(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          top: size.height - r,
          left: size.width - r,
          right: size.width - r,
          bottom: -r,
        ),
        Positioned(
          bottom: _bottomValue,
          left: 0,
          right: 0,
          child: WillPopScope(
            child: widget.child,
            onWillPop: willPopFunc,
          ),
        ),
      ],
    );
  }

  Future<bool> willPopFunc() async {
    _backdropAnimationController.fling(velocity: -1.0);
    await Future.delayed(Duration(milliseconds: 500), () {
      Navigator.of(context).pop();
    });
    return true;
  }

  Future backdropFilterAnimate(BuildContext context) async {
    final mediaQ = MediaQuery.of(context);
    final size = mediaQ.size;
    final r =
        pythagoreanTheorem(size.width, size.height * 2 + mediaQ.padding.top) /
            2;
    _backdropAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: _backdropAnimationController, curve: Curves.easeInOutCubic);
    CurvedAnimation curvedAnimationContent = CurvedAnimation(
        parent: _backdropAnimationController, curve: Curves.bounceOut);
    _contentAnimation = Tween(begin: -100.0, end: 100.0).animate(curvedAnimationContent);
    _backdropAnimation = Tween(begin: 0.0, end: r * 2).animate(curvedAnimation)
      ..addListener(() {
        setState(() {
          _roundLength = _backdropAnimation.value;
          _bottomValue = _contentAnimation.value;
        });
      });

    await _backdropAnimationController.forward();
  }
}
