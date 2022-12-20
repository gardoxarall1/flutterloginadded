class Post {
  String? title;
  String? description;
  String? image;
  String? avatar;
  String? name;
  bool? isLike;
  bool? isFile;
  Post(
      {this.title,
      this.description,
      this.image,
      this.avatar,
      this.isLike = false,
      this.name,
      this.isFile = false});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      image: json['image'],
      description: json['description'],
      isLike: json['isLiked'],
      avatar: json['avatarImage'],
      name: json['name'],
      
    );
  }
}
