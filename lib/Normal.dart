import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Elements/ageCard.dart';
import 'Elements/genderCard.dart';

void main() => runApp(Normal());

class Normal extends StatefulWidget {
  @override
  _NormalState createState() => _NormalState();
}

class _NormalState extends State<Normal> {
  //declaring some later needed values

  int _genderValue;
  final TextEditingController ageInputController = new TextEditingController();

  //functions

  void _genderInputChanged(int value) {
    setState(() {
      _genderValue = value;
    });
  }

  setGender(int value) {
    setState(() {
      _genderValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _genderValue = 0;
  }

  void _calculateSleepTime(context, int genderValue, ageController) async {
    int sleepTime;
    int age = int.parse(ageController.text);
    if (age <= 1) {
      sleepTime = 15;
    } else if (age <= 2) {
      sleepTime = 14;
    } else if (age <= 5) {
      sleepTime = 12;
    } else if (age <= 13) {
      sleepTime = 10;
    } else if (age <= 17) {
      sleepTime = 9;
    } else if (age <= 64) {
      sleepTime = 8;
    } else {
      sleepTime = 7;
    }

    if (genderValue == 1) {
      sleepTime += 1;
    } 

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return new Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0)
            )
          ),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.hourglass_full),
                title: new Text("You should sleep " +
                    sleepTime.toInt().toString() +
                    " hours"),
              ),
              new ListTile(
                subtitle: new Text(
                  "This app can not replace medical advice.", textAlign: TextAlign.center,),
              )
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return new ListView(
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        AgeCard(
          ageInputController: ageInputController,
        ),
        GenderCard(
          value: _genderValue,
          onChanged: (value) {
            _genderInputChanged(value);
          },
        ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text("How long should I sleep?"),
          onPressed: () {
            if (ageInputController.text.isEmpty == true) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          "Looks like you forgot to enter your age. Please enter it and try again."),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            } else {
              _calculateSleepTime(context, _genderValue, ageInputController);
            }
          },
        ),
      ],
    );
  }
}
