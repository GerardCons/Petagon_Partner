import 'package:petagon_admin/model/infosheet.dart';

class Partners {
  String loginId;
  String name;
  String loginEmail;
  String loginPassword;
  List<InfoSheet> petInfo;

  Partners({
    required this.loginId,
    required this.name,
    required this.loginEmail,
    required this.loginPassword,
    required this.petInfo,
  });

  static Partners fromJson(Map<String, dynamic> json) => Partners(
        loginId: json['loginId'],
        name: json['name'],
        loginEmail: json['loginEmail'],
        loginPassword: json['loginPassword'],
        petInfo: InfoSheet.fromJsonArray(json['petInfo']),
      );
}
