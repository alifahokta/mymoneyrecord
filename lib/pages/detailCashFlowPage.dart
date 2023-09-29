import 'package:flutter/material.dart';
import 'package:mymoneyrecord/dbhelper/dbHelper.dart';
import 'package:mymoneyrecord/dbhelper/tipeKeuangan.dart';
import 'package:mymoneyrecord/models/keuangan.dart';

class detailCashFlowPage extends StatefulWidget {
  const detailCashFlowPage({super.key});

  @override
  State<detailCashFlowPage> createState() => _detailCashFlowPageState();
}

class _detailCashFlowPageState extends State<detailCashFlowPage> {
  
  List<Keuangan> cashFlowData = [];

  @override
  void initState() {
    super.initState();
    _fetchCashFlowData();
  }

  Future<void> _fetchCashFlowData() async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb();
    List<Keuangan> data = await dbHelper.getKeuangan();

    setState(() {
      cashFlowData = data;
    });
  }

  Future<void> _deleteItem(int index) async {
    DbHelper dbHelper = DbHelper();
    await dbHelper.initDb();

    await dbHelper.deleteDataKeuangan(cashFlowData[index].id!);

    setState(() {
      cashFlowData.removeAt(index);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Detail Cash Flow", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cashFlowData.length,
                itemBuilder: (context, index) {
                  final item = cashFlowData[index];
                  final isPemasukan = item.tipe == tipePemasukan;

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () async {
                          _deleteItem(index);
                        },
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                      
                      title: 
                      Text(
                            "${isPemasukan ? '[ + ] Rp ' : '[ - ] Rp '}: ${item.jumlah}",
                            style: TextStyle(fontSize: 16),
                          ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Keterangan: ${item.deskripsi}",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(item.tanggal!),
                        ],
                      ),
                      trailing: Icon(
                        isPemasukan ? Icons.arrow_back_outlined : Icons.arrow_forward_outlined,
                        color: isPemasukan ? Colors.green : Colors.red,
                        size: 27,
                      ),
                    ),
                  );
                }
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(400, 35)), 
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("<< Kembali"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}