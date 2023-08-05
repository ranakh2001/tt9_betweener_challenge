import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';

import '../models/searchUser.dart';
import '../models/user.dart';

Future<List<SearchUser>> searchByName(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  http.Response response = await http.post(Uri.parse(searchUrl),
      body: body, headers: {'Authorization': "Bearer ${user.token}"});
  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(response.body)["user"];
    List<SearchUser> users = List.generate(
        userList.length, (index) => SearchUser.fromJson(userList[index]));
    return users;
  }
  return Future.error("something wrong");
}
