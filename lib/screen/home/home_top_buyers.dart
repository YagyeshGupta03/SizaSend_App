import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class HomeTopBuyersScreen extends StatefulWidget {
  const HomeTopBuyersScreen({super.key});

  @override
  State<HomeTopBuyersScreen> createState() => _HomeTopBuyersScreenState();
}

class _HomeTopBuyersScreenState extends State<HomeTopBuyersScreen> {
  List<String> name = ["Alejandro", "Sofia", "Roberto", "Adam", "Estela"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(S.of(context).topBuyers),
          trailing:
              TextButton(onPressed: () {}, child: Text(S.of(context).viewAll)),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: name.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.5),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        child: RandomAvatar(name[index], trBackground: true)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(name[index], style: themeController.currentTheme.value.textTheme.bodySmall,),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
