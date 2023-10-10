import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/quotation_controller.dart';
import '../util/widgets/widget.dart';


class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final QuotationController _quotationController =
  Get.put(QuotationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text('Quotation Invoice',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              const SizedBox(height: 30),
              InvoiceTile(
                  name: 'Order id', value: _quotationController.orderIdI),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Order name', value: _quotationController.product),
              const SizedBox(height: 20),
              InvoiceTile(name: 'Sender', value: _quotationController.sender),
              const SizedBox(height: 20),
              _quotationController.business == ''
                  ? const InvoiceTile(name: 'Business Name', value: '')
                  : InvoiceTile(
                  name: 'Business Name',
                  value: _quotationController.business),
              const SizedBox(height: 20),
              _quotationController.vat == ''
                  ? const InvoiceTile(name: 'Vat number', value: '')
                  : InvoiceTile(
                  name: 'Vat number', value: _quotationController.vat),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Quantity', value: _quotationController.quantityI),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Size',
                  value:
                  '${_quotationController.heightI}cm x ${_quotationController
                      .widthI}cm x ${_quotationController.lengthI}cm'),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Weight', value: '${_quotationController.weightI} Kg'),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Cost of item',
                  value: convertToCurrency(_quotationController.costOFItem)),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Courier charges',
                  value: convertToCurrency(_quotationController.courierPrice)),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'SizaSend charges',
                  value: convertToCurrency(_quotationController.charge)),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Total payment',
                  value: convertToCurrency(_quotationController.totalPrice)),
              const SizedBox(height: 20),
              InvoiceTile(
                  name: 'Status', value: _quotationController.orderStatusI),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                   _quotationController.generatePDF(
                      context, _quotationController.orderIdI, false);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    'Save as pdf',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class InvoiceTile extends StatelessWidget {
  const InvoiceTile({
    super.key,
    required this.name,
    required this.value,
  });

  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        Text(value, style: const TextStyle(fontSize: 12, color: Colors.black))
      ],
    );
  }
}


