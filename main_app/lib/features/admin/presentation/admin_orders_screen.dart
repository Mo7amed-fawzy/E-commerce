import 'package:e_commerce_app/core/dependency_injection/service_locator.dart';
import 'package:e_commerce_app/core/models/order.dart';
import 'package:e_commerce_app/features/admin/presentation/order_details_screen.dart';
import 'package:e_commerce_app/core/services/admin_service.dart';
import 'package:e_commerce_app/core/func/get_status.dart';
import 'package:e_commerce_app/core/widgets/loader.dart';
import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  List<Order>? orders;
  final adminService = getIt<AdminService>();

  @override
  void initState() {
    super.initState();
    getAllAdminOrders();
  }

  void getAllAdminOrders() async {
    orders = await adminService.getAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Orders",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          ),
          const Divider(thickness: 0.5, color: Colors.grey),
          orders == null
              ? const Loader()
              : Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  // table head
                  TableRow(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    children: [
                      tableHeader("Order"),
                      tableHeader("Amount"),
                      tableHeader("Status"),
                      tableHeader(""),
                    ],
                  ),
                  //table data
                  if (orders != null)
                    for (int i = 0; i < orders!.length; i++)
                      tableRow(
                        context,
                        image: orders![i].products[0].images[0],
                        amount: orders![i].totalPrice.toString(),
                        status: orders![i].status,
                        index: (i + 1).toString(),
                        i: i,
                      ),
                ],
              ),
        ],
      ),
    );
  }

  TableRow tableRow(
    context, {
    index,
    image,
    amount,
    required int status,
    required int i,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.network(image, width: 30),
              ),
              const SizedBox(width: 10),
              Text(index),
            ],
          ),
        ),
        Text(amount),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getStatusColor(status),
              ),
              height: 10,
              width: 10,
            ),
            const SizedBox(width: 10),
            Text(getStatus(status)),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              OrderDetailsScreen.routeName,
              arguments: orders![i],
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: const Center(
              child: Text(
                "view",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
