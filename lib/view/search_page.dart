import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssl_app/controller/service.dart';
import 'package:ssl_app/model/documents.dart';

import '../model/users.dart';

// class SearchPage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Page'),
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }
// }

class SearchPage extends StatefulWidget {
  //
  SearchPage() : super();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //
  List<Users> _docs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Service.getDocuments().then((user) {
      setState(() {
        _docs = user;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Documents'),
      ),
      body: Container(
        color: Colors.grey,
        child: ListView.builder(
          itemCount: null == _docs ? 0 : _docs.length,
          itemBuilder: (context, index) {
            Users document = _docs[index];
            return ListTile(
              title: Text(document.name),
              subtitle: Text(document.email.toString()),
            );
          },
        ),
      ),
    );
  }
}
