import 'package:floor/floor.dart';
import 'package:hippocamp/constants/db/table_names.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';

@Entity(tableName: TableNamesForDb.categories)
class CategoryEntity {
  @primaryKey
  final String key;
  @ColumnInfo(name: 'domain_key')
  final String domainKey;
  @ColumnInfo(name: 'domain_background_color_hex')
  final String domainBackgroundColorHex;
  final String name;
  final String type;
  @ColumnInfo(name: 'icon_url')
  final String iconUrl;

  CategoryEntity({
    required this.key,
    required this.domainKey,
    required this.domainBackgroundColorHex,
    required this.name,
    required this.type,
    required this.iconUrl,
  });

  factory CategoryEntity.fromCategory(PostCategory category) {
    return CategoryEntity(
      key: category.key,
      domainKey: category.domainKey,
      domainBackgroundColorHex: category.domainBackgroundColorHex,
      name: category.name,
      type: category.type,
      iconUrl: category.iconUrl,
    );
  }
}
