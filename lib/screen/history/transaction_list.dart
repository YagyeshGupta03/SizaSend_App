import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import '../../Controllers/quotation_controller.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final QuotationController _quotationController =
      Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _quotationController.getQuotationList.length,
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
                      title: Text(
                        _quotationController
                            .getQuotationList[index].productName,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _quotationController
                            .getQuotationList[index].description,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: _quotationController
                                  .getQuotationList[index].senderId ==
                              credentialController.id
                          ? const Text("Sent")
                          : const Text("Received"),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Weight/Size",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            _quotationController
                                .getQuotationList[index].weight,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Store Name",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          _quotationController
                              .getQuotationList[index].store,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          _quotationController
                              .getQuotationList[index].price,
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
