import 'package:flutter/material.dart';
import 'package:klinik_pahase2/ui/login.dart';
import 'package:klinik_pahase2/ui/poli_page.dart';
import 'helpers/user_info.dart';
import 'package:klinik_pahase2/ui/beranda.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);
  runApp(MaterialApp(
    title: "MyNotes",
    debugShowCheckedModeBanner: false,
    home: token == null ? const Login() : const PoliPage(),
  ));
}
