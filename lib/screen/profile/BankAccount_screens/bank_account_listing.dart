import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:savo/Constants/theme_data.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/WalletScreens/bank_details_screen.dart';
import 'package:savo/screen/dashboard_screen.dart';
import '../../../Controllers/profile_controller.dart';
import '../../../generated/l10n.dart';
import 'add_bank_account_screen.dart';

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
        leading: IconButton(
          onPressed: () {
            Get.to(() => const DashBoardScreen());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          S.of(context).bankAccount,
          style: themeController.currentTheme.value.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).yourBankAccount,
                  style: themeController.currentTheme.value.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 50),
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
                          return BankCard(
                            bankController: _bankController,
                            index: index,
                            withdrawal: false,
                          );
                        },
                      ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Get.to(() => const AddBankScreen());
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
    required BankController bankController,
    required this.index,
    required this.withdrawal,
  }) : _bankController = bankController;

  final BankController _bankController;
  final int index;
  final bool withdrawal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 1, // Adjust the elevation as needed
        child: Container(
          color: themeController.currentTheme.value.cardColor,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(
              _bankController.bankList[index].bankName,
              style: themeController.currentTheme.value.textTheme.bodyLarge,
            ),
            subtitle: Text(
              _bankController.bankList[index].account,
              style: themeController.currentTheme.value.textTheme.displayMedium,
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
            trailing: withdrawal
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      Dialogs.materialDialog(
                          msg: 'Do you want to delete this bank account?',
                          title: "Delete",
                          titleAlign: TextAlign.center,
                          color: Colors.white,
                          context: context,
                          actions: [
                            IconsOutlineButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: 'Cancel',
                              iconData: Icons.cancel_outlined,
                              textStyle: const TextStyle(color: Colors.grey),
                              iconColor: Colors.grey,
                            ),
                            IconsButton(
                              onPressed: () {
                                _bankController.deleteBankAc(context,
                                    _bankController.bankList[index].bankId);
                              },
                              text: 'Delete',
                              iconData: Icons.delete,
                              color: primaryColor,
                              textStyle: const TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                          ]);
                    },
                    icon: const Icon(Icons.delete_forever_outlined,
                        color: Colors.red),
                  ),
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
class BankListWithdraw extends StatefulWidget {
  const BankListWithdraw(
      {super.key, required this.withdrawal, required this.amount});

  final bool withdrawal;
  final String amount;

  @override
  State<BankListWithdraw> createState() => _BankListWithdrawState();
}

class _BankListWithdrawState extends State<BankListWithdraw> {
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
        leading: IconButton(
          onPressed: () {
            Get.to(() => const DashBoardScreen());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          S.of(context).bankAccount,
          style: themeController.currentTheme.value.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).yourBankAccount,
                  style: themeController.currentTheme.value.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 50),
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
                          return InkWell(
                            onTap: () {
                              if (widget.withdrawal) {
                                Get.to(() => BankDetailsScreen(
                                    bankId:
                                        _bankController.bankList[index].bankId,
                                    acName: _bankController
                                        .bankList[index].fullName,
                                    bankName: _bankController
                                        .bankList[index].bankName,
                                    acNumber:
                                        _bankController.bankList[index].account,
                                    ifsc: _bankController.bankList[index].ifsc,
                                    amount: widget.amount));
                              }
                            },
                            child: BankCard(
                              bankController: _bankController,
                              index: index,
                              withdrawal: widget.withdrawal,
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
