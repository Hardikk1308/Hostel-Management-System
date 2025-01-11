class LoginResponse {
  final bool success;
  final User user;

  LoginResponse({
    required this.success,
    required this.user,
  });

  // Factory method to create a LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final int erpid;


  User({
    required this.id,
    required this.erpid,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      erpid: json['erpid'],

    );
  }
}
