// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/follow.dart';
import '../../models/user.dart';

// ignore: must_be_immutable
class UserContainer extends StatelessWidget {
  Future<User> user;
  Future<Follow> follow;
  UserContainer({
    Key? key,
    required this.user,
    required this.follow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          return Stack(alignment: Alignment.topRight, children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 48, // Image radius
                      backgroundImage: NetworkImage(
                          'https://godesign.com.ar/desarrollo/web/pagina8/images/girl.jpg'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data!.user!.name}".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "${snapshot.data!.user!.email}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "+9700000000".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                        FutureBuilder(
                            future: follow,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: kSecondaryColor),
                                      child: Text(
                                        "followers ${snapshot.data!.followersCount}",
                                        style: const TextStyle(
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: kSecondaryColor),
                                      child: Text(
                                        "following ${snapshot.data!.followingCount}",
                                        style: const TextStyle(
                                            color: kPrimaryColor),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: kSecondaryColor),
                                      child: const Text(
                                        "followers ",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: kSecondaryColor),
                                      child: const Text(
                                        "following ",
                                        style: TextStyle(color: kPrimaryColor),
                                      ),
                                    )
                                  ],
                                );
                              }
                            })
                      ],
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            )
          ]);
        });
  }
}
