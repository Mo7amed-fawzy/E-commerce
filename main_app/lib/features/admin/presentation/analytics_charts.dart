import 'package:e_commerce_app/core/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsCharts extends StatelessWidget {
  const AnalyticsCharts({super.key, required this.salesList});

  final List<Sales> salesList;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups:
            salesList.asMap().entries.map((entry) {
              int index = entry.key;
              Sales sale = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: sale.totalSale.toDouble(),
                    width: 20,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              );
            }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value.toInt() >= 0 && value.toInt() < salesList.length) {
                  return SideTitleWidget(
                    meta: meta, // ✅ لازم تبعت meta هنا
                    child: Text(
                      salesList[value.toInt()].label,
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
      ),
    );
  }
}
