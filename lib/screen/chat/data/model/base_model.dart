import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class BaseModel<T> {
  String id;
  @TimestampConverter()
  DateTime timestamp;

  BaseModel(this.id, this.timestamp );

  Map<String, dynamic> toJson() => {};

  @override
  String toString() => json.encode(toJson());
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}