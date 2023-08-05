import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/controller/follow_controller.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';
import 'package:tt9_betweener_challenge/views/edit_link_screen.dart';
import '../constants.dart';
import '../controller/link_controller.dart';
import '../controller/user_controller.dart';
import '../models/link.dart';
import '../models/user.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<User> user;
  late Future<List<Link>> links;
  late Future<Follow> follow;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    follow = getFollow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Profile",
              style: TextStyle(color: kPrimaryColor, fontSize: 24),
            ),
          ),
          FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                return Stack(alignment: Alignment.topRight, children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                              style: TextStyle(
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
                                            child: const Text(
                                              "following ",
                                              style: TextStyle(
                                                  color: kPrimaryColor),
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
              }),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.separated(
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (contex, index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                          itemBuilder: (contex, index) {
                            final link = snapshot.data?[index];
                            return Slidable(
                              endActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditLinkScreen(
                                                            link: link!)))
                                            .then((value) {
                                          setState(() {
                                            links = getLinks(context);
                                          });
                                        });
                                      },
                                      icon: Icons.edit,
                                      backgroundColor: kSecondaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        deleteLink(link!.id!).then((value) {
                                          setState(() {
                                            links = getLinks(context);
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                              "Deleted successfully",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ));
                                        }).catchError((err) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              err.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          ));
                                        });
                                      },
                                      icon: Icons.delete,
                                      backgroundColor: kDangerColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ]),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 20),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: index % 2 == 0
                                        ? kLightPrimaryColor
                                        : kLightDangerColor),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${link!.title}".toUpperCase(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "${link.link}",
                                          style: const TextStyle(fontSize: 16),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
