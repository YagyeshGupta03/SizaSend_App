import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).account),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: s.height * 0.029,
              ),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeController.currentTheme.value.cardColor),
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 10,
                    width: 10,
                    child: Image.asset('assets/images/profilePic.jpg', fit: BoxFit.fill,),
                  ),
                ),
              ),
              SizedBox(
                height: s.height * 0.04,
              ),
              Text(
                S.of(context).personalInfo,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ProfileListTile(
                title: S.of(context).yourName,
                value: "Tommy Jason",
              ),
              ProfileListTile(
                title: S.of(context).occupation,
                value: "Manager",
              ),
              ProfileListTile(
                title: S.of(context).employer,
                value: "Overlay Design",
              ),
              SizedBox(
                height: s.height * 0.035,
              ),
              Text(
                S.of(context).contactInfo,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ProfileListTile(
                title: S.of(context).phoneNumber,
                value: "(1) 3256 8456 888",
              ),
              ProfileListTile(
                title: S.of(context).email,
                value: "tommyjason@mail.com",
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final String title;
  final String? value;

  const ProfileListTile({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(value ?? ""),
    );
  }
}
