import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';

class CloudListTileWidget extends StatefulWidget {
  CloudListTileWidget({
    Key key,
    @required this.cloudFile,
    @required this.delete,
    @required this.index,
    @required this.onPressed,
  }) : super(key: key);
  final dynamic cloudFile;
  final VoidCallback delete;
  final int index;
  final VoidCallback onPressed;
  @override
  State<StatefulWidget> createState() => _CloudListTileState();
}

class _CloudListTileState extends State<CloudListTileWidget> {
  String _date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(widget.cloudFile['date']);
    setState(() {
      _date = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: widget.index,
      child: SlideAnimation(
        duration: Duration(milliseconds: 400),
        horizontalOffset: 50,
        verticalOffset: 100,
        child: FadeInAnimation(
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.15,
            closeOnScroll: true,
            actions: <Widget>[
              IconSlideAction(
                icon: Icons.get_app,
              ),
              IconSlideAction(
                icon: Icons.share,
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                icon: Icons.delete,
                color: Colors.red,
                onTap: widget.delete,
              ),
            ],
            child: InkWell(
              onTap: widget.onPressed,
              child: ListTile(
                leading: widget.cloudFile['isDir']
                    ? Icon(Icons.folder)
                    : Icon(Icons.note),
                title: Text(widget.cloudFile['name']),
                subtitle: Text('${_buildSizePrefix(context)}|$_date'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _buildSizePrefix(BuildContext context) {
    bool isDir = widget.cloudFile['isDir'];
    if (isDir) {
      return '${widget.cloudFile['subLength']}';
    } else {
      return '${getLengthString(widget.cloudFile['length'])}';
    }
  }
}
