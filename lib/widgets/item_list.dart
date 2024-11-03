import 'package:flutter/material.dart';
import 'package:gapo_noti/widgets/content.dart';
import 'package:gapo_noti/widgets/custom_avartar.dart';
import 'package:gapo_noti/models/noti.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key, required this.noti});
  final Noti noti;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  var status;

  @override
  void initState() {
    super.initState();
    status = widget.noti.status;
  }

  List<Map<String, String>> _customText(Map<String, dynamic> result) {
    final List<Map<String, String>> results = [];
    List<Map<String, dynamic>> hg = [];
    final String text = result['text'];

    for (var item in result['highlights']) {
      hg.add(item);
    }
    int j = 0, m = 0;
    for (var item in hg) {
      if (j > 0) {
        results.add({'nBold': text.substring(j, item['offset'])});
      }
      j = item['offset'] + item['length'];
      results.add({
        'bold': text.substring(
          item['offset'],
          item['offset'] + item['length'],
        ),
      });
      m = item['offset'] + item['length'];
    }
    if (m < text.length) {
      results.add({'nBold': text.substring(m, text.length)});
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> listResult = _customText(widget.noti.message);
    return InkWell(
      onTap: () {
        setState(() {
          status = 'read';
        });
      },
      child: Container(
        color: status == 'read' ? Colors.white : Colors.green[50],
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            CustomAvatar(
              url: widget.noti.imageThumb,
            ),
            const SizedBox(width: 8),
            Content(listResult: listResult),
          ],
        ),
      ),
    );
  }
}
