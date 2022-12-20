import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new1/presentation/views/buttom_app_bar.dart';
import 'package:new1/presentation/widgets/custom_buttons.dart';
import 'package:new1/presentation/widgets/custom_textfield.dart';
import 'package:new1/soruce/data_source/local_data_source.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
  late final DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    _email = "";
    _password = "";
    dbHelper = DbHelper();
    _onStartUp();
  }

  _onStartUp() async {
    UserModel uModel = UserModel("admin", "admin123");
    await dbHelper.saveData(uModel).then((userData) {
      //
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => LoginForm()));
    }).catchError((error) {
      log(error.toString(), name: "#####");
    });
  }
  final snackBar = const SnackBar(
    content: Text('email or password incorrect'),
  );



    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.



  login() async {
    final UserModel? value = await dbHelper.getLoginUser(_email, _password);
    if (value == null){
      Future.microtask(()=>ScaffoldMessenger.of(context).showSnackBar(snackBar));
      return;
    }
    Future.microtask(() => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
            const BottomAppBarNavigation())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("My app"),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          // Parent Size
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              // image: AssetImage("assets/img1.jpg"),
              image: NetworkImage(
                  "https://images.pexels.com/photos/13415959/pexels-photo-13415959.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              fit: BoxFit.cover,
            ),
          ),
          //height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontFamily: "island",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CustomTextField(
                  title: "Email",
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
              ),
              CustomTextField(
                title: "password",
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              CustomButtons(
                onPressed: login,
              )
            ],
          ),
        ));
  }
}
