class UserModel {
  String name;
  String image;
  String uid;
  String lastSeen;
  bool isOnline;
  String token;

  UserModel(
      {required this.name,
      required this.image,
      required this.isOnline,
      required this.lastSeen,
      required this.uid,
      this.token = ""});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        image: json['image'],
        isOnline: json['isOnline'],
        lastSeen: json['lastSeen'],
        uid: json['uid'],
        token: json['token'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "isOnline": isOnline,
      "lastSeen": lastSeen,
      "uid": uid,
      "token": token
    };
  }
}
