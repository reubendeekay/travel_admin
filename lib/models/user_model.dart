class UserModel {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String imageUrl;
  final DateTime dateOfBirth;
  final String address;
  final String nationalId;
  final String userId;

  const UserModel({
    this.userId,
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.imageUrl,
    this.address,
    this.nationalId,
    this.dateOfBirth,
  });
}
