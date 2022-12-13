import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Person{
  String id;
  final String name;
  final int age;
  final DateTime birthday;
  Person({
    this.id='',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() =>{
    'id':id,
    'name': name,
    'age': age,
    'birthday': birthday,
  };

  static Person fromJson(Map<String, dynamic> json)=> Person(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    birthday: (json['birthday'] as Timestamp).toDate(),
  );
}