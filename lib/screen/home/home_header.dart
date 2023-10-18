import 'package:flutter/material.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/util/widgets/widget.dart';

import '../../util/images.dart';

class HomeHeaderScreen extends StatelessWidget {
  const HomeHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double balance = double.parse(userInfoController.balance);
    String walletBalance = balance.toStringAsFixed(1);
    var s = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: s.height * .038,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Hello, ${userInfoController.fullName} ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "These are today's updates.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: s.height * .014,
        ),
        Stack(
          children: [
            Image.asset(Images.balCardImage),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: IconButton(
                //       onPressed: () {},
                //       icon: const Icon(
                //         Icons.more_horiz,
                //         color: Colors.white,
                //       ),
                //   ),
                // ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          // Icon(
                          //   Icons.monetization_on_outlined,
                          //   color: Colors.white,
                          // ),
                          Text(
                            "Account Balance",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          convertToCurrency(walletBalance),
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Icon(Icons.more_horiz , color: Colors.white,),
                //       Text("6753" , style: TextStyle(color: Colors.white),)
                //     ],
                //   ),
                // )
              ],
            )
          ],
        ),
        SizedBox(
          height: s.height * .024,
        ),
      ],
    );
  }
}
