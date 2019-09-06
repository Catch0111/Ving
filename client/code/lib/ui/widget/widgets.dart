import 'package:flutter/material.dart';

class OptItem extends StatelessWidget {
  const OptItem({
    Key key,
    this.id,
    this.isOpted,
    this.curNum,
    this.iconData,
  }) : super(key: key);
  final int id;
  final bool isOpted;
  final int curNum;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new SizedBox(
          width: 24.0,
          height: 24.0,
          child: new Icon(
            iconData,
            color: (isOpted == true)
            ? Colors.redAccent
            : Colors.grey,
          ),
        ),
        new Text(
          curNum.toString(),
        )
      ],
    );
  }
}