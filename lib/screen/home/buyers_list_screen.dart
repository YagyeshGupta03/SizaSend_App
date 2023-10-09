import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/screen/quotation/add_quotation_screen.dart';
import '../../Constants/all_urls.dart';
import '../../Controllers/common_controllers.dart';
import '../../Controllers/global_controllers.dart';

class BuyersListScreen extends StatefulWidget {
  const BuyersListScreen({super.key});

  @override
  State<BuyersListScreen> createState() => _BuyersListScreenState();
}

class _BuyersListScreenState extends State<BuyersListScreen> {
  final BuyerInfoController _buyerInfoController =
      Get.put(BuyerInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: _buyerInfoController.buyerList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Get.to(() => AddQuotationScreen(
                      buyerId: _buyerInfoController.buyerList[index].receiverId));
                },
                child: Card(
                  color: Colors.white,
                  elevation: .5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        child: ClipOval(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: _buyerInfoController
                                        .buyerList[index].image ==
                                    ''
                                ? Image.asset('assets/images/profilePic.jpg',
                                    fit: BoxFit.cover)
                                : Image.network(
                                    '$imageUrl${_buyerInfoController.buyerList[index].image}',
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      title: Text(
                        _buyerInfoController.buyerList[index].fullName,
                        style: themeController
                            .currentTheme.value.textTheme.titleSmall,
                        maxLines: 2,
                      ),
                      subtitle: Text(
                        _buyerInfoController.buyerList[index].phone,
                        style: themeController
                            .currentTheme.value.textTheme.bodySmall,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
