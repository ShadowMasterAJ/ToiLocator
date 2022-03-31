class User{
  final String uid;

  User({required this.uid});
}

//notes:when a new user registers, the firebase automatically create a unique id for that user
//when we create a new document of that user in the user collection, take that unique uid, link together