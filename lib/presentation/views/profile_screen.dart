import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new1/presentation/widgets/profile_item.dart';
import 'package:new1/providers/posts_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CircleAvatar(
                foregroundImage: AssetImage("assets/images.png"),
                radius: 50,
              ),
              const SizedBox(height: 10),
              const Text("WAEL alaya"),
              const SizedBox(height: 30),
              Consumer<PostsProivider>(builder: (context, value, child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileItem(title: "Posts", value: value.list.length),
                      ProfileItem(title: "Likes", value: value.likesNumber),
                      const ProfileItem(title: "Following", value: 200)
                    ]);
              }),
              const SizedBox(height: 30),
              Flexible(
                fit: FlexFit.tight,
                child:
                    Consumer<PostsProivider>(builder: (context, value, child) {
                  return value.isLoading
                      ? const CupertinoActivityIndicator()
                      : GridView.builder(
                          itemCount: value.list.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  mainAxisExtent: 150),
                          itemBuilder: ((context, index) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: value.list[index].isFile!
                                          ? Image.file(
                                              File(value.list[index].image!))
                                          : Image.network(
                                              value.list[index].image!,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        Provider.of<PostsProivider>(context,
                                                listen: false)
                                            .onPressedLike(index);
                                      },
                                      icon: Icon(
                                        value.list[index].isLike!
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.red,
                                      )),
                                )
                              ],
                            );
                          }));
                }),
              ),
            ],
          ),
        ));
  }
}
