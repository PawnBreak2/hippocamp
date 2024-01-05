import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/helpers/utilities.dart';
import 'package:hippocapp/models/posts-creation/hashed_file.dart';
import 'package:hippocapp/models/posts-creation/hashed_image.dart';
import 'package:hippocapp/models/repositories/attachments_repository.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentsNotifier extends Notifier<AttachmentsState> {
  @override
  AttachmentsState build() {
    return const AttachmentsState();
  }

  final ImagePicker _imagePicker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;

  Future<void> pickImageFromGallery() async {
    final imagesList = await _imagePicker.pickMultiImage(
        maxHeight: 800, maxWidth: 800, imageQuality: 50);

    // Assign unique hash and check for duplicates

    if (imagesList != null) {
      for (var image in imagesList) {
        String hash = await Utilities.getFileContentHash(image.path);
        bool isDuplicate =
            state.images.any((existingImage) => existingImage.hash == hash);

        if (!isDuplicate) {
          // Add the HashedImage to the state
          state = state.copyWith(
              images: [...state.images, HashedImage(file: image, hash: hash)]);
        } else {
          print("Duplicate image");
        }
      }
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      String hash = await Utilities.getFileContentHash(image.path);
      state = state.copyWith(
          images: [...state.images, HashedImage(file: image, hash: hash)]);
    }
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await _filePicker
        .pickFiles(allowMultiple: true, allowedExtensions: ['pdf']);
    if (result != null) {
      List<File> filesList = result.paths.map((path) => File(path!)).toList();

      // Assign unique hash and check for duplicates

      for (var file in filesList) {
        String hash = await Utilities.getFileContentHash(file.path);
        bool isDuplicate =
            state.files.any((existingFile) => existingFile.hash == hash);

        if (!isDuplicate) {
          // Add the HashedFile to the state
          state = state.copyWith(
              files: [...state.files, HashedFile(file: file, hash: hash)]);
        } else {
          print("Duplicate file");
        }
      }
    }
  }

  void clearAllData() {
    //goes back to initializing an empty repository

    state = const AttachmentsState();
  }

  void clearAllImages() {
    state = state.copyWith(images: []);
  }

  void clearAllFiles() {
    state = state.copyWith(files: []);
  }

  void removeImage(int index) {
    state = state.copyWith(images: state.images..removeAt(index));
  }

  void removeFile(int index) {
    state = state.copyWith(files: state.files..removeAt(index));
  }
}

final attachmentsProvider =
    NotifierProvider<AttachmentsNotifier, AttachmentsState>(
        () => AttachmentsNotifier());
