import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/login_screen.dart';

class HalamanRegister extends StatefulWidget {
  const HalamanRegister({super.key});

  @override
  State<HalamanRegister> createState() => _HalamanRegisterState();
}

class _HalamanRegisterState extends State<HalamanRegister> {

  late var box;
  void initState() {
    super.initState();
    createBox();
  }
  void createBox() async {
    box = await Hive.openBox('userdata');
    setState(() { });
  }


  TextEditingController _username = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        color: Colors.lightBlue,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Buat Akun",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                      hintText: "Nama Lengkap", icon: Icon(Icons.badge)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                      hintText: "Username", icon: Icon(Icons.person),),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pass,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password", icon: Icon(Icons.lock)),
                ),
              
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    registration();
                  },
                  child: const Text("Daftar")
                ),
              ],
            ),
          ),
          ),
        ),
      );
  }
Future registration() async{
    if (_name.text.isEmpty || _username.text.isEmpty || _pass.text.isEmpty) {
    Get.snackbar('Error', 'Semua field harus diisi');
    return;
  }
    box.put('name', _name.text);
    box.put('email', _username.text);
    box.put('pass', _pass.text);
    print(_name.text);
    print(_username.text);
    print(_pass.text);
    Get.to(()=>HalamanLogin());
  }
}