import 'package:floor/floor.dart';
import 'package:hippocamp/helpers/db/entities/partner.dart';

@dao
abstract class PartnerEntityDao {
  // Retrieve a partner by key
  @Query('SELECT * FROM partners WHERE key = :key')
  Future<BusinessPartnerEntity?> getPartnerByKey(String key);

  // Retrieve all partners
  @Query('SELECT * FROM partners')
  Future<List<BusinessPartnerEntity>> getAllPartners();

  // Update a partner
  @update
  Future<void> updatePartner(BusinessPartnerEntity partner);

  // Delete a partner
  @delete
  Future<void> deletePartner(BusinessPartnerEntity partner);
}
