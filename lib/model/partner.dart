class Partners {
  String loginId;
  String name;
  String loginEmail;
  String loginPassword;

  Partners({
    required this.loginId,
    required this.name,
    required this.loginEmail,
    required this.loginPassword,
  });

  static Partners fromJson(Map<String, dynamic> json) => Partners(
        loginId: json['loginId'],
        name: json['name'],
        loginEmail: json['loginEmail'],
        loginPassword: json['loginPassword'],
      );
}
