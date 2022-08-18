import 'package:flutter/material.dart';
import 'package:ssl_app/utils/dependency_injection/dependency_injection.dart';
import 'package:ssl_app/view/add_document.dart';
import 'package:ssl_app/view/animated_toggle.dart';
import 'package:ssl_app/view/search_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ssl_app/translations/locale_keys.g.dart';
import 'package:ssl_app/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  init();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'SSL APP Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: "SSL App Demo"),
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
        title: Text(LocaleKeys.appTitle.tr()),
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(210, 255, 255, 255),
          child: ListView(
            children: [
              Container(
                color: Color.fromARGB(255, 194, 245, 236),
                child: const DrawerHeader(
                    child: CircleAvatar(child: Icon(Icons.rocket, size: 100))),
              ),
              Container(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(LocaleKeys.searchPage.tr()),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
              ),
              Container(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.add_rounded),
                title: Text(LocaleKeys.addDocument.tr()),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddDocument()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 180, 238, 230),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedToggle(
                values: ['English', 'العربية'],
                onToggleCallback: (value) {
                  setState(() {
                    if (value == 0) {
                      context.setLocale(Locale('en'));
                    } else {
                      context.setLocale(Locale('ar'));
                    }
                  });
                },
                buttonColor: Color.fromARGB(255, 0, 204, 255),
                backgroundColor: const Color(0xFFB5C1CC),
                textColor: const Color(0xFFFFFFFF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
