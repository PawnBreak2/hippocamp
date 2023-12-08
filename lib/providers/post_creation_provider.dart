import 'package:hippocamp/models/body/created_post.dart';
import 'package:hippocamp/models/repositories/ui_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to create/edit a post before creation, abstracting the logic from the widget

class CreatePostNotifier extends Notifier<NewCreatedPost> {
  @override
  build() {
    return NewCreatedPost();
  }

  void reset() {
    state = NewCreatedPost();
  }
}

final createPostProvider = NotifierProvider<CreatePostNotifier, NewCreatedPost>(
    () => CreatePostNotifier());
