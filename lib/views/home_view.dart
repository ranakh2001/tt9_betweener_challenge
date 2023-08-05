import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/search_screen.dart';
import 'package:tt9_betweener_challenge/views/widgets/square_border_custom_paint.dart';

import '../constants.dart';
import '../controller/link_controller.dart';
import '../controller/user_controller.dart';
import '../models/link.dart';
import 'add_new_link.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: CustomSearchDelegate());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.qr_code_scanner)),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "Welcome ${snapshot.data?.user?.name}",
                      style: const TextStyle(fontSize: 24),
                    );
                  } else {
                    return const Text("Loading");
                  }
                }),
          ),
          const Spacer(),
          CustomPaint(
              painter: MyCustomPainter(frameSFactor: .1, padding: 20),
              child: Center(child: Image.asset("assets/imgs/qr_code.png"))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(12),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (index == snapshot.data!.length) {
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.pushNamed(context, AddNewLink.id)
                                        .then((value) {
                                      setState(() {
                                        links = getLinks(context);
                                      });
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: kLightPrimaryColor,
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: kPrimaryColor,
                                        ),
                                        Text(
                                          "Add More",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                final link = snapshot.data?[index];
                                return Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: kLightSecondaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        link!.title!.toUpperCase(),
                                        style: const TextStyle(
                                            color: kOnSecondaryColor),
                                      ),
                                      Text(
                                        '@ ${link.username}',
                                        style: const TextStyle(
                                            color: kOnSecondaryColor),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 8,
                              );
                            },
                            itemCount: snapshot.data!.length + 1,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
