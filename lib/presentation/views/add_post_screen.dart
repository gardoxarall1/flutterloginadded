import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new1/models/post.dart';
import 'package:new1/presentation/widgets/custom_textfield.dart';
import 'package:new1/providers/posts_provider.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddPostScreenState();
  }
}

class _AddPostScreenState extends State<AddPostScreen> {
  XFile? _image;
  String? _title;
  String? _description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add post")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                title: "title",
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                isMultiline: true,
                title: "Description",
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              ElevatedButton.icon(
                  onPressed: () => pickImage(),
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text("Add photo")),
              if (_image != null)
                Image.file(File(_image!.path), height: 100, width: 100)
              else
                Container(),
              ElevatedButton(
                  onPressed: () {
                    if (_title != null &&
                        _description != null &&
                        _image != null) {
                      Post post = Post(
                          title: _title,
                          description: _description,
                          image: _image!.path,
                          isLike: false,
                          name: "Welcome",
                          isFile: true);
                      Provider.of<PostsProivider>(context, listen: false)
                          .AddPost(post);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Add Post"))
            ],
          ),
        ));
  }
}
