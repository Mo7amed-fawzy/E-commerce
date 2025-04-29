// import 'package:e_commerce_app/app/services/product_services.dart';
// import 'package:e_commerce_app/app/widgets/custom_button.dart';
// import 'package:e_commerce_app/app/widgets/custom_text.dart';
// import 'package:pay/pay.dart';
// import 'package:e_commerce_app/components/utils.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  static const String routeName = '/address';
  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // final ProductServices productServices = ProductServices();
  final TextEditingController addressTxt = TextEditingController();
  final TextEditingController homeTxt = TextEditingController();
  final TextEditingController areaTxt = TextEditingController();
  final TextEditingController specialTxt = TextEditingController();
  final _addressFormScreen = GlobalKey<FormState>();

  // final List<PaymentItem> _paymentItems = [];
  // late PaymentConfiguration _paymentConfiguration;

  @override
  void initState() {
    super.initState();
    // _paymentItems.add(
    //   PaymentItem(
    //     label: 'Total',
    //     amount: widget.totalAmount,
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );
    // PaymentConfiguration.fromAsset('gpay.json').then((config) {
    //   setState(() {
    //     _paymentConfiguration = config;
    //   });
    // });
  }

  // void _handlePaymentResult(Map<String, dynamic> paymentResult) {
  //   // هنا تقدر تتعامل مع نتيجة الدفع، مثلا:
  //   printHere('Payment Result: $paymentResult');
  //   // وممكن تبعت اوردر لو عايز بعد الدفع
  // }

  void payPressed(String theAddress, String paymentMethod) {
    bool formOk =
        addressTxt.text.isNotEmpty ||
        homeTxt.text.isNotEmpty ||
        areaTxt.text.isNotEmpty ||
        specialTxt.text.isNotEmpty;
    // if (formOk) {
    //   if (_addressFormScreen.currentState!.validate()) {
    //     theAddress =
    //         " ${addressTxt.text} , ${homeTxt.text} , ${areaTxt.text} ,${specialTxt.text} ,";
    //   } else {
    //     showAlertDialog2(context, 'Stop', 'Fill all address info');
    //   }
    // } else {
    //   if (theAddress.isEmpty) {
    //     showAlertDialog2(context, 'Stop', 'Fill all address info');
    //   }
    // }
    // productServices.saveUserAddress(context: context, address: theAddress);
    // productServices.setAnOrder(
    //   context: context,
    //   address: theAddress,
    //   totalPrice: double.parse(widget.totalAmount),
    //   paymentMethod: paymentMethod,
    // );
  }

  @override
  void dispose() {
    super.dispose();
    addressTxt.dispose();
    homeTxt.dispose();
    areaTxt.dispose();
    specialTxt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address =
        Provider.of<UserProvider>(context, listen: false).user.address;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Declarations.appBarGradient,
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add your Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Or you have new address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormScreen,
                child: Column(
                  children: [
                    CustomText(
                      controller: addressTxt,
                      hinTxt: 'Address,',
                      icon: Icons.home_outlined,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      controller: homeTxt,
                      hinTxt: 'Home, Number',
                      icon: Icons.streetview_outlined,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      controller: areaTxt,
                      hinTxt: 'Area, Street',
                      icon: Icons.add_business_rounded,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      controller: specialTxt,
                      hinTxt: 'Special Mark',
                      icon: Icons.mark_as_unread_outlined,
                    ),
                    const SizedBox(height: 10),
                    // _paymentConfiguration == null
                    //     ? const CircularProgressIndicator() // لسه بيحمل
                    //     : GooglePayButton(
                    //         paymentConfiguration:
                    //             _paymentConfiguration, // ✅ هنا
                    //         paymentItems: _paymentItems,
                    //         onPaymentResult: _handlePaymentResult,
                    //       ),
                    // GooglePayButton(
                    //   paymentConfiguration: _paymentConfiguration, // ✅ هنا
                    //   paymentItems: _paymentItems,
                    //   onPaymentResult: _handlePaymentResult,
                    // ),
                    // const SizedBox(height: 10),
                    // CustomButton(
                    //   onTap: () {
                    //     payPressed(address, "CASH");
                    //   },
                    //   text: 'Cash on delivery',
                    //   icon: Icons.attach_money,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
