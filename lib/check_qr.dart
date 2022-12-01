import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petagon_admin/homepage.dart';
import 'package:petagon_admin/invalid_page.dart';
import 'package:petagon_admin/model/infosheet.dart';

class CheckQrPage extends StatefulWidget {
  final String petID;
  final String partnerName;
  const CheckQrPage({Key? key, required this.petID, required this.partnerName})
      : super(key: key);

  @override
  State<CheckQrPage> createState() => _CheckQrPageState();
}

class _CheckQrPageState extends State<CheckQrPage> {
  List<dynamic> petData = [];
  String documentId = "";
  void getClinicData() async {
    final clinicAccount = await FirebaseFirestore.instance
        .collection('Place Directory')
        .where('name', isEqualTo: widget.partnerName)
        .get();
    documentId = clinicAccount.docs.first.id;
    if (clinicAccount.docs.isNotEmpty) {
      for (var doc in clinicAccount.docs) {
        Map<String, dynamic> data = doc.data();
        petData = data['petInfo'];
      }
    }
  }

  @override
  void initState() {
    getClinicData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<List<InfoSheet>>(
          stream: readInfoPage(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something Went Wrong: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final pet = snapshot.data!;
              if (pet.isEmpty) {
                return InvalidQrPage(
                  partnerName: widget.partnerName,
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Welcome to Petagon ${pet.first.petName}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent),
                      ),
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () async {
                        final docInfo = FirebaseFirestore.instance
                            .collection("Place Directory")
                            .doc(documentId);

                        List<dynamic> vaccines = [];
                        String isVaccinated = 'isVaccinated';
                        String recordName = 'vaccineName';
                        for (int i = 0; i < pet.first.vaccines.length; i++) {
                          vaccines.add({
                            isVaccinated: pet.first.vaccines[i].isVaccinated,
                            recordName: pet.first.vaccines[i].recordName,
                          });
                        }

                        final infoSheet = {
                          "infoId": pet.first.infoID,
                          "ownerId": pet.first.ownerID,
                          "firstName": pet.first.firstname,
                          "ownerImageUrl": pet.first.ownerImageUrl,
                          "lastName": pet.first.lastname,
                          "email": pet.first.email,
                          "contactNumber": pet.first.mobile,
                          "address": pet.first.address,
                          "petId": pet.first.petID,
                          "petImageUrl": pet.first.petImageUrl,
                          "pendingReports": pet.first.pendingReports,
                          "isVaccinated": pet.first.isVaccinated,
                          "isVerified": pet.first.isVerified,
                          "isPcciRegistered": pet.first.isPCCIRegistered,
                          "petName": pet.first.petName,
                          "petKind": pet.first.petKind,
                          "petBreed": pet.first.petBreed,
                          "petGender": pet.first.petGender,
                          "petDateOfBirth": pet.first.petDOB,
                          "vaccineRecords": vaccines,
                        };

                        petData.add(infoSheet);
                        final clinicPetData = {'petInfo': petData};
                        await docInfo.update(clinicPetData);

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePageScreen(
                                  partnerName: widget.partnerName,
                                )));
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.purpleAccent,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildBody(InfoSheet info) => Column();

  Stream<List<InfoSheet>> readInfoPage() {
    return FirebaseFirestore.instance
        .collection('Information Sheet')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((QueryDocumentSnapshot<Object?> element) =>
                element['petId'].toString().contains(widget.petID))
            .map((doc) => InfoSheet.fromJson(doc.data()))
            .toList());
  }
}
