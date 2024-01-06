import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/providers/posts_management/creation/post_creation_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';

/// Listener for the title text field
///
/// Updates the title in the post creation state

void titleTextControllerListener(
    {required TextEditingController controller, required WidgetRef ref}) {
  Future.delayed(Duration(milliseconds: 10), () {
    ref.read(postCreationAndUpdateProvider.notifier).setTitle(controller.text);
  });
}

/// Listener for the description text field
///
/// Updates the description in the post creation state

void descriptionTextControllerListener(
    {required TextEditingController controller, required WidgetRef ref}) {
  ref
      .read(postCreationAndUpdateProvider.notifier)
      .setDescription(controller.text);
  final UIStateNotifier uiNotifier = ref.read(uiStateProvider.notifier);
  if (controller.text.isNotEmpty) {
    uiNotifier.updateDescriptionButtonState(
        isDescriptionEmpty: false, showDescription: true, isFromListener: true);
  } else {
    uiNotifier.updateDescriptionButtonState(
        isDescriptionEmpty: true, showDescription: true, isFromListener: true);
  }
}
