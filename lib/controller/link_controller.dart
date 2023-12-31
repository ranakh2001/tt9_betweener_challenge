import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';

import '../models/link.dart';
import 'package:http/http.dart' as http;

Future<List<Link>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  http.Response respons = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': "Bearer ${user.token}"});

  if (respons.statusCode == 200) {
    final data = jsonDecode(respons.body)['links'] as List<dynamic>;
    return data.map((e) => Link.fromJson(e)).toList();
  }
  if (respons.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error("Something wrong");
}

Future<void> addNewLink(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(linksUrl),
      body: body, headers: {'Authorization': "Bearer ${user.token}"});
  if (response.statusCode == 200) {
  } else {
    return Future.error("Something wrong");
  }
}

Future<void> updateLink(Map<String, String> body, int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  http.Response response = await http.put(Uri.parse("$linksUrl/$id"),
      body: body, headers: {'Authorization': "Bearer ${user.token}"});
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    return Future.error("Something wrong");
  }
}

Future<void> deleteLink( int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  http.Response response = await http.delete(Uri.parse("$linksUrl/$id"),
      headers: {'Authorization': "Bearer ${user.token}"});
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    return Future.error("Something wrong");
  }
}
