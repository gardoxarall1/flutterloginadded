import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new1/presentation/widgets/item_widget.dart';
import 'package:new1/providers/posts_provider.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<PostsProivider>(context, listen: false).getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.amber,
        ),
        body: Consumer<PostsProivider>(builder: (context, value, child) {
          return value.isLoading
              ? const CupertinoActivityIndicator()
              : ListView.separated(
                  itemCount: value.list.length,
                  itemBuilder: (context, index) => ItemWidget(
                    onPressed: (() {
                      Provider.of<PostsProivider>(context, listen: false)
                          .onPressedLike(index);
                    }),
                    post: value.list[index],
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                    thickness: 2,
                    height: 20,
                  ),
                );
        }));
  }
}
