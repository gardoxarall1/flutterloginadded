import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new1/models/post.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, this.post, required this.onPressed});
  final Post? post;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          post!.isFile!
              ? Image.file(
                  File(post!.image!),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                )
              : Image.network(
                  post!.image ??
                      "https://cdn.dribbble.com/users/206362/screenshots/14453538/media/cfe80febeed64218b34e18f518ca9ae9.jpg?compress=1&resize=400x300&vertical=top",
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CircleAvatar(
                  foregroundImage: AssetImage("assets/images.png"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post!.title!,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post!.description!,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      post!.isLike!
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
