// ignore_for_file: file_names, sized_box_for_whitespace, no_logic_in_create_state, avoid_print, unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petagon_admin/homepage.dart';
import 'package:petagon_admin/model/infosheet.dart';

// ignore: camel_case_types
class InfoSheetPage extends StatefulWidget {
  final String petID;
  const InfoSheetPage({Key? key, required this.petID}) : super(key: key);
  @override
  State<InfoSheetPage> createState() => _InfoSheetPageState(petID);
}

class _InfoSheetPageState extends State<InfoSheetPage> {
  final String petID;

  _InfoSheetPageState(this.petID);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePageScreen()));
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
          centerTitle: true,
          title: const Text(
            'Information Sheet',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        body: StreamBuilder<List<InfoSheet>>(
            stream: readInformationSheet(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Text('Something Went Wrong');
              } else if (snapshot.hasData) {
                final info = snapshot.data!;

                return buildUpperUi(heightScreen, widthScreen, info.first);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  SingleChildScrollView buildUpperUi(
      double heightScreen, double widthScreen, InfoSheet info) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: widthScreen * 0.57,
              height: heightScreen * 0.88,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: 160,
                        width: 160,
                        child: Image.network(info.petImageUrl),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'CONTACT PERSON',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(info.ownerImageUrl),
                          ),
                        ),
                        Text(
                          '${info.firstname} \n ${info.lastname}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: FaIcon(
                            FontAwesomeIcons.phone,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          info.mobile,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: FaIcon(
                            FontAwesomeIcons.envelope,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          info.email,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: FaIcon(
                            FontAwesomeIcons.house,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          info.address,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'PET DETAILS',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Birthday:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          info.petDOB,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Kind:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          info.petKind,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Gender:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          info.petGender,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Allergies:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'None',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'OTHER FURPARENTS',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
          Container(
              width: widthScreen * 0.43,
              height: heightScreen * 0.88,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: Center(
                      child: Text(
                        info.petName,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      (info.age == 0)
                          ? const Text(
                              '< 1',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              info.age.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                      const Text(
                        " / ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        info.petBreed,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
                  Row(
                    children: [
                      (info.isVaccinated == false)
                          ? const FaIcon(
                              FontAwesomeIcons.clockRotateLeft,
                              color: Color.fromARGB(255, 253, 228, 2),
                              size: 20,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.green,
                              size: 20,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Fully Vaccinated',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      (info.pendingReports == 0)
                          ? const FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.green,
                              size: 20,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.clockRotateLeft,
                              color: Color.fromARGB(255, 253, 228, 2),
                              size: 20,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      (info.pendingReports == 0)
                          ? const Text(
                              'No Pending Reports',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              '${info.pendingReports} Pending Report(s)',
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      (info.isVerified == true)
                          ? const FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.green,
                              size: 20,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.clockRotateLeft,
                              color: Color.fromARGB(255, 253, 228, 2),
                              size: 20,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Petagon Verified',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      (info.isPCCIRegistered == true)
                          ? const FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.green,
                              size: 20,
                            )
                          : const FaIcon(
                              FontAwesomeIcons.clockRotateLeft,
                              color: Color.fromARGB(255, 253, 228, 2),
                              size: 20,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'PCCI Registered',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'VACCINE RECORD',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  (info.petKind == 'Dog')
                      ? Column(
                          children: [
                            Center(
                                child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Checkbox(
                                value: info.vacRecord_distemper,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Distemper',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Center(
                                child: ListTile(
                              dense: true,
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              contentPadding: const EdgeInsets.all(0),
                              leading: Checkbox(
                                value: info.vacRecord_hepatitis,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Canine Hepatitis',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Center(
                                child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Checkbox(
                                value: info.vacRecord_parvovirus,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Canine Parvovirus',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Center(
                                child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Checkbox(
                                value: info.vacRecord_rabies,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Rabies',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Center(
                                child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Checkbox(
                                value: info.vacRecord_kennelCough,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Kennel Cough',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ],
                        )
                      : Column(
                          children: [
                            Center(
                                child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Checkbox(
                                value: info.vacRecord_felinedistemper,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Feline Distemper',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Center(
                                child: ListTile(
                              dense: true,
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              contentPadding: const EdgeInsets.all(0),
                              leading: Checkbox(
                                value: info.vacRecord_rhinotracheitis,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Rhinotracheitis',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Center(
                                child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Checkbox(
                                value: info.vacRecord_calicvirus,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Calicvirus',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                            Center(
                                child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Checkbox(
                                value: info.vacRecord_rabies,
                                onChanged: (value) {},
                              ),
                              title: const Text(
                                'Rabies',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ],
                        )
                ],
              )),
        ],
      ),
    );
  }

  Stream<List<InfoSheet>> readInformationSheet() {
    return FirebaseFirestore.instance
        .collection('Information Sheet')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((QueryDocumentSnapshot<Object?> element) =>
                element['petID'].toString().contains(petID))
            .map((doc) => InfoSheet.fromJson(doc.data()))
            .toList());
  }
}