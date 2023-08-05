import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';

import '../constants.dart';
import '../models/user.dart';

Future<Follow> getFollow() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  http.Response respons = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': "Bearer ${user.token}"});
  if (respons.statusCode == 200) {
    return followFromJson(respons.body);
  } else {
    return Future.error("somthing wrong");
  }
}

Future<void> addFriend(Map body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  http.Response respons = await http.post(Uri.parse(followUrl),
      body: body, headers: {'Authorization': "Bearer ${user.token}"});
  if (respons.statusCode == 200) {
  } else {
    return Future.error("somethinf wrong");
  }
}
