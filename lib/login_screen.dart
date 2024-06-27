import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/register_screen.dart';
import 'package:reminder_app/splash_screen.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  late var box;
  bool isLogged = false;

  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    createBox();
  }
  void createBox() async{
    box = await Hive.openBox('userdata');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        color: Colors.lightBlue,
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle 
              ),
              child: const Center(
                child: Icon(Icons.person, size: 50, color: Colors.white,),
              ),
            ),

            SizedBox(height: 20,),

            Text("Welcome User, Silahkan Masuk", style: TextStyle(fontSize: 20, color: Colors.black87),),

            SizedBox(height: 20,),

            TextFormField(
              controller: username,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)
                ),
                prefixIcon: Icon(Icons.person, size: 40,),
                hintText: "Masukan Username",
                hintStyle: TextStyle(color: Colors.black87),
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.black87),
              ),
            ),

            SizedBox(height: 20,),

            TextFormField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)
                ),
                prefixIcon: Icon(Icons.lock, size: 40,),
                hintText: "Masukan Password",
                hintStyle: TextStyle(color: Colors.black87),
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.black87),
              ),
            ),

            SizedBox(height: 20,),

            Card(
              color: Colors.black87,
              elevation: 5,
              child: Container(
                height: 50,
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: (){
                    login();
                  },
                  child: Center(
                    child: Text("Masuk", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                ),
              ),
            ),
            TextButton(onPressed: () {
              Get.to(()=>HalamanRegister());
            }, 
            child: Text('Belum punya akun? daftar')),
          ],
        ),
      ),
    );
  }
  Future login() async{
    String? user = await box.get("email");
    String? userPass = await box.get("pass");
    isLogged = true;

    if (username.value.text == user && pass.value.text == userPass) {
      box.put('isLogged', true);
      Get.snackbar('Succes', 'Berhasil Masuk');
      Get.to(()=>SplashScreen());
    } else {
      Get.snackbar('Error', 'Username atau Password Salah');
    }
  }
}