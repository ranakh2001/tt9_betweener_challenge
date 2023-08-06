// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controller/search_controller.dart';

import 'package:tt9_betweener_challenge/models/searchUser.dart';
import 'package:tt9_betweener_challenge/views/friend_profile.dart';

class CustomSearchDelegate extends SearchDelegate {
  late Future<List<SearchUser>> users;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: searchByName({'name': query}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FriendProfile(user: snapshot.data![index])));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].name}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${snapshot.data![index].email}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 8,
                        child: Divider(),
                      ),
                    ),
                itemCount: snapshot.data!.length);
          } else {
            return const Center(child: Text("No Result"));
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: searchByName({'name': query}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(),
            );
          }
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FriendProfile(user: snapshot.data![index])));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].name}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${snapshot.data![index].email}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 8,
                        child: Divider(),
                      ),
                    ),
                itemCount: snapshot.data!.length);
          } else {
            return const Center(child: Text("Search for a user"));
          }
        });
  }
}
