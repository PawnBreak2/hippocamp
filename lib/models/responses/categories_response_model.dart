
import 'package:hippocamp/models/responses/posts_response_model.dart';

class Categories {
  final String key;
  final String iconUrl;
  final String localizedName;
  final int position;
  final String domainBackgroundColorHex;
  final String type;

  const Categories({
    required this.key,
    required this.iconUrl,
    required this.localizedName,
    required this.position,
    required this.domainBackgroundColorHex,
    required this.type,
  });

  static Categories fromMap(Map json) {
    return Categories(
      key: json["key"] ?? "",
      iconUrl: json["iconUrl"] ?? "",
      localizedName: json["localizedName"] ?? "",
      position: json["position"] ?? 0,
      domainBackgroundColorHex: json["domainBackgroundColorHex"] ?? "",
      type: json["type"] ?? "",
    );
  }

  static Categories fromCategoryModel(Category category) {
    return Categories(
      key: category.key,
      iconUrl: category.iconUrl,
      localizedName: category.nome,
      position: 0,
      domainBackgroundColorHex: category.domainBackgroundColorHex,
      type: category.key,
    );
  }
}
