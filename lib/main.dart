import 'package:flutter/material.dart';
import 'package:klinik_pahase2/ui/note_page.dart';
import 'helpers/user_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);
  runApp(const MaterialApp(
    title: "MyNotes",
    debugShowCheckedModeBanner: false,
    home: NotePage(),
  ));
}
