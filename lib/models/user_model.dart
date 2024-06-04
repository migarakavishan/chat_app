class UserModel {
  String name;
  String image;
  String uid;
  String lastSeen;
  bool isOnline;

  UserModel(
      {required this.name,
      required this.image,
      required this.isOnline,
      required this.lastSeen,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        image: json['image'],
        isOnline: json['isOnline'],
        lastSeen: json['lastSeen'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "isOnline": isOnline,
      "lastSeen": lastSeen,
      "uid": uid
    };
  }
}
