// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tt9_betweener_challenge/models/searchUser.dart';
import 'package:tt9_betweener_challenge/views/friend_profile.dart';

import '../constants.dart';

// ignore: must_be_immutable
class FollowScreen extends StatefulWidget {
  String title;
  List<SearchUser> users;
  FollowScreen({
    Key? key,
    required this.title,
    required this.users,
  }) : super(key: key);

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: kPrimaryColor, fontSize: 18),
        ),
      ),
      body: ListView.separated(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FriendProfile(user: widget.users[index])));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kLightPrimaryColor),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                        radius: 48,
                        backgroundImage: NetworkImage(
                            'https://godesign.com.ar/desarrollo/web/pagina8/images/girl.jpg')),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.users[index].name!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.users[index].email!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
    );
  }
}
