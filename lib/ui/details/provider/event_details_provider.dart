import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsProvider extends ChangeNotifier {
  String formatEventDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('d MMM yyyy').format(date);
  }

  String formatEventTime(Timestamp timestamp) {
    DateTime time = timestamp.toDate();
    return DateFormat('h:mm a').format(time);
  }
}