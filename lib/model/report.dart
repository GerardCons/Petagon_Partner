// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String reportID;
  String infoID;
  String petID;
  String partnerName;
  String description;
  String dateReported;
  Timestamp date;

  Report({
    required this.reportID,
    required this.infoID,
    required this.petID,
    required this.partnerName,
    required this.description,
    required this.dateReported,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'reportID': reportID,
        'infoID': infoID,
        'petID': petID,
        'partnerName': partnerName,
        'description': description,
        'dateReported': dateReported,
        'date': date,
      };

  static Report fromJson(Map<String, dynamic> json) => Report(
        reportID: json['reportID'],
        infoID: json['infoID'],
        petID: json['petID'],
        partnerName: json['partnerName'],
        description: json['description'],
        dateReported: json['dateReported'],
        date: json['date'],
      );
}
