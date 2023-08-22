
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Controllers/global_controllers.dart';
import 'package:savo/screen/quotation/edit_quotation_screen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../Controllers/quotation_controller.dart';
import 'full_video_screen.dart';

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
              itemCount: _quotationController.quotationList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => VideoApp(
                          video:
                              _quotationController.quotationList[index].video,
                        ),);
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
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                      _quotationController
                                          .quotationList[index].productName,
                                      maxLines: 1,
                                      style: themeController.currentTheme.value
                                          .textTheme.bodyLarge),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _quotationController
                                            .quotationList[index].description,
                                        style: themeController.currentTheme
                                            .value.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 7),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => EditQuotationScreen(
                                                productID: _quotationController
                                                    .quotationList[index]
                                                    .productID,
                                                productName:
                                                    _quotationController
                                                        .quotationList[index]
                                                        .productName,
                                                index: index,
                                                price: _quotationController
                                                    .quotationList[index].price,
                                                store: _quotationController
                                                    .quotationList[index].store,
                                                quantity: _quotationController
                                                    .quotationList[index]
                                                    .quantity,
                                                weight: _quotationController
                                                    .quotationList[index]
                                                    .weight,
                                                width: _quotationController
                                                    .quotationList[index].width,
                                                height: _quotationController
                                                    .quotationList[index]
                                                    .height,
                                                description:
                                                    _quotationController
                                                        .quotationList[index]
                                                        .description),
                                          );
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: 12,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _quotationController.deleteQuotation(
                                          context,
                                          _quotationController
                                              .quotationList[index].productID);
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
                            physics: const ClampingScrollPhysics(),
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "Weight/Size",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      _quotationController
                                          .quotationList[index].weight,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
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
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    _quotationController
                                        .quotationList[index].store,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    _quotationController
                                        .quotationList[index].price,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
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


