class MdProfile {
  final int id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? token;

  MdProfile({
    required this.id, 
    required this.username, 
    required this.email, 
    required this.firstName, 
    required this.lastName, 
    required this.gender, 
    required this.image, 
    required this.token
  });

  static MdProfile fromJson(dynamic json) => MdProfile(
    id          : json['id'],
    username    : json['username'],
    email       : json['email'],
    firstName   : json['firstName'],
    lastName    : json['lastName'],
    gender      : json['gender'],
    image       : json['image'],
    token       : json['token']
  ); 
}