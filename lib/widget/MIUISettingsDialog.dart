import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treex_flutter/generated/i18n.dart';

showMIUIDialog({
  @required BuildContext context,
  @required double dyOffset,
  @required Widget content,
  @required String label,
  bool dismissible = true,
  bool haveTextField = false,
  Color color = Colors.white,
}) {
  showGeneralDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierLabel: label,
      barrierDismissible: dismissible,
      transitionDuration: Duration(milliseconds: 250),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Color(0xff222124)
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  content,
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final value = Curves.easeInOutCubic.transform(animation.value);
        return Transform.translate(
          offset: Offset(0, (1 - value) * dyOffset * 1000),
          child: child,
        );
      });
}

showMIUIConfirmDialog({
  @required BuildContext context,
  @required Widget child,
  @required String title,
  @required VoidCallback confirm,
}) {
  showMIUIDialog(
      context: context,
      dyOffset: 0.4,
      content: MIUIConfirmContent(
        child: child,
        title: title,
        confirm: confirm,
      ),
      label: '${Random().nextDouble()}');
}

class MIUIConfirmContent extends StatelessWidget {
  MIUIConfirmContent({
    Key key,
    @required this.child,
    @required this.title,
    @required this.confirm,
  }) : super(key: key);
  final Widget child;
  final String title;
  final VoidCallback confirm;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MIUIDialogTitle(this.title),
        this.child,
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: MIUIDialogButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).cancel),
              ),
            ),
            SizedBox(width: 25),
            Expanded(
              child: MIUIDialogButton(
                onPressed: this.confirm,
                colored: true,
                child: Text(S.of(context).confirm),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MIUIDialogButton extends StatelessWidget {
  MIUIDialogButton({
    Key key,
    @required this.onPressed,
    @required this.child,
    this.colored = false,
  }) : super(key: key);
  final VoidCallback onPressed;
  final bool colored;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Color(0xff2F2E31)
          : Color(0xfff6f6f6),
      focusColor: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Color(0xff2F2F2F)
          : Color(0xffe5e5e5),
      splashColor: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Color(0xff2F2F2F)
          : Color(0xffe5e5e5),
      onPressed: this.onPressed,
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 18,
            color: colored
                ? Colors.blue
                : MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
          ),
          child: this.child),
    );
  }
}

class MIUIDialogTitle extends StatelessWidget {
  MIUIDialogTitle(
    this.title, {
    Key key,
  })  : assert(title != null),
        super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          '新建文件夹',
          style: TextStyle(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class MIUIDialogTextField extends StatelessWidget {
  MIUIDialogTextField({
    Key key,
    @required this.textEditingController,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final borderDecoration = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff0196FF), width: 2),
    borderRadius: BorderRadius.circular(16),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '请输入文件夹名称',
          style: TextStyle(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              fontSize: 18),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: TextField(
            controller: this.textEditingController,
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Color(0xff141414)
                      : Color(0xffeeeeee),
              border: borderDecoration,
              disabledBorder: borderDecoration,
              enabledBorder: borderDecoration,
              errorBorder: borderDecoration,
              focusedErrorBorder: borderDecoration,
              focusedBorder: borderDecoration,
            ),
          ),
        )
      ],
    );
  }
}
