import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/quotation_controller.dart';
import 'package:savo/screen/quotation/quotation_details.dart';
import '../../Constants/theme_data.dart';
import '../../Controllers/global_controllers.dart';

class ReceivedQuotationList extends StatefulWidget {
  const ReceivedQuotationList({super.key});

  @override
  State<ReceivedQuotationList> createState() => _ReceivedQuotationListState();
}

class _ReceivedQuotationListState extends State<ReceivedQuotationList> {
  final QuotationController _quotationController =
      Get.put(QuotationController());

  @override
  void initState() {
    super.initState();
    _quotationController.receiveQuotation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => _quotationController.getReceivedQuotationList.length.isEqual(0)
            ? Center(
                child: Text('No quotations available',
                    style:
                        themeController.currentTheme.value.textTheme.bodyLarge),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount:
                        _quotationController.getReceivedQuotationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          _quotationController
                              .getQuotationByOrderId(_quotationController
                                  .getReceivedQuotationList[index].orderId)
                              .whenComplete(() => Get.to(
                                    () => const QuotationDetailScreen(),
                                  ));
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                .getReceivedQuotationList[index]
                                                .productName,
                                            maxLines: 1,
                                            style: themeController.currentTheme
                                                .value.textTheme.bodyLarge),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _quotationController
                                                  .getReceivedQuotationList[
                                                      index]
                                                  .description,
                                              style: themeController
                                                  .currentTheme
                                                  .value
                                                  .textTheme
                                                  .bodySmall,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 7),
                                            const Text(
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
                                  crossAxisSpacing: 10,
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          "Weight/Size",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          _quotationController
                                              .getReceivedQuotationList[index]
                                              .weight,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          "Store Name",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          _quotationController
                                              .getReceivedQuotationList[index]
                                              .store,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            const Text(
                                              "Price",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(width: 7),
                                            _quotationController
                                                            .getReceivedQuotationList[
                                                                index]
                                                            .paid ==
                                                        'paid' ||
                                                    _quotationController
                                                            .getQuotationList[
                                                                index]
                                                            .paid ==
                                                        'dispatch'
                                                ? const Card(
                                                    color: primaryColor,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 1),
                                                      child: Text(
                                                        'Paid',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              _quotationController
                                                  .getReceivedQuotationList[
                                                      index]
                                                  .price,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
