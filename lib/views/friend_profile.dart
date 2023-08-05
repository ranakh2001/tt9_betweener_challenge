// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controller/follow_controller.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';

import '../constants.dart';
import '../models/searchUser.dart';

// ignore: must_be_immutable
class FriendProfile extends StatefulWidget {
  SearchUser user;
  static String id = "/friendProfile";
  FriendProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  late Future<Follow> follow;
  @override
  void initState() {
    follow = getFollow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "${widget.user.name}",
            style: const TextStyle(color: kPrimaryColor),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
          )),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage(
                      'https://godesign.com.ar/desarrollo/web/pagina8/images/girl.jpg'),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.user.name}".toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "${widget.user.email}",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "+9700000000".toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor),
                      onPressed: () {
                        addFriend({'followee_id': "${widget.user.id}"})
                            .then((value) {
                          setState(() {
                            follow = getFollow();
                          });
                        });
                      },
                      child: FutureBuilder(
                        future: follow,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List following = snapshot.data!.following!;
                            for (int i = 0; i < following.length; i++) {
                              if (widget.user.id == following[i]['id']) {
                                return const Text(
                                  "Following",
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 14),
                                );
                              }
                            }
                            return const Text(
                              "Follow",
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 14),
                            );
                          } else {
                            return const Text(
                              "Follow",
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 14),
                            );
                          }
                        },
                      ))
                ],
              )
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: widget.user.links!.length,
                  itemBuilder: (context, index) {
                    if (widget.user.links!.isEmpty) {
                      return const Center(
                        child: Text("No Links Belong to this user"),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: index % 2 == 0
                                ? kLightPrimaryColor
                                : kLightDangerColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.user.links![index]['title']}"
                                      .toUpperCase(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${widget.user.links![index]['link']}",
                                  style: const TextStyle(fontSize: 16),
                                )
                              ]),
                        ),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
