import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/sizes.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/profile/BankAccount_screens/add_bankAc_screen.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../generated/l10n.dart';

class BankListingScreen extends StatefulWidget {
  const BankListingScreen({Key? key}) : super(key: key);

  @override
  State<BankListingScreen> createState() => _BankListingScreenState();
}

class _BankListingScreenState extends State<BankListingScreen> {
  final BankController _bankController = Get.put(BankController());
  @override
  void initState() {
    super.initState();
    _bankController.showBankAc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).bankAccount,
          style: themeController.currentTheme.value.textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).yourBankAccount,
                style: themeController.currentTheme.value.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Obx(
                () => _bankController.bankList.length.isEqual(0)
                    ? Center(
                        child: Text(
                        S.of(context).noAccountCurrently,
                        style: themeController
                            .currentTheme.value.textTheme.displayMedium,
                      ))
                    : ListView.builder(
                        itemCount: _bankController.bankList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(_bankController.bankList[index].bankId),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              _bankController.deleteBankAc(context,
                                  _bankController.bankList[index].bankId);
                            },
                            background: Container(
                              width: screenWidth(context),
                              color: primaryColor.withOpacity(0.12),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            child: BankCard(bankController: _bankController, index: index,),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Get.to(()=> const AddBankScreen());
                },
                child: Card(
                  elevation: 0,
                  color: themeController.currentTheme.value.cardColor,
                  child: Container(
                    color: themeController.currentTheme.value.cardColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: Text(
                        S.of(context).addNewBankAccount,
                        style: themeController
                            .currentTheme.value.textTheme.displaySmall,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color:
                            themeController.currentTheme.value.iconTheme.color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
//
//
//
class BankCard extends StatelessWidget {
  const BankCard({
    super.key,
    required BankController bankController, required this.index,
  }) : _bankController = bankController;

  final BankController _bankController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 1, // Adjust the elevation as needed
        child: Container(
          color: themeController
              .currentTheme.value.cardColor,
          padding:
              const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(
              _bankController.bankList[index].bankName,
              style: themeController.currentTheme.value
                  .textTheme.bodyLarge,
            ),
            subtitle: Text(
              _bankController.bankList[index].account,
              style: themeController.currentTheme.value
                  .textTheme.displayMedium,
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/icons/ic_bank.jpg',
                  fit: BoxFit.fill,
                  height: 35,
                  width: 35,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
