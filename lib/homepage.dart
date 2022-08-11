import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petagon_admin/infoSheetPage.dart';
import 'package:petagon_admin/model/infosheet.dart';
import 'package:petagon_admin/qr_scanner.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Cocos South Bistro',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                  builder: (context) => const ScanQrCodePage()));
            }),
      ),
      body: SafeArea(
        child: StreamBuilder<List<InfoSheet>>(
            stream: readInfoPage(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something Went Wrong');
              } else if (snapshot.hasData) {
                final pets = snapshot.data!;
                if (pets.isNotEmpty) {
                  return ListView(children: pets.map(buildPets).toList());
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
            builder: (context) => InfoSheetPage(petID: info.petID.toString())));
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

  Stream<List<InfoSheet>> readInfoPage() {
    return FirebaseFirestore.instance
        .collection('Cocos South Bistro')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => InfoSheet.fromJson(doc.data()))
            .toList());
  }
}
