import 'package:flutter/material.dart';
import 'package:mymoneyrecord/dbhelper/dbHelper.dart';
import 'package:intl/intl.dart';

class pemasukanPage extends StatefulWidget {
  pemasukanPage({Key? key}) : super(key: key);

  @override
  State<pemasukanPage> createState() => _pemasukanPageState();
}

class _pemasukanPageState extends State<pemasukanPage> {
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  final DbHelper dbHelper = DbHelper();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void resetForm() {
    tanggalController.text = DateFormat('dd/MM/yyyy').format(DateTime(2021,01,01));
    jumlahController.clear();
    deskripsiController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        tanggalController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
              Text("Tambah Pemasukan", style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold,)
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
              labelText: "Tanggal",
              suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: tanggalController,
              readOnly: true,
              onTap: () {
              _selectDate(context);
              },
            ),
            TextField(
              decoration: InputDecoration(
              labelText: "Nominal",
              ),
              controller: jumlahController,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(
              labelText: "Keterangan",
              ),
              controller: deskripsiController,
            ),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)
                    ),
                    onPressed: () {
                        resetForm();
                    },
                    child: const Text("Reset"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                    ),
                    onPressed: () async {
                      String tanggal = tanggalController.text;
                      String jumlah = jumlahController.text;
                      String deskripsi = deskripsiController.text;

                      if (tanggal.isNotEmpty && jumlah.isNotEmpty) {
                        int rowCount = await dbHelper.insertPemasukan(
                            tanggal, jumlah, deskripsi);
                        if (rowCount > 0) {
                          resetForm();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Data Pemasukan Berhasil Disimpan"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Data Pengeluaran Gagal Disimpan"),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Form Tanggal dan Jumlah Perlu Diisi"),
                          ),
                        );
                      }
                    },
                    child: const Text("Simpan"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                    ),
                    onPressed: () {
                        Navigator.pop(context);
                    },
                    child: const Text("<< Kembali"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}