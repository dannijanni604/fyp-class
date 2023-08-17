import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Meeting> getDataSource(List<Map<String, dynamic>> data) {
  final List<Meeting> meetings = <Meeting>[];

  for (var e in data) {
    meetings.add(
      Meeting(
        e['task'],
        DateTime.now(),
        e['date'].toDate(),
        AppTheme.kprimaryColor.withOpacity(0.5),
        true,
      ),
    );
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
