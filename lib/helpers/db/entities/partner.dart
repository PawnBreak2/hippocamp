import 'package:floor/floor.dart';
import 'package:hippocapp/constants/db/table_names.dart';
import 'package:hippocapp/models/responses/posts/partner.dart';
import 'package:hippocapp/models/responses/posts/post_response_model.dart';

@Entity(tableName: TableNamesForDb.businessPartners)
class BusinessPartnerEntity {
  @primaryKey
  final String key;
  final String name;
  @ColumnInfo(name: 'icon_url')
  final String iconUrl;

  BusinessPartnerEntity({
    required this.key,
    required this.name,
    required this.iconUrl,
  });

  factory BusinessPartnerEntity.fromPartner(Partner partner) {
    return BusinessPartnerEntity(
      key: partner.key,
      name: partner.name,
      iconUrl: partner.iconUrl,
    );
  }
}
