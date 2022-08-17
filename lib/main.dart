import 'package:flutter/material.dart';
import 'package:ssl_app/utils/dependency_injection/dependency_injection.dart';
import 'package:ssl_app/view/add_document.dart';
import 'package:ssl_app/view/search_page.dart';

import 'package:ssl_app/view/third_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Awesome App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        foregroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: ListView(
            children: [
              Container(
                color: Colors.red,
                child: const DrawerHeader(child: CircleAvatar(child: Icon(Icons.home, size: 50))),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search Page'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Add Document'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDocument()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Change Language'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ThirdPage()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
