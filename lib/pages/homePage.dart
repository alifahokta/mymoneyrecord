import 'package:flutter/material.dart';
import 'package:mymoneyrecord/dbhelper/dbHelper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mymoneyrecord/route/route.dart';

class homePage extends StatefulWidget {

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int totalPemasukan = 0;
  int totalPengeluaran = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalPemasukandanPengeluaran();
  }

  Future<void> _fetchTotalPemasukandanPengeluaran() async {

    final dbHelper = DbHelper();

    final pemasukan = await dbHelper.getTotalPemasukan();
    final pengeluaran = await dbHelper.getTotalPengeluaran();

    setState(() {
      totalPemasukan = pemasukan;
      totalPengeluaran = pengeluaran;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalPemasukandanPengeluaran(); 
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
            child: Column(
          children: [
            Text(
              "Rangkuman Bulan Ini",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Pengeluaran\t: Rp $totalPengeluaran", style: TextStyle(color: Colors.red, fontSize: 16)),
            Text("Pemasukan\t: Rp $totalPemasukan", style: TextStyle(color: Colors.green, fontSize: 16)),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(width: 2, color: Colors.black)),
                  maxX: 5,
                  minX: 0,
                  maxY: 1000,
                  minY: 0,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 150),
                        FlSpot(1, 750),
                        FlSpot(2, 350),
                        FlSpot(3, 700),
                        FlSpot(4, 550),
                        FlSpot(5, 650),
                      ],
                      isCurved: true,
                      color: Colors.green,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 100),
                        FlSpot(1, 550),
                        FlSpot(2, 550),
                        FlSpot(3, 300),
                        FlSpot(4, 750),
                        FlSpot(5, 450),
                      ],
                      isCurved: true,
                      color: Colors.red,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ])),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavigatorButton(
                      imagePath: 'assets/icon/pemasukan.png',
                      label: "Tambah Pemasukan",
                      onTap: () {
                        Navigator.pushNamed(context, routePemasukan);
                      }
                    ),
                    NavigatorButton(
                      imagePath: 'assets/icon/pengeluaran.png',
                      label: "Tambah Pengeluaran",
                      onTap: () {
                        Navigator.pushNamed(context, routePengeluaran);
                      }
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavigatorButton(
                      imagePath: 'assets/icon/detail_cashflow.png',
                      label: "Detail Cash Flow",
                      onTap: () {
                        Navigator.pushNamed(context, routeDetailCashFlow);
                      }
                    ),
                    NavigatorButton(
                      imagePath: 'assets/icon/pengaturan.png',
                      label: "Pengaturan",
                      onTap: () {
                        Navigator.pushNamed(context, routePengaturan);
                      }
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

class NavigatorButton extends StatelessWidget {
  final String imagePath, label;
  final VoidCallback onTap;

  const NavigatorButton({required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath, width: 100,
          ),
          SizedBox(height: 10,),
          Text(label),
        ],
      ),
    );
  }
}