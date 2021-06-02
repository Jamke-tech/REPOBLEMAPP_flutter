class User {
  //Variables del Usuari

  String userName;
  String name;
  String surname;
  String password;
  String email;
  String phone;
  String profilePhoto;
  DateTime birthDate;
  bool notifications;
  bool privacity;
  bool security;

  User(
      {this.userName,
      this.name,
      this.surname,
      this.password,
      this.email,
      this.phone,
      this.profilePhoto,
      this.birthDate,
      this.notifications,
      this.privacity,
      this.security});

  String getUserName() {
    return this.userName;
  }
}
