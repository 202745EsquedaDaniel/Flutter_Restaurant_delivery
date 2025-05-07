class AppUser {
  final String uid;
  final String email;
  final String name;
  final String orgId;
  final String? branchId;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.orgId,
    this.branchId,
  });

  //  convert app user -> json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'orgId': orgId,
      'branchId': branchId,
    };
  }

  //  convert json -> app user
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
      orgId: jsonUser['orgId'],
      branchId: jsonUser['branchId'],
    );
  }
}
