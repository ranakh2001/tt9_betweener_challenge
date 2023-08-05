// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../controller/link_controller.dart';

// ignore: must_be_immutable
class EditLinkScreen extends StatefulWidget {
  Link link;
  static String id = '/editLink';
  EditLinkScreen({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  State<EditLinkScreen> createState() => _EditLinkScreenState();
}

class _EditLinkScreenState extends State<EditLinkScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.link.title!;
    linkController.text = widget.link.link!;
    userNameController.text = "${widget.link.username!} ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Link",
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Spacer(),
              CustomTextFormField(
                controller: titleController,
                hint: 'Snapshat',
                keyboardType: TextInputType.text,
                autofillHints: const [AutofillHints.email],
                label: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 14,
              ),
              CustomTextFormField(
                controller: linkController,
                hint: 'http:\\www.Example.com',
                label: 'link',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the link';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 14,
              ),
              CustomTextFormField(
                controller: userNameController,
                hint: '@userName',
                label: 'User name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your user name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              SecondaryButtonWidget(
                  onTap: () {
                    updateLink({
                      'title': titleController.text,
                      'link': linkController.text,
                      'username': userNameController.text
                    }, widget.link.id!)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "link updated",
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                    }).catchError((err) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          err.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    });
                  },
                  text: 'SAVE'),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
