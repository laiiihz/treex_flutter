import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class CloudListTileWidget extends StatefulWidget {
  CloudListTileWidget({
    Key key,
    @required this.cloudFile,
    @required this.delete,
  }) : super(key: key);
  final dynamic cloudFile;
  final VoidCallback delete;
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
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      closeOnScroll: true,
      actions: <Widget>[
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
        onTap: () {},
        child: ListTile(
          leading:
              widget.cloudFile['isDir'] ? Icon(Icons.folder) : Icon(Icons.note),
          title: Text(widget.cloudFile['name']),
          subtitle: Text('${widget.cloudFile['isDir']?widget.cloudFile['subLength']:widget.cloudFile['length']}|$_date'),
        ),
      ),
    );
  }
}
