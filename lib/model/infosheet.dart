// ignore_for_file: non_constant_identifier_names

class InfoSheet {
  String infoID;
  String ownerID;
  String ownerImageUrl;
  String email;
  String petID;
  String petImageUrl;
  int age;
  int pendingReports;
  bool isVaccinated;
  bool isVerified;
  bool isPCCIRegistered;
  String petName;
  String petKind;
  String petBreed;
  String petGender;
  String petDOB;
  final String firstname;
  final String lastname;
  final String mobile;
  final String address;
  List<Vaccine> vaccines;

  InfoSheet({
    this.infoID = '',
    this.ownerID = '',
    this.ownerImageUrl = '',
    this.email = '',
    this.petID = '',
    this.petImageUrl = '',
    this.petName = '',
    this.petKind = '',
    this.petBreed = '',
    this.petGender = '',
    this.petDOB = '',
    this.age = 0,
    this.pendingReports = 0,
    this.isVaccinated = false,
    this.isVerified = false,
    this.isPCCIRegistered = false,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.address,
    this.vaccines = const [],
  });

  Map<String, dynamic> toJson() => {
        'infoID': infoID,
        'ownerID': ownerID,
        'imageUrl': ownerImageUrl,
        'firstName': firstname,
        'lastName': lastname,
        'email': email,
        'contactNumber': mobile,
        'address': address,
        'petID': petID,
        'petImageUrl': petImageUrl,
        'age': age,
        'pendingReports': pendingReports,
        'isVaccinated': isVaccinated,
        'isVerified': isVerified,
        'isPCCIRegistered': isPCCIRegistered,
        'petName': petName,
        'petKind': petKind,
        'petBreed': petBreed,
        'petGender': petGender,
        'petDOB': petDOB,
        'vaccineRecords': vaccines,
      };

  static InfoSheet fromJson(Map<String, dynamic> json) => InfoSheet(
      infoID: json['infoID'],
      ownerID: json['ownerID'],
      firstname: json['firstName'],
      ownerImageUrl: json['imageUrl'],
      lastname: json['lastName'],
      email: json['email'],
      mobile: json['contactNumber'],
      address: json['address'],
      petID: json['petId'],
      petImageUrl: json['petImageUrl'],
      age: json['age'],
      pendingReports: json['pendingReports'],
      isVaccinated: json['isVaccinated'],
      isVerified: json['isVerified'],
      isPCCIRegistered: json['isPCCIRegistered'],
      petName: json['petName'],
      petKind: json['petKind'],
      petBreed: json['petBreed'],
      petGender: json['petGender'],
      petDOB: json['petDOB'],
      vaccines: Vaccine.fromJsonArray(json['vaccineRecords']));
}

class Vaccine {
  final bool isVaccinated;
  final String recordName;

  Vaccine({required this.isVaccinated, required this.recordName});

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
        isVaccinated: json['isVaccinated'], recordName: json['recordName']);
  }

  static List<Vaccine> fromJsonArray(List<dynamic> jsonArray) {
    List<Vaccine> vaccineFromJson = [];

    jsonArray.forEach((jsonData) {
      vaccineFromJson.add(Vaccine.fromJson(jsonData));
    });
    return vaccineFromJson;
  }
}
