import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../controller/link_controller.dart';

class AddNewLink extends StatefulWidget {
  static String id = '/newLink';
  const AddNewLink({super.key});

  @override
  State<AddNewLink> createState() => _AddNewLinkState();
}

class _AddNewLinkState extends State<AddNewLink> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController linkController;
  late TextEditingController userNameController;

  @override
  void initState() {
    titleController = TextEditingController();
    linkController = TextEditingController();
    userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    linkController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  void addlink() async {
    if (_formKey.currentState!.validate()) {
      addNewLink({
        'title': titleController.text,
        'link': linkController.text,
        'username': userNameController.text
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "link add",
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
    }
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
              SecondaryButtonWidget(onTap: addlink, text: 'ADD'),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
