import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int compareTOD(TimeOfDay a, TimeOfDay b) {
  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;
  return toDouble(a).compareTo(toDouble(b));
}

class RequestItem {
  String uid;
  String userName;
  String category;
  String itemName;
  int quantity;
  DateTime date;
  TimeOfDay time;
  bool accepted = false;
  String acceptedBy;
  String acceptedByUid;

  // constructor with optional parameters
  RequestItem([this.uid, this.userName, this.category, this.itemName, this.quantity, this.date, this.time, this.accepted, this.acceptedBy, this.acceptedByUid]);

  void reqAccepted(String acceptedBy, String acceptedByUid) {
    this.accepted = true;
    this.acceptedBy = acceptedBy;
    this.acceptedByUid = acceptedByUid;
  }

  bool isExpired() {
    int val = this.date.compareTo(DateTime.now());
    String dateRequest = this.date.toString().substring(0, this.date.toString().indexOf(' '));
    String dateCurrent = DateTime.now().toString().substring(0, DateTime.now().toString().indexOf(' '));
    if (val < 0 && dateRequest != dateCurrent) {
      return true;
    } else if (val < 0) {
      return compareTOD(this.time, TimeOfDay.now()) < 0;
    } else {
      return false;
    }
  }

  // to compare TimeOfDay of two Request Items for sorting
  int compareReqTOD(RequestItem other) {
    return compareTOD(this.time, other.time);
  }

  // to compare DateTime and TimeOfDay of two Request Items for sorting
  int compareReq(RequestItem other) {
    if ((this.date.compareTo(other.date) != 0)) {
      return this.date.compareTo(other.date);
    } else {
      return this.compareReqTOD(other);
    }
  }

  // for UI
  String getDateInStringWithDay() {
    return DateFormat('EEE, d/M/y,').format(this.date);
  }

  // for firestore
  String getDateInString() {
    return DateFormat('yyyy-MM-dd').format(this.date);
  }

  // for firestore
  String getTimeInString() {
    String hour = this.time.hourOfPeriod.toString();
    String min = this.time.minute < 10 ? '0' + this.time.minute.toString() : this.time.minute.toString();
    int period = this.time.period.index;

    if (period == 0) {
      return hour + ':' + min + ' AM';
    } else {
      return hour + ':' + min + ' PM';
    }
  }

}