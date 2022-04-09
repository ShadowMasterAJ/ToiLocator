class User{
  String uid;
  String userName;
  String userEmail;
  String password;
  String gender;
  int age;

  User({ required this.uid, required this.userName,required this.userEmail,required this.password,required this.gender, required this.age});

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

// class UserRecord {
//   String uid;
//   String userName;
//   String userEmail;
//   String password;
//   String gender;
//   int age;

//   UserRecord({ required this.uid, required this.userName,required this.userEmail,required this.password,required this.gender, required this.age});


// factory UserRecord.fromMap(map) {
//     return UserRecord(
//       uid: map['uid'],
//       userName: map['userName'],
//       userEmail: map['email'],
//       password: map['password'],
//       gender: map['gender'],
//       age: map['age'],
//     );
//   }

//   // sending data to our server
//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'userName': userName,
//       'email': userEmail,
//       'password': password,
//       'gender': gender,
//       'age': age,
//     };
//   }




// }

// class UserController {
//   UserRecord _currentUser;
//   auth.AuthService _authService = locator.get<auth.AuthService>();
//   Future init;

//   UserController() {
//     init = initUser();
//   }

//   Future<UserRecord> initUser() async {
//     _currentUser = await _authService.getCurrentUser();
//     return _currentUser;
//   }

//   UserRecord get currentUser => _currentUser;}





//notes:when a new user registers, the firebase automatically create a unique id for that user
//when we create a new document of that user in the user collection, take that unique uid, link together



