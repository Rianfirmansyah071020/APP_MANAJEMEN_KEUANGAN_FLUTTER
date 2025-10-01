import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:manajemen_keuangan/presentation/pages/template_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      title: "Dashboard",
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // === CARD METRIK ===
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWideScreen = constraints.maxWidth > 600;

                    return GridView.count(
                      crossAxisCount: isWideScreen ? 3 : 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: isWideScreen ? 2.5 : 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildDashboardCard(
                          context,
                          title: "Total Pengeluaran",
                          icon: FontAwesomeIcons.wallet,
                          colors: const [Color(0xFF03B8B8), Color(0xFF21B1EB)],
                        ),
                        _buildDashboardCard(
                          context,
                          title: "Total Pemasukan",
                          icon: FontAwesomeIcons.moneyBill,
                          colors: const [Color(0xFF10B981), Color(0xFF34D399)],
                        ),
                        _buildDashboardCard(
                          context,
                          title: "Total Tabungan",
                          icon: FontAwesomeIcons.piggyBank,
                          colors: const [Color(0xFF2563EB), Color(0xFF3B82F6)],
                        ),
                      ],
                    );
                  },
                ),
              ),

              // === GRAFIK TRANSAKSI PER BULAN ===
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 300,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Grafik Transaksi Per Bulan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: true),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: true),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        final months = [
                                          "Jan",
                                          "Feb",
                                          "Mar",
                                          "Apr",
                                          "Mei",
                                          "Jun",
                                          "Jul",
                                          "Agu",
                                          "Sep",
                                          "Okt",
                                          "Nov",
                                          "Des",
                                        ];
                                        if (value.toInt() >= 0 &&
                                            value.toInt() < months.length) {
                                          return Text(
                                            months[value.toInt()],
                                            style: const TextStyle(
                                              fontSize: 11,
                                            ),
                                          );
                                        }
                                        return const Text('');
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(show: true),
                                minX: 0,
                                maxX: 11,
                                minY: 0,
                                maxY: 200,
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    spots: const [
                                      FlSpot(0, 50), // Jan
                                      FlSpot(1, 120), // Feb
                                      FlSpot(2, 90), // Mar
                                      FlSpot(3, 150), // Apr
                                      FlSpot(4, 100), // Mei
                                      FlSpot(5, 140), // Jun
                                      FlSpot(6, 80), // Jul
                                      FlSpot(7, 160), // Agu
                                      FlSpot(8, 130), // Sep
                                      FlSpot(9, 170), // Okt
                                      FlSpot(10, 110), // Nov
                                      FlSpot(11, 180), // Des
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.lightBlue],
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.withOpacity(0.3),
                                          Colors.lightBlue.withOpacity(0.1),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    dotData: FlDotData(show: true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> colors,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    final iconSize = isWideScreen ? 50.0 : 30.0;
    final titleSize = isWideScreen ? 18.0 : 14.0;
    final valueSize = isWideScreen ? 26.0 : 20.0;
    final padding = isWideScreen ? 20.0 : 12.0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white, size: iconSize),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: titleSize,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Rp 0",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: valueSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
