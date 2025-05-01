import 'package:e_commerce_app/app/models/sales.dart';
import 'package:e_commerce_app/app/services/admin_service.dart';
import 'package:e_commerce_app/widgets/analytics_charts.dart';
import 'package:e_commerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AdminService adminService = AdminService();
  List<Sales>? sales;
  double? totalSales;
  double? totalOrders;
  double? totalProducts;

  @override
  void initState() {
    super.initState();
    getAnalytics();
  }

  void getAnalytics() async {
    var dataSale = await adminService.getTotalSales(context);
    totalSales = dataSale['totalSales'];
    totalOrders = dataSale['totalOrders'];
    totalProducts = dataSale['totalProducts'];
    sales = dataSale['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null
        ? const Loader()
        : Column(
          children: [
            Text(
              'Total Sales: \$$totalSales',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Orders: \$$totalOrders',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Products: \$$totalProducts',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 250,
              child: AnalyticsCharts(
                salesList: sales!, // ✅ التعديل هنا
              ),
            ),
          ],
        );
  }
}
