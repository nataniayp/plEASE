import 'package:flutter/material.dart';

class RequestItem {
  String id;
  String category;
  String itemName;
  int quantity;
  DateTime date;
  TimeOfDay time;

  RequestItem({this.id, this.category, this.itemName, this.quantity, this.time});
}