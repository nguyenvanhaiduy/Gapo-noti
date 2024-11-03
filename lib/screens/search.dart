import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:gapo_noti/models/noti.dart';
import 'package:gapo_noti/widgets/item_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.notis});
  final List<Noti> notis;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<Noti> _notis = [];
  final ValueNotifier<int> rxUserCharacter = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _notis = widget.notis.where((noti) {
          final String txtSearch = removeDiacritics(_controller.text.trim());
          final String text = removeDiacritics(noti.message['text']);
          return text.toLowerCase().contains(txtSearch);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Noting here!!!',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
    if (_notis.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (context, index) {
          return ItemList(noti: _notis[index]);
        },
        itemCount: _notis.length,
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.cancel_outlined,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Hero(
          tag: 'hero-search',
          child: Material(
            // clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: kToolbarHeight - 15,
              child: TextField(
                autofocus: true,
                controller: _controller,
                cursorWidth: 1.5,
                cursorHeight: 20,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey.withOpacity(0.2),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: content,
    );
  }
}
