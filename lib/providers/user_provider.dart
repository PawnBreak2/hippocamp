import 'package:hippocapp/clients/user_client.dart';
import 'package:hippocapp/models/responses/profile_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends Notifier<UserProfileModel> {
  @override
  build() {
    return UserProfileModel.emptyUser();
  }

  final UserClient _userClient = UserClient();

  Future<void> setUserProfile() async {
    final resp = await _userClient.getProfile();

    resp.fold(
      (l) => null,
      (r) {
        state = r;
      },
    );
  }

  void clearAllData() {
    //goes back to initializing an empty repository

    state = UserProfileModel.emptyUser();
  }
}

final userNotifierProvider =
    NotifierProvider<UserNotifier, UserProfileModel>(() {
  return UserNotifier();
});
