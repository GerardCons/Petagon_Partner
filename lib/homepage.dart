import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petagon_admin/infoSheetPage.dart';
import 'package:petagon_admin/main.dart';
import 'package:petagon_admin/model/infosheet.dart';
import 'package:petagon_admin/model/partner.dart';
import 'package:petagon_admin/qr_scanner.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePageScreen extends StatefulWidget {
  final String partnerName;
  const HomePageScreen({Key? key, required this.partnerName}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int numberOfPets = 0;
  List<dynamic> petData = [];
  String documentId = "";
  _signOut() async {
    await FirebaseAuth.instance.signOut();

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _signOut,
              icon: const FaIcon(
                FontAwesomeIcons.doorOpen,
                color: Colors.white,
              )),
        ],
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              widget.partnerName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                largeSizeConstraints:
                    BoxConstraints.tightFor(height: 70, width: 70))),
        child: FloatingActionButton.large(
            backgroundColor: Colors.blue.shade600,
            foregroundColor: Colors.white,
            child: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ScanQrCodePage(
                        partnerName: widget.partnerName,
                      )));
            }),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Partners>>(
            stream: readInfoPage(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something Went Wrong ${snapshot.error}');
              } else if (snapshot.hasData) {
                final pets = snapshot.data!;
                numberOfPets = pets.first.petInfo.length;
                List<InfoSheet> petList = pets.first.petInfo;
                if (pets.isNotEmpty) {
                  return ListView.builder(
                    itemCount: numberOfPets,
                    itemBuilder: (context, index) {
                      final pet = pets.first.petInfo[index];

                      return Slidable(
                          endActionPane: ActionPane(
                            motion: BehindMotion(),
                            children: [
                              SlidableAction(
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: 'Remove',
                                  onPressed: ((context) async {
                                    petList.removeAt(index);
                                    final docInfo = FirebaseFirestore.instance
                                        .collection("Place Directory")
                                        .doc(documentId);
                                    final clinicPetData = {'petInfo': petList};
                                    await docInfo.update(clinicPetData);
                                  }))
                            ],
                          ),
                          child: buildPets(pet));
                    },
                  );
                } else {
                  return Container();
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget buildPets(InfoSheet info) => GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => InfoSheetPage(
                  petID: info.petID.toString(),
                  infoID: info.infoID,
                  partnerName: widget.partnerName,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.black,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(info.petImageUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Name:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  info.petName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "(${info.petKind})",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Owner Name : ${info.firstname} ${info.lastname}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Contact Number: ${info.mobile}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));

  Stream<List<Partners>> readInfoPage() {
    return FirebaseFirestore.instance
        .collection("Place Directory")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((QueryDocumentSnapshot<Object?> element) =>
                element['name'].toString().contains(widget.partnerName))
            .map((doc) => Partners.fromJson(doc.data()))
            .toList());
  }
}
