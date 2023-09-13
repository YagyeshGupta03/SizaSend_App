import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import '../../Controllers/quotation_controller.dart';
import '../quotation/quotation_details.dart';

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
    return Obx(
      () => _quotationController.getQuotationHistory.length.isEqual(0)
          ? Center(
              child: Text('No quotations available',
                  style:
                      themeController.currentTheme.value.textTheme.bodyLarge),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: _quotationController.getQuotationHistory.length < 5
                  ? _quotationController.getQuotationHistory.length
                  : 5,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => QuotationDetailScreen(
                          orderId: _quotationController
                              .getQuotationHistory[index].orderId,
                          status: _quotationController
                              .getQuotationHistory[index].status,
                          productName: _quotationController
                              .getQuotationHistory[index].productName,
                          description: _quotationController
                              .getQuotationHistory[index].description,
                          store: _quotationController
                              .getQuotationHistory[index].store,
                          weight: _quotationController
                              .getQuotationHistory[index].weight,
                          height: _quotationController
                              .getQuotationHistory[index].height,
                          width: _quotationController
                              .getQuotationHistory[index].width,
                          price: _quotationController
                              .getQuotationHistory[index].price,
                          quantity: _quotationController
                              .getQuotationHistory[index].quantity,
                          video: _quotationController
                              .getQuotationHistory[index].video,
                          senderId: _quotationController
                              .getQuotationHistory[index].senderId),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: .5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                margin: const EdgeInsets.only(top: 10),
                                color: Colors.white30,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.play_circle,
                                      size: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                      _quotationController
                                          .getQuotationHistory[index]
                                          .productName,
                                      maxLines: 1,
                                      style: themeController.currentTheme.value
                                          .textTheme.bodyLarge),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _quotationController
                                            .getQuotationHistory[index]
                                            .description,
                                        style: themeController.currentTheme
                                            .value.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 7),
                                      _quotationController
                                                  .getQuotationHistory[index]
                                                  .senderId ==
                                              credentialController.id
                                          ? const Text(
                                              'Sent',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red),
                                            )
                                          : const Text(
                                              'Received',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green),
                                            ),
                                    ],
                                  ),
                                  // trailing: _quotationController
                                  //     .getQuotationList[index]
                                  //     .senderId ==
                                  //     credentialController.id
                                  //     ?  IconButton(
                                  //   onPressed: () {
                                  //     _quotationController.deleteQuotation(
                                  //         context,
                                  //         _quotationController
                                  //             .getQuotationList[index]
                                  //             .orderId);
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.delete,
                                  //     color: Colors.red,
                                  //   ),
                                  // )
                                  // : const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                          GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            childAspectRatio: 2,
                            crossAxisSpacing: 15,
                            physics: const ClampingScrollPhysics(),
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Weight/Size",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    _quotationController
                                        .getQuotationHistory[index].weight,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Store Name",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    _quotationController
                                        .getQuotationHistory[index].store,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    _quotationController
                                        .getQuotationHistory[index].price,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
