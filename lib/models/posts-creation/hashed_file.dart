import 'dart:io';

/// This is used to avoid duplicates when adding attachments to a post.
///
/// E.g. if the user selects the same image or file twice, we don't want to add it twice.
class HashedFile {
  final File file;
  final String hash;

  HashedFile({required this.file, required this.hash});
}
