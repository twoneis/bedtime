import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/rendering.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'Elements/ageCard.dart';
import 'Elements/genderCard.dart';

void main() => runApp(GetUp());

class GetUp extends StatefulWidget
{
  @override
  _GetUpState createState() => _GetUpState();
}

class _GetUpState extends State<GetUp>
{
  //declaring some later needed values
  int _genderValue;
  final TextEditingController ageInputController = new TextEditingController();
  final TextEditingController timeInputController = new TextEditingController();

  //functions

  void _genderInputChanged(int value)
  {
    setState(() 
    {
      _genderValue = value;
    });
  }

  
  setGender(int value)
  {
    setState(() 
    {
      _genderValue = value;
    });
  }

  @override
  void initState()
  {
    super.initState();
    _genderValue = 0;
  }

  void _calculateSleepTime(context, int genderValue, ageController, timeController)
  {
    int sleepTime;
    int age = int.parse(ageController.text);
    if (age <= 1)
    {
      sleepTime = 15;
    }
    else if (age <= 2)
    {
      sleepTime = 14;
    }
    else if (age <= 5)
    {
      sleepTime = 12;
    }
    else if (age <= 13)
    {
      sleepTime = 10;
    }
    else if (age <= 17)
    {
      sleepTime = 9;
    }
    else if (age <= 64)
    {
      sleepTime = 8;
    }
    else
    {
      sleepTime = 7;
    }

    if (genderValue == 1)
    {
      sleepTime += 1;
    }
    
    List<String> wakeTime = timeController.text.split(":");
    int wakeHours = int.parse(wakeTime[0]);
    int minutes = int.parse(wakeTime[1]);
    int dayhours = 24;
    int hours = wakeHours - sleepTime;

    if (hours < 0)
    {
      hours = dayhours += hours;
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
                leading: new Icon(Icons.brightness_2),
                title: new Text("You should go to bed at " + hours.toString() + ":" + minutes.toString()),
                trailing: FlatButton(
                  child: Icon(Icons.add_alert),
                  onPressed: ()
                  {
                    //set reminder
                  },
                ),
              ),
              new ListTile(
                subtitle: new Text(
                  "This app can not replace medical advice.", textAlign: TextAlign.center,),
              ),
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return new ListView
    (
      padding: const EdgeInsets.all(20.0),
      children: <Widget>
      [
        AgeCard(
          ageInputController: ageInputController,
        ),
        GenderCard(
          value: _genderValue,
          onChanged: (value) {
            _genderInputChanged(value);
          },
        ),
         Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("When do you want to get up?"),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new DateTimePickerFormField(
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    initialTime: TimeOfDay.fromDateTime(DateTime(0, 0, 0, 6, 30)),
                    decoration: InputDecoration(
                      labelText: "Enter time here",
                      floatingLabelBehavior: FloatingLabelBehavior.never
                    ),
                    controller: timeInputController,
                  )),
            ],
          ),
          elevation: 2,
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
            } else if (timeInputController.text.isEmpty == true) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                        "Looks like you forgot to enter the time. Please enter it and try again."),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
            } else {
              _calculateSleepTime(context, _genderValue, ageInputController, timeInputController);
            }
          },
        ),
      ],
    );
  }

}