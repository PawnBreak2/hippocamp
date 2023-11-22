class PostCategory {
  final String key;
  final String iconUrl;
  final String localizedName;
  final int position;
  final String domainBackgroundColorHex;
  final String type;
  final String domainKey;

  const PostCategory({
    required this.domainKey,
    required this.key,
    required this.iconUrl,
    required this.localizedName,
    required this.position,
    required this.domainBackgroundColorHex,
    required this.type,
  });

  static PostCategory fromMap(Map json) {
    return PostCategory(
      domainKey: json["domainKey"] ?? "",
      key: json["key"] ?? "",
      iconUrl: json["iconUrl"] ?? "",
      localizedName: json["localizedName"] ?? "",
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
      localizedName: category.localizedName,
      position: 0,
      domainBackgroundColorHex: category.domainBackgroundColorHex,
      type: category.key,
    );
  }
}
