import 'package:flutter/material.dart';
import 'package:hippocapp/constants/common.dart';
import 'package:hippocapp/helpers/extensions/datetime_extension.dart';
import 'package:hippocapp/models/posts-creation/attachment/attachment_for_post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/posts-creation/post/post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/posts-creation/transactions/multi_party_transaction_for_post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/posts-creation/transactions/single_party_transaction_for_post_to_be_sent_to_api.dart';
import 'package:hippocapp/models/repositories/ui_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';

/// Used to create/edit a post before creation, abstracting the logic from the widget

class PostCreationAndUpdateNotifier extends Notifier<PostToBeSentToAPI> {
  @override
  build() {
    return PostToBeSentToAPI(
      to: TimeOfDay.now().timeToString,
      from: TimeOfDay.now().timeToString,
      date: DateTime.now().dateToString,
    );
  }

  void setImportant(bool value) {
    state = state.copyWith(important: value);
  }

  void setUncertain(bool value) {
    state = state.copyWith(uncertain: value);
  }

  void setSensitiveInfo(bool value) {
    state = state.copyWith(sensitiveInfo: value);
  }

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  void setCategoryKey(String value) {
    state = state.copyWith(categoryKey: value);
  }

  void setBusinessPartners(List<String> value) {
    state = state.copyWith(businessPartners: value);
  }

  void setSinglePartyTransactions(
      List<SinglePartyTransactionForPostToBeSentToAPI> value) {
    state = state.copyWith(singlePartyTransactions: value);
  }

  void setMultiPartyTransaction(
      MultiPartyTransactionForPostToBeSentToAPI value) {
    state = state.copyWith(multiPartyTransaction: value);
  }

  void setAttachments(List<AttachmentForPostToBeSentToAPI> value) {
    state = state.copyWith(attachments: value);
  }

  void setLocation({double? latitude, double? longitude, String? address}) {
    state = state.copyWith(
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
        address: address ?? '');
  }

  void setVisualizationType(VisualizationType value) {
    state = state.copyWith(visualization: visualizationTypeMap[value]!);
  }

  void setAllDay(bool value) {
    state = state.copyWith(allDay: value);
  }

  void setTimeFrom(String value) {
    state = state.copyWith(from: value);
  }

  void setTimeTo(String value) {
    state = state.copyWith(to: value);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date.dateToString);
  }

  /// Resets the time from and time to to the current time
  ///
  /// Useful when there are errors in time picking
  void setFromAndToToNow() {
    state = state.copyWith(
      from: TimeOfDay.now().timeToString,
      to: TimeOfDay.now().timeToString,
    );
  }

  void resetAllPostAttributes() {
    state = state.copyWith(
      uncertain: false,
      important: false,
      sensitiveInfo: false,
      visualization: visualizationTypeMap[VisualizationType.spot]!,
    );
  }

  void initPostToBeSentToAPIFromExistingPost(Post post) {
    state = PostToBeSentToAPI.fromPost(post);
  }

  void reset() {
    state = const PostToBeSentToAPI();
  }
}

final postCreationAndUpdateProvider =
    NotifierProvider<PostCreationAndUpdateNotifier, PostToBeSentToAPI>(
        () => PostCreationAndUpdateNotifier());
