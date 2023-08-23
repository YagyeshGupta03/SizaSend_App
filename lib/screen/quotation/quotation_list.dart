import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/quotation/quotation_details.dart';
import '../../Controllers/quotation_controller.dart';

class QuotationList extends StatefulWidget {
  const QuotationList({super.key});

  @override
  State<QuotationList> createState() => _QuotationListState();
}

class _QuotationListState extends State<QuotationList> {
  final QuotationController _quotationController =
      Get.put(QuotationController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _quotationController.quotationList.length.isEqual(0)
          ? Center(
              child: Text('No quotations available',
                  style:
                      themeController.currentTheme.value.textTheme.bodyLarge),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: _quotationController.getQuotationList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => QuotationDetailScreen(
                        productId: _quotationController
                            .getQuotationList[index].productID,
                          productName: _quotationController
                              .getQuotationList[index].productName,
                          description: _quotationController
                              .getQuotationList[index].description,
                          store:
                              _quotationController.getQuotationList[index].store,
                          weight:
                              _quotationController.getQuotationList[index].weight,
                          height:
                              _quotationController.getQuotationList[index].height,
                          width:
                              _quotationController.getQuotationList[index].width,
                          price:
                              _quotationController.getQuotationList[index].price,
                          quantity: _quotationController
                              .getQuotationList[index].quantity,
                          video:
                              _quotationController.getQuotationList[index].video),
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
                                child: const Column( mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.play_circle, size: 50,),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                      _quotationController
                                          .getQuotationList[index].productName,
                                      maxLines: 1,
                                      style: themeController.currentTheme.value
                                          .textTheme.bodyLarge),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _quotationController
                                            .getQuotationList[index].description,
                                        style: themeController.currentTheme
                                            .value.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 7),
                                      _quotationController
                                          .getQuotationList[index].senderId == credentialController.id
                                          ? const Text('Sent', style: TextStyle(fontSize: 12, color: Colors.red),)
                                      : const Text('Received', style: TextStyle(fontSize: 12, color: Colors.green),),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _quotationController.deleteQuotation(
                                          context,
                                          _quotationController
                                              .getQuotationList[index].productID);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
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
                                        .getQuotationList[index].weight,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),maxLines: 1,
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
                                        .getQuotationList[index].store,
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
                                        .getQuotationList[index].price,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold), maxLines: 1,
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
