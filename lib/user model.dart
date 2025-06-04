
class Userss {
  String pid;
  String itemname;
  String descripton;
  String category;
  String condition;
  String city;
  String image;
  String userId;

  Userss({
    required this.pid,
    required this.itemname,
    required this.descripton,
    required this.category,
    required this.condition,
    required this.city,
    required this.image,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'pid':pid,
      'itemname': itemname,
      'descripton': descripton,
      'category': category,
      'condition': condition,
      'city': city,
      'image': image,
      'userId':userId
    };
  }

  factory Userss.fromMap(Map<String, dynamic> map) {
    return Userss(
      pid: map['pid'],
      itemname: map['itemname'],
      descripton: map['descripton'],
      category: map['category'],
      condition: map['condition'],
      city: map['city'],
      image: map['image'],
      userId: map['userId'],
    );
  }
}

