import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AgeCard extends StatefulWidget {
  final TextEditingController ageInputController;

  AgeCard({
    @required this.ageInputController,
  });

  @override
  _AgeCardState createState() => _AgeCardState();
}

class _AgeCardState extends State<AgeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              title: Text('How old are you?'),
            ),
            ButtonTheme.bar(
              child: TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.hourglass_empty),
                    hintText: 'Enter your age here'),
                controller: widget.ageInputController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
      elevation: 2,
    );
  }
}