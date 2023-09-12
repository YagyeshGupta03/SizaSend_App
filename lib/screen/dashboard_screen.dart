import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/animation/exit_animation.dart';
import 'package:savo/screen/history/history_home_screen.dart';
import 'package:savo/screen/home/home_screen.dart';
import 'package:savo/screen/profile/profile_home_screen.dart';
import 'package:savo/screen/quotation/quotation_home_screen.dart';
import 'package:savo/util/images.dart';
import '../Constants/theme_data.dart';
import '../generated/l10n.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedIndex = 0;

  // List screenTitle = [
  //   Text("Home", style: themeController.currentTheme.value.textTheme.bodyLarge),
  //   const Text("Quotation"),
  //   const Text("History"),
  //   const Text("Profile"),
  // ];
  List screen = [
    const HomeScreen(),
    const QuotationHomeScreen(),
    const HistoryHomeScreen(),
    const ProfileHomeScreen(),
  ];

  List drawer = [
    Drawer(
      child: Column(
        children: [
          const SizedBox(height: 70),
          Container(
            height: 150,
            width: double.infinity,
            child: ListTile(
              leading: Container(height: 80, width: 60, color: Colors.red),
              title: Text('Name'),
              subtitle: Text('Number'),
            ),
          )
        ],
      ),
    ),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (selectedIndex != 3)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xffFFB01D),
                            Color(0xff5BCE55),
                          ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: RandomAvatar('saytoonz', trBackground: true)),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 4.5,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 3.5,
                    ),
                  )
                ],
              ),
            )
          else
            ExitAnimationWidget(
              widget: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffFFB01D),
                              Color(0xff5BCE55),
                            ]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child:
                                RandomAvatar('saytoonz', trBackground: true)),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 4.5,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 3.5,
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
        // title: screenTitle[selectedIndex],
      ),
      drawer: drawer.elementAt(selectedIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        child: Image.asset(Images.icScanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: screen.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: S.of(context).home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.file_open),
              label: S.of(context).quotation),
          BottomNavigationBarItem(
              icon: const Icon(Icons.history), label: S.of(context).history),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: S.of(context).profile),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
