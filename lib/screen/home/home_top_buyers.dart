import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Controllers/common_controllers.dart';
import 'package:savo/screen/home/buyers_list_screen.dart';
import 'package:savo/screen/quotation/add_quotation_screen.dart';
import '../../Controllers/global_controllers.dart';
import '../../generated/l10n.dart';

class HomeTopBuyersScreen extends StatefulWidget {
  const HomeTopBuyersScreen({super.key});

  @override
  State<HomeTopBuyersScreen> createState() => _HomeTopBuyersScreenState();
}

class _HomeTopBuyersScreenState extends State<HomeTopBuyersScreen> {
  final BuyerInfoController _buyerInfoController =
      Get.put(BuyerInfoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buyerInfoController.buyerList.length.isGreaterThan(0)
        ? Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Buyers',
                      style: themeController
                          .currentTheme.value.textTheme.bodyLarge),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const BuyersListScreen());
                      },
                      child: Text(S.of(context).viewAll)),
                ],
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      _buyerInfoController.buyerList.length.isGreaterThan(5)
                          ? 5
                          : _buyerInfoController.buyerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => AddQuotationScreen(
                              buyerId: _buyerInfoController
                                  .buyerList[index].receiverId));
                        },
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: ClipOval(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: _buyerInfoController
                                              .buyerList[index].image ==
                                          ''
                                      ? Image.asset(
                                          'assets/images/profilePic.jpg',
                                          fit: BoxFit.cover)
                                      : Image.network(
                                          '$imageUrl${_buyerInfoController.buyerList[index].image}',
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              _buyerInfoController.buyerList[index].fullName,
                              style: themeController
                                  .currentTheme.value.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20)
            ],
          )
        : const SizedBox());
  }
}
