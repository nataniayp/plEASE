import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:please/models/request_item.dart';
import 'package:please/services/database.dart';

class RequestInputController {

  // add a new request
  Future<void> addRequest(RequestItem req, String uid) async {
    return await DatabaseService(uid: uid).addRequestItem(req);
  }

  final categoryController = StreamController<String>.broadcast();
  StreamSink<String> get _inCategory => categoryController.sink;
  Stream<String> get outCategory => categoryController.stream;

  void setCategory(String category) {
    _inCategory.add(category);
  }

  final itemNameController = StreamController<String>.broadcast();
  StreamSink<String> get _inItemName => itemNameController.sink;
  Stream<String> get outItemName => itemNameController.stream;

  void setItemName(String itemName) {
    _inItemName.add(itemName);
  }

  final quantityController = StreamController<int>.broadcast();
  StreamSink<int> get _inQuantity => quantityController.sink;
  Stream<int> get outQuantity => quantityController.stream;

  void setQuantity(int quantity) {
    _inQuantity.add(quantity);
  }

  final dateController = StreamController<String>.broadcast();
  StreamSink<String> get _inDate => dateController.sink;
  Stream<String> get outDate => dateController.stream;



  void setDate(DateTime date) {
    String dateInString = DateFormat(
        'dd-MM-yyyy').format(date);
    if (dateInString == null || dateInString.isEmpty) {
      _inDate.add("Select date");
    }
    _inDate.add(dateInString);
  }

  final timeController = StreamController<String>.broadcast();
  StreamSink<String> get _inTime => timeController.sink;
  Stream<String> get outTime => timeController.stream;

  void setTime(RequestItem req) {
    if (req.time == null) {
      _inTime.add("Select time");
    }
    _inTime.add(req.getTimeInString());
  }

  void dispose() {
    categoryController.close();
    itemNameController.close();
    quantityController.close();
    dateController.close();
    timeController.close();
  }
}