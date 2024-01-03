import 'package:hippocapp/models/responses/posts_response_model.dart';

class PartnerModel {
  final String key;
  final String name;
  final String iconUrl;
  final bool assigned;

  const PartnerModel({
    required this.key,
    required this.name,
    required this.iconUrl,
    required this.assigned,
  });

  static PartnerModel fromMap(Map map) {
    return PartnerModel(
      key: map["key"] ?? "",
      name: map["name"] ?? "",
      iconUrl: map["iconUrl"] ?? "",
      assigned: map["assigned"] ?? false,
    );
  }

  static PartnerModel fromPostPartner(Partner partner) {
    return PartnerModel(
      key: partner.key,
      name: partner.name,
      iconUrl: partner.iconUrl,
      assigned: true,
    );
  }
}
