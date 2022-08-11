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
  bool vacRecord_distemper;
  bool vacRecord_hepatitis;
  bool vacRecord_parvovirus;
  bool vacRecord_rabies;
  bool vacRecord_kennelCough;
  bool vacRecord_felinedistemper;
  bool vacRecord_rhinotracheitis;
  bool vacRecord_calicvirus;
  String petName;
  String petKind;
  String petBreed;
  String petGender;
  String petDOB;
  final String firstname;
  final String lastname;
  final String mobile;
  final String address;

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
    this.vacRecord_distemper = false,
    this.vacRecord_hepatitis = false,
    this.vacRecord_parvovirus = false,
    this.vacRecord_rabies = false,
    this.vacRecord_kennelCough = false,
    this.vacRecord_felinedistemper = false,
    this.vacRecord_rhinotracheitis = false,
    this.vacRecord_calicvirus = false,
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'infoID': infoID,
        'ownerID': ownerID,
        'ownerImageUrl': ownerImageUrl,
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
        'vacRecord_distemper': vacRecord_distemper,
        'vacRecord_hepatitis': vacRecord_hepatitis,
        'vacRecord_parvovirus': vacRecord_parvovirus,
        'vacRecord_rabies': vacRecord_rabies,
        'vacRecord_kennelCough': vacRecord_kennelCough,
        'vacRecord_felinedistemper': vacRecord_felinedistemper,
        'vacRecord_rhinotracheitis': vacRecord_rhinotracheitis,
        'vacRecord_calicvirus': vacRecord_calicvirus,
        'petName': petName,
        'petKind': petKind,
        'petBreed': petBreed,
        'petGender': petGender,
        'petDOB': petDOB,
      };

  static InfoSheet fromJson(Map<String, dynamic> json) => InfoSheet(
        infoID: json['infoID'],
        ownerID: json['ownerID'],
        firstname: json['firstName'],
        ownerImageUrl: json['ownerImageUrl'],
        lastname: json['lastName'],
        email: json['email'],
        mobile: json['contactNumber'],
        address: json['address'],
        petID: json['petID'],
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
        vacRecord_distemper: json['vacRecord_distemper'],
        vacRecord_hepatitis: json['vacRecord_hepatitis'],
        vacRecord_parvovirus: json['vacRecord_parvovirus'],
        vacRecord_rabies: json['vacRecord_rabies'],
        vacRecord_kennelCough: json['vacRecord_kennelCough'],
        vacRecord_felinedistemper: json['vacRecord_felinedistemper'],
        vacRecord_rhinotracheitis: json['vacRecord_rhinotracheitis'],
        vacRecord_calicvirus: json['vacRecord_calicvirus'],
      );
}
