import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Note {
  int osmid;
  String mail;
  int note;
  String commentaire;
  String date;


  Note({
    required this.osmid,
    required this.mail,
    required this.note,
    required this.commentaire,
    required this.date,
  });

  String getDateDiff() {
    DateTime date = DateFormat("yyyy-MM-dd").parse(this.date);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    int years = (difference.inDays / 365).floor();
    int months = ((difference.inDays % 365) / 30).floor();
    int days = (difference.inDays % 30);

    if (years > 0) {
      return "$years ans";
    } else if (months > 0) {
      return "$months mois";
    } else {
      return "$days jours";
    }
  }

  factory Note.fromMap(Map<String, dynamic> map){
    return Note(
      osmid: int.parse(map['osmid']),
      note: int.parse(map['note']),
      mail: map['emailpersonne'].toString(),
      commentaire: map['commentaire'].toString(),
      date: map['date'].toString(),

    );
  }


  Map<String, dynamic> toMap() {
    return {
      "mail": mail,
      "osmid": osmid,
      "note": note,
      "commentaire": commentaire,
      "date": date,
    };
  }

}

