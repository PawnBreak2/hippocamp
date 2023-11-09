import 'package:hippocamp/clients/appstate_client.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/models/repositories/app_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStateNotifier extends Notifier<AppState> {
  @override
  build() {
    return AppState();
  }

  final _appStateClient = AppStateClient();

  Future<List<AttachmentType>> getAttachmentTypes() async {
    List<AttachmentType> attachments = [];
    final resp = await _appStateClient.getAttachmentTypes();

    resp.fold(
      (l) => null,
      (r) {
        attachments.clear();
        attachments.addAll(r);
      },
    );
    return attachments;
  }

  void clearAllData() {
    //goes back to initializing an empty repository

    state = AppState();
  }
}

final appStateProvider =
    NotifierProvider<AppStateNotifier, AppState>(() => AppStateNotifier());
