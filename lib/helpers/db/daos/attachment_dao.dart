import 'package:floor/floor.dart';
import 'package:hippocamp/helpers/db/entities/attachment.dart';

@dao
abstract class AttachmentEntityDao {
  // Retrieve an attachment by key
  @Query('SELECT * FROM attachments WHERE key = :key')
  Future<AttachmentEntity?> getAttachmentByKey(String key);

  // Retrieve all attachments
  @Query('SELECT * FROM attachments')
  Future<List<AttachmentEntity>> getAllAttachments();

  // Update an attachment
  @update
  Future<void> updateAttachment(AttachmentEntity attachment);

  // Delete an attachment
  @delete
  Future<void> deleteAttachment(AttachmentEntity attachment);
}
