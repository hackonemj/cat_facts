import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:demoji/demoji.dart';

import 'CatFact.dart';

// ignore: must_be_immutable
class CatFactList extends StatefulWidget {
  var url = "https://cat-fact.herokuapp.com/facts";
  var list_of_cat_facts = [];

  @override
  _CatFactListState createState() => _CatFactListState();
}

class _CatFactListState extends State<CatFactList> {
  @override
  void initState() {
    super.initState();
  }

  Future<CatFacts> getCats() async {
    var response = await http.get(widget.url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      CatFacts catFacts = CatFacts.fromJson(jsonResponse);
      for (int x = 0; x < catFacts.lista.length; x++) {
        String facto = catFacts.lista[x].text;
        widget.list_of_cat_facts.add(facto);
      }
      return CatFacts.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Cat facts"),
      ),
      body: FutureBuilder(
        future: getCats(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<CatFacts> snapshot) {
          if (snapshot.hasData) {
            return _myListView(context, widget.list_of_cat_facts);
          } else {
            return Container(
              child: Center(
                child: Text("No Data"),
              ),
            );
          }
        },
      ),
    );
  }
}

Widget _myListView(BuildContext context, List lista) {
  return ListView.builder(
    itemCount: lista.length,
    itemBuilder: (context, index) {
      return Card(
        // <-- Card widget
        child: ListTile(
          leading: Text(
            Demoji.cat2,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          title: Text(lista[index]),
        ),
      );
    },
  );
}
