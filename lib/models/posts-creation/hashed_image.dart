import 'package:image_picker/image_picker.dart';

/// This is used to avoid duplicates when adding attachments to a post.
///
/// E.g. if the user selects the same image or file twice, we don't want to add it twice.
///
class HashedImage {
  final XFile file;
  final String hash;

  HashedImage({required this.file, required this.hash});
}
