class LoginResponseModel {
  final String token;
  final String refreshToken;
  String message = '';

  LoginResponseModel(
      {required this.token, required this.refreshToken, this.message = ''});

  static LoginResponseModel fromMap(String token, String refreshToken,
      {bool authorized = false}) {
    return LoginResponseModel(token: token, refreshToken: refreshToken);
  }
}
