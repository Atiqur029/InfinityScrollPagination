import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagination/model/welcome.dart';

class PagicnationWithoutGetx extends StatefulWidget {
  const PagicnationWithoutGetx({super.key});

  @override
  State<PagicnationWithoutGetx> createState() => _PagicnationWithoutGetxState();
}

class _PagicnationWithoutGetxState extends State<PagicnationWithoutGetx> {
  List<Result> result = [];
  bool loading = true;
  int offset = 0;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata(offset);
    handlepage();
  }

  Future<void> fetchdata(peraOffset) async {
    print(offset);
    var respons = await http.get(Uri.parse(
        "https://pokeapi.co/api/v2/pokemon?off...%203.%20https://app.quicktype.io/"));

    Model model = Model.fromJson(json.decode(respons.body));
    result = result + model.results;
    int localofset = offset + 50;
    setState(() {
      result;
      loading = false;
      offset = localofset;
    });
  }

  void handlepage() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        fetchdata(offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Infinity Scroll Pagicnation"),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: result.length,
        itemBuilder: (context, index) => ListTile(
          tileColor: index % 2 == 0 ? Colors.amber : Colors.green,
          title: Text(result[index].name),
          subtitle: Text(result[index].url),
        ),
      ),
    );
  }
}
