import 'package:floor/floor.dart';
import 'package:hippocamp/constants/db/table_names.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';

@Entity(tableName: TableNamesForDb.categories)
class CategoryEntity {
  @primaryKey
  final String key;
  @ColumnInfo(name: 'domain_key')
  final String domainKey;
  @ColumnInfo(name: 'domain_background_color_hex')
  final String domainBackgroundColorHex;
  final String nome;
  final String type;
  @ColumnInfo(name: 'icon_url')
  final String iconUrl;

  CategoryEntity({
    required this.key,
    required this.domainKey,
    required this.domainBackgroundColorHex,
    required this.nome,
    required this.type,
    required this.iconUrl,
  });

  factory CategoryEntity.fromCategory(Category category) {
    return CategoryEntity(
      key: category.key,
      domainKey: category.domainKey,
      domainBackgroundColorHex: category.domainBackgroundColorHex,
      nome: category.nome,
      type: category.type,
      iconUrl: category.iconUrl,
    );
  }
}
