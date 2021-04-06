class User{
   final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;
  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

final User currentUser = User(
  id: 0,
  name: 'Veng E',
  imageUrl: 'assets/images/nick-fury.jpg',
  isOnline: true,
);

// USERS
final User sopharuth = User(
  id: 1,
  name: 'sopharuth',
  imageUrl: 'assets/images/chat/user1.jpg',
  isOnline: true,
);
final User soheng = User(
  id: 2,
  name: 'soheng ',
  imageUrl: 'assets/images/chat/user2.jpg',

  isOnline: true,
);
final User seyha = User(
  id: 3,
  name: 'seyha',
  imageUrl: 'assets/images/chat/user3.jpg',
  isOnline: false,
);


