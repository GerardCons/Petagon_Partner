// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petagon_admin/homepage.dart';
import 'package:petagon_admin/model/partner.dart';

class VerifyPartnerPage extends StatefulWidget {
  const VerifyPartnerPage({Key? key}) : super(key: key);

  @override
  State<VerifyPartnerPage> createState() => _VerifyPartnerPageState();
}

class _VerifyPartnerPageState extends State<VerifyPartnerPage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Partners>>(
          stream: readPartners(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something Went Wrong ${snapshot.error}');
            } else if (snapshot.hasData) {
              final partner = snapshot.data!;
              return HomePageScreen(partnerName: partner.first.name);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Stream<List<Partners>> readPartners() {
    print(user.email);
    return FirebaseFirestore.instance
        .collection('Place Directory')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((QueryDocumentSnapshot<Object?> element) =>
                element['loginEmail'].contains(user.email))
            .map((doc) => Partners.fromJson(doc.data()))
            .toList());
  }
}
