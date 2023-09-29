import 'package:flutter/material.dart';
import 'package:mymoneyrecord/dbhelper/dbHelper.dart';
import 'package:provider/provider.dart';
import 'package:mymoneyrecord/dbhelper/userProvider.dart';
import 'package:mymoneyrecord/route/route.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    Image.asset('assets/icon/logo_mymoneyrecord_transparan.png', width: 120),
                    const SizedBox(height: 18),
                    Text("MyMoney Record v1.0", style: TextStyle(fontSize:23, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 30, bottom: 0
                ),
                child: TextFormField(
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silakan isi username";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Username",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0
                ),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silakan isi password";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 35,
                margin: const EdgeInsets.only(top: 45.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final username = usernameController.text;
                      final password = passwordController.text;

                      final loginSuccess = await dbHelper.loginUser(username, password);

                      if (loginSuccess) {
                        final userProvider = Provider.of<UserProvider>(context, listen: false);
                        await userProvider.fetchUserByUsername(username);
                        Navigator.pushNamed(context, routeHome);

                      } else {
                        showDialog(context: context, 
                          builder: (context) =>
                          AlertDialog(
                            title: const Text("Login Gagal"),
                            content: const Text("username atau password salah"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK")
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}