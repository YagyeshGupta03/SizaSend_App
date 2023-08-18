import 'package:flutter/material.dart';

import '../../util/images.dart';

class HomeOperations extends StatelessWidget {
  const HomeOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount: 4, childAspectRatio: .6,
      children: const [
        OperationButton(
          image: Images.icArrowUp,
          title: "Send\nQuotation",
        ),
        OperationButton(
          image: Images.icArrowDown,
          title: "Quotation\nreceived",
        ),
        OperationButton(
          image: Images.icAdd,
          title: "Deposit\nMoney",
        ),
        OperationButton(
          image: Images.icWithdraw,
          title: "Withdraw\nMoney",
        ),
      ],
    );
  }
}

class OperationButton extends StatelessWidget {
  final String image;
  final String title;

  const OperationButton({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Card(
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
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
