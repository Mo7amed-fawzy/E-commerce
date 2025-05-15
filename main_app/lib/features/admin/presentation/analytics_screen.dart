import 'package:e_commerce_app/core/dependency_injection/service_locator.dart';
import 'package:e_commerce_app/core/models/sales.dart';
import 'package:e_commerce_app/core/services/admin_service.dart';
import 'package:e_commerce_app/features/admin/presentation/analytics_charts.dart';
import 'package:e_commerce_app/core/widgets/loader.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final adminService = getIt<AdminService>();

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
