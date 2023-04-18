import 'package:flutter/material.dart';
import '../ui/beranda.dart';
import '../ui/login.dart';
import '../ui/poli_form.dart';
import '../ui/poli_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey, // set your desired color here
            ),
            accountName: Text(
              "Lisa",
              style: TextStyle(
                  fontFamily: 'Helvatica',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("lisauma@gmail.com",
                style: TextStyle(fontFamily: 'Helvatica')),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/sau.jpg'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home",
                style: TextStyle(fontFamily: 'Helvatica', fontSize: 20)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Beranda()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text("My Notes",
                style: TextStyle(fontFamily: 'Helvatica', fontSize: 20)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PoliPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_rounded),
            title: const Text("Add New Notes",
                style: TextStyle(fontFamily: 'Helvatica', fontSize: 20)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PoliForm()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text(
              "Log Out",
              style: TextStyle(
                  fontFamily: 'Helvatica',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
