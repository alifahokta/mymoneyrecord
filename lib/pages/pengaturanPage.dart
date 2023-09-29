import 'package:flutter/material.dart';
import 'package:mymoneyrecord/dbhelper/dbHelper.dart';
import 'package:mymoneyrecord/models/user.dart';
import 'package:provider/provider.dart';
import 'package:mymoneyrecord/dbhelper/userProvider.dart';

class pengaturanPage extends StatefulWidget {

  @override
  State<pengaturanPage> createState() => _pengaturanPageState();
}

class _pengaturanPageState extends State<pengaturanPage> {
  
  TextEditingController passwordLamaController = TextEditingController();
  TextEditingController passwordBaruController = TextEditingController();

  String namaPengembang = "Alifah Okta Nur Wardani";
  String nimPengembang = "2141764095";
  String tanggalPengembangan = "28 September 2023";

  final DbHelper dbHelper = DbHelper();
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: const Text(
                "Pengaturan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: const Text(
                "Ganti Password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, ),
              ),
            ),
            TextField(
              controller: passwordLamaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Saat Ini",
              ),
            ),
            TextField(
              controller: passwordBaruController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _ubahPassword(user!);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text("Simpan"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text("<< Kembali"),
            ),
            const SizedBox(height: 220),
            Stack(
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    'assets/images/alifah_foto.jpg',
                    width: 125, 
                    height: 125,
                  ),
                ),
                
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      const Text(
                        "About this App",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text("Aplikasi ini dibuat oleh: "),
                      Text("Nama : $namaPengembang"),
                      Text("Nim : $nimPengembang"),
                      Text("Tanggal : $tanggalPengembangan"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _ubahPassword(User user) {
    String currentPasswordInput = passwordLamaController.text;
    String newPasswordInput = passwordBaruController.text;

    if (currentPasswordInput == user.password) {
      dbHelper.changePassword(user.username!, newPasswordInput);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password berhasil diubah."),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password saat ini salah, silakan ulangi kembali."),
      ));
    }
  }

}