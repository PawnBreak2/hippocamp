import 'package:hippocapp/models/responses/posts/partner.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';

class BusinessPartner {
  final String key;
  final String name;
  final String iconUrl;
  final bool installed;

  const BusinessPartner({
    required this.key,
    required this.name,
    required this.iconUrl,
    required this.installed,
  });

  static BusinessPartner fromMap(Map map) {
    return BusinessPartner(
      key: map["key"] ?? "",
      name: map["name"] ?? "",
      iconUrl: map["iconUrl"] ?? "",
      installed: map["installed"] ?? false,
    );
  }
}
