import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({super.key, required this.listResult});
  final List<Map<String, String>> listResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    children: listResult.map((text) {
                      if (text.containsKey('bold')) {
                        return TextSpan(
                            text: text.values.first,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold));
                      }
                      return TextSpan(text: text.values.first);
                    }).toList(),
                  ),
                ),
              ),
              const Text('20/09/2019, 11:57'),
              const SizedBox(height: 4),
            ],
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              // width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '...',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
