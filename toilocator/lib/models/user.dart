/// Defintion of the User class.
class User {
  String uid;
  String userName;
  String userEmail;
  String password;
  String gender;
  int age;

  User({
    required this.uid,
    required this.userName,
    required this.userEmail,
    required this.password,
    required this.gender,
    required this.age,
  });

  factory User.fromMap(map) {
    return User(
      uid: map['uid'],
      userName: map['userName'],
      userEmail: map['email'],
      password: map['password'],
      gender: map['gender'],
      age: map['age'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': userEmail,
      'password': password,
      'gender': gender,
      'age': age,
    };
  }
}