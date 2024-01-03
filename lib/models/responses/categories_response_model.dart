class PostCategory {
  final String key;
  final String iconUrl;
  final String name;
  final int position;
  final String domainBackgroundColorHex;
  final String type;
  final String domainKey;

  ///TODO: aggiornare modello

  const PostCategory({
    required this.domainKey,
    required this.key,
    required this.iconUrl,
    required this.name,
    required this.position,
    required this.domainBackgroundColorHex,
    required this.type,
  });

  static PostCategory fromMap(Map json) {
    return PostCategory(
      domainKey: json["domainKey"] ?? "",
      key: json["key"] ?? "",
      iconUrl: json["iconUrl"] ?? "",
      name: json["name"] ?? "",
      position: json["position"] ?? 0,
      domainBackgroundColorHex: json["domainBackgroundColorHex"] ?? "",
      type: json["type"] ?? "",
    );
  }

  static PostCategory fromCategoryModel(PostCategory category) {
    return PostCategory(
      domainKey: category.domainKey,
      key: category.key,
      iconUrl: category.iconUrl,
      name: category.name,
      position: 0,
      domainBackgroundColorHex: category.domainBackgroundColorHex,
      type: category.key,
    );
  }
}
