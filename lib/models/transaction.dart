import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String description;
  final double value;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.description,
    @required this.value,
    @required this.date,
  });
}
