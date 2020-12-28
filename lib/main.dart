import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(AppointmentPadding());

class AppointmentPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TapDetails(),
    );
  }
}

class TapDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<TapDetails> {
  String _subjectText, _startTimeText, _endTimeText, _dateText, _timeDetails;

  @override
  void initState() {
    _subjectText = '';
    _startTimeText = '';
    _endTimeText = '';
    _dateText = '';
    _timeDetails = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.day,
            dataSource: getCalendarDataSource(),
            onTap: calendarTapped,
            cellEndPadding: 40,
          ),
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments[0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
    } else if (details.targetElement == CalendarElement.calendarCell) {
      _subjectText = "You have tapped cell";
      _dateText = DateFormat('MMMM dd, yyyy').format(details.date).toString();
      _timeDetails = '';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(child: new Text('$_subjectText')),
            content: Container(
              height: 80,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '$_dateText',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(_timeDetails,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Close'))
            ],
          );
        });
  }
}

_DataSource getCalendarDataSource() {
  final List<Appointment> appointments = <Appointment>[];

  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
    endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
    subject: 'Release Meeting',
    color: Colors.lightBlueAccent,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 2, days: -2)),
    endTime: DateTime.now().add(const Duration(hours: 4, days: -2)),
    subject: 'Performance check',
    color: Colors.amber,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 6, days: -3)),
    endTime: DateTime.now().add(const Duration(hours: 7, days: -3)),
    subject: 'Support',
    color: Colors.green,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
    endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
    subject: 'Retrospective',
    color: Colors.purple,
  ));

  return _DataSource(appointments);
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source){
    appointments = source;
  }
}
