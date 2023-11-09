class UserProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String invitationCode;
  final String countryCode;
  final List<String> languages;

  const UserProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.invitationCode,
    required this.countryCode,
    required this.languages,
  });

  static UserProfileModel fromMap(Map map) {
    return UserProfileModel(
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      email: map["email"] ?? "",
      phoneNumber: map["phoneNumber"] ?? "",
      invitationCode: map["invitationCode"] ?? "",
      countryCode: map["countryCode"] ?? "",
      languages: ((map["languages"] ?? [""]) as List)
          .map((e) => e.toString())
          .toList(),
    );
  }

  static UserProfileModel emptyUser() {
    return UserProfileModel(
      firstName: "",
      lastName: "",
      email: "",
      phoneNumber: "",
      invitationCode: "",
      countryCode: "",
      languages: [],
    );
  }
}
