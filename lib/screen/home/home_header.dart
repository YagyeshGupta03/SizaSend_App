import 'package:flutter/material.dart';

import '../../util/images.dart';

class HomeHeaderScreen extends StatelessWidget {
  const HomeHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: s.height * .038,
        ),
        const Text(
          "Hello, Mao Lop 👋🏾 ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "These are today's news.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: s.height * .014,
        ),
        Stack(
          children: [
            Image.asset(Images.balCardImage),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "Account Balance",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        ],
                      ),
                      Text(
                        "\$290.00 USD",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.more_horiz , color: Colors.white,),
                      Text("6753" , style: TextStyle(color: Colors.white),)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: s.height*.024,),
      ],
    );
  }
}
