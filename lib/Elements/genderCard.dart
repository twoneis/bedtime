import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GenderCard extends StatefulWidget {
  final int value;
  final Function onChanged;

  GenderCard({
    @required this.value,
    @required this.onChanged
  });

  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text("What's your gender?"),
          ),
          new RadioListTile(
            value: 0,
            groupValue: widget.value,
            title: Text("Male"),
            onChanged: (value) {
              widget.onChanged(value);
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          new RadioListTile(
            value: 1,
            groupValue: widget.value,
            title: Text("Female"),
            onChanged: (value) {
              widget.onChanged(value);
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          new RadioListTile(
            value: 2,
            groupValue: widget.value,
            title: Text("Other"),
            onChanged: (value) {
              widget.onChanged(value);
            },
            activeColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      elevation: 2,
    );
  }
}
