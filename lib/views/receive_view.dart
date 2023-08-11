import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/models/location.dart';

import '../constants.dart';

class ReceiveView extends StatefulWidget {
  static String id = '/receiveView';

  const ReceiveView({super.key});

  @override
  State<ReceiveView> createState() => _ReceiveViewState();
}

class _ReceiveViewState extends State<ReceiveView> {
  Location location = Location();

  void getLocation() async {
    try {
      await location.getCurrentLocation();
    } catch (error) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Error'),
          content: const Text(
              'Please enable location services for the app to work properly.'),
          actions: [
            TextButton(
              onPressed: () async {
                getLocation();
                print(location.lat);
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Text(
              "Active Shareing",
              style: TextStyle(color: kPrimaryColor, fontSize: 24),
            ),
            const Spacer(),
            Image.asset(
              'assets/imgs/location.gif',
              width: 200,
              height: 200,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 32)),
                onPressed: () {},
                child: const Text(
                  "Sender",
                  style: TextStyle(color: kPrimaryColor),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 32)),
                onPressed: () {},
                child: const Text(
                  "Resiver",
                  style: TextStyle(color: kPrimaryColor),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
