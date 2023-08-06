// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/link.dart';

// ignore: must_be_immutable
class LinkContainer extends StatelessWidget {
  Link link;
  int index;

   LinkContainer({
    Key? key,
    required this.link,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: index % 2 == 0 ? kLightPrimaryColor : kLightDangerColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
