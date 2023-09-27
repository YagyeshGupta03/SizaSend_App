import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/Controllers/login_controller.dart';
import 'package:savo/animation/exit_animation.dart';
import 'package:savo/screen/NotificationScreen/notification_screen.dart';
import 'package:savo/screen/WalletScreens/wallet_transactions.dart';
import 'package:savo/screen/contact_us_screen.dart';
import 'package:savo/screen/history/history_home_screen.dart';
import 'package:savo/screen/home/home_screen.dart';
import 'package:savo/screen/profile/UserAccountScreens/account_info_screen.dart';
import 'package:savo/screen/profile/profile_home_screen.dart';
import 'package:savo/screen/quotation/quotation_home_screen.dart';
import '../Constants/all_urls.dart';
import '../Constants/theme_data.dart';
import '../Controllers/contact_controllers.dart';
import '../generated/l10n.dart';
import 'authentication/login_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final ContactController _contactController = Get.put(ContactController());

  @override
  void initState() {
    super.initState();
    _contactController.askPermissions();
  }

  int selectedIndex = 0;

  List screen = [
    const HomeScreen(),
    const QuotationHomeScreen(),
    const HistoryHomeScreen(),
    const ProfileHomeScreen(),
  ];

  List drawer = [
    const CustomDrawer(),
    const CustomDrawer(),
    const CustomDrawer(),
    const CustomDrawer(),
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
                ],
              ),
            )
          else
            ExitAnimationWidget(
              widget: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Container(
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
              ),
            ),
        ],
        // title: screenTitle[selectedIndex],
      ),
      drawer: drawer.elementAt(selectedIndex),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   onPressed: () {},
      //   child: Image.asset(Images.icScanner),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        currentIndex: 0,
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 15),
                Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(5),
                  color: themeController.currentTheme.value.cardColor,
                  child: userInfoController.profileImage == ''
                      ? SizedBox(
                          child: Image.asset(
                            'assets/images/profilePic.jpg',
                            fit: BoxFit.fill,
                          ),
                        )
                      : SizedBox(
                          child: Image.network(
                            '$imageUrl${userInfoController.profileImage.toString()}',
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userInfoController.fullName,
                        style: themeController
                            .currentTheme.value.textTheme.bodyLarge),
                    Text(userInfoController.phone,
                        style: themeController
                            .currentTheme.value.textTheme.titleSmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DrawerCard(
              title: 'Home',
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              }),
          DrawerCard(
              title: 'Profile',
              icon: Icons.person,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const AccountInfoScreen());
              }),
          DrawerCard(
              title: 'Wallet transactions',
              icon: Icons.wallet,
              onTap: () {
                Navigator.pop(context);
                Get.to((
                    ) => const WalletTransactions());
              }),
          DrawerCard(
              title: 'Notifications',
              icon: Icons.notifications,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const NotificationScreen());
              }),
          DrawerCard(
              title: 'Contact us',
              icon: Icons.support_agent,
              onTap: () {
                Get.to(() => const AdminEnquiryScreen());
              }),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Dialogs.materialDialog(
                      msg: 'Do you want to logout?',
                      title: 'Logout',
                      context: context,
                      actions: [
                        IconsButton(
                          onPressed: () async {
                            loadingController
                                .updateVideoCompressionLoading(false);
                            loadingController.updateProfileLoading(false);
                            loadingController.updateLoading(false);
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                          color: themeController.currentTheme.value.cardColor,
                          textStyle: const TextStyle(color: primaryColor),
                          iconColor: primaryColor,
                        ),
                        IconsButton(
                          onPressed: () async {
                            loadingController
                                .updateVideoCompressionLoading(false);
                            loadingController.updateProfileLoading(false);
                            loadingController.updateLoading(false);
                            await _loginController.logout();
                            await credentialController.deleteData();
                            Get.off(() => const LoginScreen());
                          },
                          text: 'Logout',
                          color: primaryColor,
                          textStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                        ),
                      ]);
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 100,
                    height: 20,
                    child: Row(
                      children: [
                        Icon(Icons.power_settings_new_outlined,
                            color: Colors.white),
                        SizedBox(width: 5),
                        Text('Log Out',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DrawerCard extends StatelessWidget {
  const DrawerCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        child: ListTile(
          leading: Icon(icon, color: primaryColor),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
