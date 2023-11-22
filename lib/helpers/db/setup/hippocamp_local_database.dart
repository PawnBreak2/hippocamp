import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hippocamp/helpers/db/daos/attachment_dao.dart';
import 'package:hippocamp/helpers/db/daos/category_dao.dart';
import 'package:hippocamp/helpers/db/daos/multi_party_transaction_dao.dart';
import 'package:hippocamp/helpers/db/daos/partner_dao.dart';
import 'package:hippocamp/helpers/db/daos/post_dao.dart';
import 'package:hippocamp/helpers/db/daos/single_party_transaction_dao.dart';
import 'package:hippocamp/helpers/db/entities/attachment.dart';
import 'package:hippocamp/helpers/db/entities/category.dart';
import 'package:hippocamp/helpers/db/entities/multi_party_transaction.dart';
import 'package:hippocamp/helpers/db/entities/partner.dart';
import 'package:hippocamp/helpers/db/entities/post.dart';
import 'package:hippocamp/helpers/db/entities/single_party_transaction.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'hippocamp_local_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  AttachmentEntity,
  CategoryEntity,
  PostEntity,
  BusinessPartnerEntity,
  SinglePartyTransactionPostEntity,
  MultiPartyTransactionEntity
])
abstract class AppDatabase extends FloorDatabase {
  AttachmentEntityDao get attachmentEntityDao;
  CategoryEntityDao get categoryEntityDao;
  PostEntityDao get postEntityDao;
  PartnerEntityDao get partnerEntityDao;
  SinglePartyTransactionPostEntityDao get singlePartyTransactionPostEntityDao;
  MultiPartyTransactionEntityDao get multiPartyTransactionEntityDao;
}
