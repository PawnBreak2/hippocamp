import 'package:floor/floor.dart';
import 'package:hippocamp/constants/db/table_names.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';

@Entity(tableName: TableNamesForDb.attachments)
class AttachmentEntity {
  @primaryKey
  final String key;
  final String name;
  final String type;
  @ColumnInfo(name: 'icon_url')
  final String iconUrl;
  @ColumnInfo(name: 'content_type')
  final String contentType;
  final String location;
  @ColumnInfo(name: 'size_in_kb')
  final int sizeInKb;

  AttachmentEntity({
    required this.name,
    required this.key,
    required this.type,
    required this.iconUrl,
    required this.contentType,
    required this.location,
    required this.sizeInKb,
  });

  factory AttachmentEntity.fromAttachment(Attachment attachment) {
    return AttachmentEntity(
      name: attachment.name,
      key: attachment.key,
      type: attachment.type,
      iconUrl: attachment.iconUrl,
      contentType: attachment.contentType,
      location: attachment.location,
      sizeInKb: attachment.sizeInKb,
    );
  }
}
