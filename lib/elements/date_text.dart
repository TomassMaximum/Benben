import 'dart:developer';

import 'package:flutter/material.dart';

class DateText extends StatelessWidget {
  const DateText({Key? key, required this.dateTime}) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
        "${dateTime.month.toString()}月${dateTime.day.toString()}日 ${getWeekday(dateTime.weekday)}");
  }

  String getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
      case 7:
        return "星期日";
      default:
        log("Error! weekday unexpected: ${weekday.toString()}");
        return "N/A";
    }
  }
}
