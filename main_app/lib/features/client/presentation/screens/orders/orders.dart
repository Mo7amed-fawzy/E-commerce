import 'package:e_commerce_app/core/dependency_injection/service_locator.dart';
import 'package:e_commerce_app/core/models/order.dart';
import 'package:e_commerce_app/features/admin/presentation/order_details_screen.dart';
import 'package:e_commerce_app/core/services/home_service.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final homeService = getIt<HomeService>();

  @override
  void initState() {
    super.initState();
    getAllUserOrders();
  }

  void getAllUserOrders() async {
    orders = await homeService.getMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Orders",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(thickness: 0.5, color: Colors.grey),

          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Table header
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
              // Table data
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
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: const Center(
              child: Text(
                "View",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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

  // Return status color based on order status
  Color getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Return status text based on order status
  String getStatus(int status) {
    switch (status) {
      case 1:
        return "Delivered";
      case 2:
        return "In Progress";
      case 3:
        return "Cancelled";
      default:
        return "Pending";
    }
  }
}
