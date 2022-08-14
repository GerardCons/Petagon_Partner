class Partners {
  String partnerID;
  String name;
  String imageUrl;
  String category;
  String address;
  String contactPerson;
  String contactNumber;
  String loginEmail;
  String loginPassword;

  Partners({
    required this.partnerID,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.address,
    required this.contactPerson,
    required this.contactNumber,
    required this.loginEmail,
    required this.loginPassword,
  });

  Map<String, dynamic> toJson() => {
        'partnerID': partnerID,
        'name': name,
        'imageUrl': imageUrl,
        'category': category,
        'address': address,
        'contactPerson': contactPerson,
        'contactNumber': contactNumber,
        'loginEmail': loginEmail,
        'loginPassword': loginPassword,
      };

  static Partners fromJson(Map<String, dynamic> json) => Partners(
        partnerID: json['partnerID'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        category: json['category'],
        address: json['address'],
        contactPerson: json['contactPerson'],
        contactNumber: json['contactNumber'],
        loginEmail: json['loginEmail'],
        loginPassword: json['loginPassword'],
      );
}
