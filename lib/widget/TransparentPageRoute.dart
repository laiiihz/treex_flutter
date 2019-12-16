import 'package:flutter/material.dart';
import 'package:treex_flutter/widget/TransparentPageRouteView.dart';

class TransparentPageRoute extends PageRoute<void> {
  TransparentPageRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);
  final WidgetBuilder builder;
  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return Semantics(
      child: TransparentPageRouteViewPage(
        child: result,
      ),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  // TODO: implement opaque
  bool get opaque => false;
  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration.zero;
}
