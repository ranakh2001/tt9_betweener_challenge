import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/home_view.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';
import 'package:tt9_betweener_challenge/views/receive_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_floating_nav_bar.dart';

class MainAppView extends StatefulWidget {
  static String id = '/mainAppView';

  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 1;
  late bool isConnected = true;

  late List<Widget?> screensList = [
    const ReceiveView(),
    const HomeView(),
    const ProfileView()
  ];

  checkInternetConnection() async {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
    } else {
      isConnected = false;
    }
  }

  @override
  void initState() {
    checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnection();
    if (isConnected) {
      return Scaffold(
        body: screensList[_currentIndex],
        extendBody: true,
        bottomNavigationBar: CustomFloatingNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Icon(
            Icons.signal_wifi_connected_no_internet_4,
            size: 56,
          ),
        ),
      );
    }
  }
}
