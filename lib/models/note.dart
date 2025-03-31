import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Note {
  String mail;
  int note;
  String commentaire;
  String date;
  String nomAuteur;
  String prenomAuteur;

  Note({
    required this.mail,
    required this.note,
    required this.commentaire,
    required this.date,
    required this.nomAuteur,
    required this.prenomAuteur
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
      note: int.parse(map['note']),
      mail: map['emailpersonne'].toString(),
      commentaire: map['commentaire'].toString(),
      date: map['date'] as String,
      nomAuteur: map['nompersonne'].toString(),
      prenomAuteur: map['prenompersonne'].toString(),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "note": note,
      "mail": mail,
      "commentaire": commentaire,
      "date": date,
      "nomAuteur": nomAuteur,
      "prenomAuteur": prenomAuteur,
    };
  }

}

