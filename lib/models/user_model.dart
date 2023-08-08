import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? city;
  final String? street;
  final String? home;

  const User({
    required this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.city,
    this.street,
    this.home,
  });


  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  static User fromSnapshot(DocumentSnapshot snapshot) {
    User user = User(
      id: snapshot.id,
      name: snapshot['Display Name'] ?? '',
      email: snapshot['Email'],
      phone: snapshot['Phone'] ?? '',
      city: snapshot['City'] ?? '',
      street: snapshot['Street'] ?? '',
      home: snapshot['Home'] ?? '',
    );
    return user;
  }

  Map<String, dynamic> toFirebaseMap() {
    return {
      'Display Name' : name,
      'Email': email,
      'City': city,
      'Street': street,
      'Home': home,
    };
  }

  factory User.fromForm(
      TextEditingController dpName,
      TextEditingController email,
      TextEditingController city,
      TextEditingController street,
      TextEditingController home
      ){
    return User(
      id: '',
      name: dpName.text,
      email: email.text,
      city: city.text,
      street: street.text,
      home: home.text
    );
  }

  factory User.fromMap(Map<String, dynamic> result) {
    return User(
      id: result['userID'] ?? '',
      name: result['Display Name'],
      email: result['Email'],
      phone: result['Phone'],
      city: result['City'],
      street: result['Street'],
      home: result['Home'],
    );
  }

  @override
  List<Object?> get props => [id, email, name, phone, city, street, home];
}
