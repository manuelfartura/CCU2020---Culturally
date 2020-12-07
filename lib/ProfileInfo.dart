class ProfileInfo {
  int id = 0;
  String name = "";
  String email = "";
  String insta = "";
  String image = "";
  String phone = "";
  String aboutMe = "";
  String paymentMethod = "";

  ProfileInfo({
    this.id,
    this.name,
    this.email,
    this.insta,
    this.image,
    this.phone,
    this.aboutMe,
    this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'image': image,
      'insta': insta,
      'aboutMe': aboutMe,
      'paymentMethod': paymentMethod,
    };
  }
}