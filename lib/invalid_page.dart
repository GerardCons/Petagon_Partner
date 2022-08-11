import 'package:flutter/material.dart';
import 'package:petagon_admin/homepage.dart';

class InvalidQrPage extends StatefulWidget {
  const InvalidQrPage({Key? key}) : super(key: key);

  @override
  State<InvalidQrPage> createState() => _InvalidQrPageState();
}

class _InvalidQrPageState extends State<InvalidQrPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Invalid QR Code",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent),
            ),
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomePageScreen()));
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
      ),
    );
  }
}
