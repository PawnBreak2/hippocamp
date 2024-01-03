import 'package:hippocapp/models/posts-creation/attachment_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'profile_response_model.freezed.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String invitationCode,
    required String countryCode,
    required List<String> languages,
  }) = _UserProfileModel;

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      invitationCode: map['invitationCode'] as String? ?? '',
      countryCode: map['countryCode'] as String? ?? '',
      languages: (map['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  factory UserProfileModel.emptyUser() => const UserProfileModel(
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        invitationCode: '',
        countryCode: '',
        languages: [],
      );
}
