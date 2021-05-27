import 'package:flutter/material.dart';

class RequestItem {
  String name;
  String category;
  String itemName;
  int quantity;
  DateTime date;
  TimeOfDay time;

  RequestItem(String name, String category, String itemName, int quantity, DateTime date, TimeOfDay time) {
    this.name = name;
    this.category = category;
    this.itemName = itemName;
    this.quantity = quantity;
    this.date = date;
    this.time = time;
  }

  RequestItem.nameOnly(String name) {
    this.name = name;
  }

}