import 'dart:convert';

import 'package:gapo_noti/screens/search.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gapo_noti/models/noti.dart';
import 'package:gapo_noti/widgets/item_list.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> with TickerProviderStateMixin {
  List<Noti> _notiList = [];

  void _loadData() async {
    final String response = await rootBundle.loadString('assets/noti.json');
    final data = await json.decode(response);

    List<Noti> _tmpNoti = [];
    for (final item in data['data']) {
      _tmpNoti.add(
        Noti(
          id: item['id'],
          message: item['message'],
          imageThumb: item['imageThumb'],
          status: item['status'],
          subjectName: item['subjectName'],
        ),
      );
    }
    setState(() {
      _notiList = _tmpNoti;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    notis: _notiList,
                  ),
                ),
              );
            },
            icon: const Hero(
              tag: 'hero-search',
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            final noti = _notiList[index];
            return ItemList(noti: noti);
          }),
          itemCount: _notiList.length,
        ),
      ),
    );
  }
}
