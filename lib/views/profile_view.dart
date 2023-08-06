import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/controller/follow_controller.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';
import 'package:tt9_betweener_challenge/views/add_new_link.dart';
import 'package:tt9_betweener_challenge/views/edit_link_screen.dart';
import '../constants.dart';
import '../controller/link_controller.dart';
import '../controller/user_controller.dart';
import '../models/link.dart';
import '../models/user.dart';
import 'widgets/link_container.dart';
import 'widgets/user_container.dart';

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
      child: Stack(alignment: Alignment.bottomRight, children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Profile",
                style: TextStyle(color: kPrimaryColor, fontSize: 24),
              ),
            ),
            UserContainer(
              user: user,
              follow: follow,
            ),
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
                            shrinkWrap: true,
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
                                      extentRatio: 0.5,
                                      motion: const BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          padding: EdgeInsets.zero,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SlidableAction(
                                          padding: EdgeInsets.zero,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ]),
                                  child: LinkContainer(
                                    link: link!,
                                    index: index,
                                  ));
                            }),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: kPrimaryColor,
            onPressed: () {
              Navigator.pushNamed(context, AddNewLink.id).then((value) {
                setState(() {
                  links = getLinks(context);
                });
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}
