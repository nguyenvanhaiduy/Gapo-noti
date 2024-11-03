import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key, required this.url});
  final String url;

  Future<bool> checkImage(String url) async {
    final response = await http.head(Uri.parse(url));

    return response.statusCode == 200;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.09),
          ),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return CircleAvatar(
                  backgroundImage: NetworkImage(
                    url,
                  ),
                  radius: 35,
                );
              }
              return const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pinimg.com/564x/99/6c/a6/996ca6d41ae979589d3f50e0967cdcb9.jpg',
                ),
                radius: 35,
              );
            },
            future: checkImage(url),
          ),
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          child: Icon(
            Icons.notifications,
            size: 25,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
