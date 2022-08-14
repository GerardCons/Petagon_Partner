// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petagon_admin/components/utils.dart';
import 'package:petagon_admin/infoSheetPage.dart';
import 'package:petagon_admin/model/infosheet.dart';
import 'package:petagon_admin/model/report.dart';
import 'package:uuid/uuid.dart';

class ReportPageScreen extends StatefulWidget {
  final String petID;
  final String infoID;
  final String partnerName;
  const ReportPageScreen(
      {Key? key,
      required this.petID,
      required this.infoID,
      required this.partnerName})
      : super(key: key);

  @override
  State<ReportPageScreen> createState() => _ReportPageScreenState();
}

class _ReportPageScreenState extends State<ReportPageScreen> {
  final description = TextEditingController();
  var uuid = const Uuid();
  String _uid = "";
  String dateUploaded = "";
  int numberOfReports = 0;

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    getNumberReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => InfoSheetPage(
                            petID: widget.petID,
                            infoID: widget.infoID,
                            partnerName: widget.partnerName,
                          )));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          )
        ],
        centerTitle: true,
        title: const Text(
          'Report',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<List<Report>>(
                stream: readReport(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something Went Wrong');
                  } else if (snapshot.hasData) {
                    final pets = snapshot.data!;
                    if (pets.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: heightScreen * 0.34,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Report a Situation',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    width: widthScreen * 0.90,
                                    child: TextFormField(
                                      minLines: 4,
                                      maxLines: 5,
                                      controller: description,
                                      decoration: InputDecoration(
                                        hintText: "Enter your report here",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.purpleAccent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.purpleAccent)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                buildSaveButton(),
                              ],
                            ),
                          ),
                          if (!isKeyboard)
                            SizedBox(
                                height: heightScreen * 0.52,
                                child: ListView(
                                    children: pets.map(buildPets).toList()))
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: heightScreen * 0.34,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Report a Situation',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBox(
                                width: widthScreen * 0.90,
                                child: TextFormField(
                                  minLines: 4,
                                  maxLines: 5,
                                  controller: description,
                                  decoration: InputDecoration(
                                    hintText: "Enter your report here",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Colors.purpleAccent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Colors.purpleAccent)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            buildSaveButton(),
                          ],
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Row buildSaveButton() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent,
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                _uid = uuid.v4();
                final uploadTime = DateTime.now();
                Timestamp myTimeStamp = Timestamp.fromDate(uploadTime);
                dateUploaded = DateFormat('dd-MM-yyyy').format(uploadTime);

                if (description.text.isEmpty) {
                  Utils.errorSnackBar(
                      Icons.error, "Please complete all the requirements");
                } else {
                  final docReport = FirebaseFirestore.instance
                      .collection('Petagon Reports')
                      .doc(_uid);

                  final docInfo = FirebaseFirestore.instance
                      .collection('Information Sheet')
                      .doc(widget.infoID);
                  numberOfReports = numberOfReports + 1;
                  final pendingReport = {'pendingReports': numberOfReports};
                  docInfo.update(pendingReport);

                  final data = {
                    'reportID': _uid,
                    'infoID': widget.infoID,
                    'petID': widget.petID,
                    'partnerName': widget.partnerName,
                    'description': description.text,
                    'dateReported': dateUploaded,
                    'date': myTimeStamp,
                  };
                  docReport.set(data);
                  description.clear();
                }
              },
              child: const Text(
                'SAVE',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPets(Report report) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.black,
          child: ListTile(
            title: Text(
              report.partnerName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  report.dateReported,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  report.description,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void getNumberReports() async {
    final noReports = FirebaseFirestore.instance
        .collection('Information Sheet')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((QueryDocumentSnapshot<Object?> element) =>
                element['petID'].toString().contains(widget.petID))
            .map((doc) => InfoSheet.fromJson(doc.data()))
            .toList());

    noReports.map((info) => numberOfReports = info.first.pendingReports);
    print(numberOfReports);
  }

  Stream<List<Report>> readReport() {
    return FirebaseFirestore.instance
        .collection('Petagon Reports')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((QueryDocumentSnapshot<Object?> element) =>
                element['petID'].toString().contains(widget.petID))
            .map((doc) => Report.fromJson(doc.data()))
            .toList());
  }
}
