import 'package:hippocamp/models/body/attachments_for_created_post.dart';
import 'package:hippocamp/models/body/created_post.dart';
import 'package:hippocamp/models/body/multi_party_transaction_for_created_post.dart';
import 'package:hippocamp/models/body/single_party_transaction_for_created_post.dart';
import 'package:hippocamp/models/repositories/ui_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to create/edit a post before creation, abstracting the logic from the widget

class PostCreationNotifier extends Notifier<NewCreatedPost> {
  @override
  build() {
    return NewCreatedPost();
  }

  void setImportant(bool value) {
    state = state.copyWith(important: value);
  }

  void setCanceled(bool value) {
    state = state.copyWith(canceled: value);
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
      List<SinglePartyTransactionForCreatedPost> value) {
    state = state.copyWith(singlePartyTransactions: value);
  }

  void setMultiPartyTransaction(MultiPartyTransactionForCreatedPost value) {
    state = state.copyWith(multiPartyTransaction: value);
  }

  void setAttachments(List<AttachmentForCreatedPost> value) {
    state = state.copyWith(attachments: value);
  }

  void setLocation({String? latitude, String? longitude, String? address}) {
    state = state.copyWith(
        latitude: latitude ?? '',
        longitude: longitude ?? '',
        address: address ?? '');
  }

  void reset() {
    state = NewCreatedPost();
  }
}

final postCreationProvider =
    NotifierProvider<PostCreationNotifier, NewCreatedPost>(
        () => PostCreationNotifier());
