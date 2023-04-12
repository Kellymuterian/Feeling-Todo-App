class User {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? image;
  String? api_token;
  String? password;
  User({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.image,
    this.api_token,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'image': image,
      'api_token': api_token,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      first_name:
          map['first_name'] != null ? map['first_name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      api_token: map['api_token'] != null ? map['api_token'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }
}
