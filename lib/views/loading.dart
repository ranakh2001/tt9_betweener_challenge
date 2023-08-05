import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';
import 'package:tt9_betweener_challenge/views/main_app_view.dart';

class LoadingView extends StatefulWidget {
  static const id = "/loadingView";
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  void checklogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user') && mounted) {
      print("navigate to main screen");
      Navigator.pushNamed(context, MainAppView.id);
    } else {
      Navigator.pushNamed(context, LoginView.id);
    }
  }

  @override
  void initState() {
    checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
