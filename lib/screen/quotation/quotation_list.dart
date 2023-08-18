import 'package:flutter/material.dart';

class QuotationList extends StatefulWidget {
  const QuotationList({super.key});

  @override
  State<QuotationList> createState() => _QuotationListState();
}

class _QuotationListState extends State<QuotationList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: .5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      child: const FlutterLogo(),
                    ),
                    Expanded(
                        child: ListTile(
                      title: const Text(
                        "Roman Adrew",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Lorem ipsum dolor sit amet.......",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              size: 12,
                            ),
                            label: const Text(
                              "edit",
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    )),
                  ],
                ),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Container(
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Weight/Size",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "1.5 Kilogram",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Store Name",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Steet Venue, 112",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "440.26 RAND",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
