import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/screen/WalletScreens/add_money_screen.dart';
import 'package:savo/screen/WalletScreens/withdraw_money_screen.dart';
import 'package:savo/screen/quotation/add_quotation_screen.dart';
import '../../util/images.dart';

class HomeOperations extends StatelessWidget {
  const HomeOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 4, childAspectRatio: .6,
      children: [
        OperationButton(
          image: Images.icArrowUp,
          title: "Send\nQuotation",
          onTap: (){
            Get.to(()=> const AddQuotationScreen());
          },
        ),
        OperationButton(
          image: Images.icArrowDown,
          title: "Quotation\nreceived",
          onTap: (){},
        ),
        OperationButton(
          image: Images.icAdd,
          title: "Deposit\nMoney",
          onTap: (){
            Get.to(()=> const AddMoneyScreen());
          },
        ),
        OperationButton(
          image: Images.icWithdraw,
          title: "Withdraw\nMoney",
          onTap: (){
            Get.to(()=> const WithdrawMoneyScreen());
          },
        ),
      ],
    );
  }
}

class OperationButton extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  const OperationButton({super.key, required this.image, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (){
            onTap();
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                image,
                color: Colors.black,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
