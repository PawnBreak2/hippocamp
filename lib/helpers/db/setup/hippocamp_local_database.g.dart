// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hippocamp_local_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AttachmentEntityDao? _attachmentEntityDaoInstance;

  CategoryEntityDao? _categoryEntityDaoInstance;

  PostEntityDao? _postEntityDaoInstance;

  PartnerEntityDao? _partnerEntityDaoInstance;

  SinglePartyTransactionPostEntityDao?
      _singlePartyTransactionPostEntityDaoInstance;

  MultiPartyTransactionEntityDao? _multiPartyTransactionEntityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `attachments` (`key` TEXT NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `icon_url` TEXT NOT NULL, `content_type` TEXT NOT NULL, `location` TEXT NOT NULL, `size_in_kb` INTEGER NOT NULL, PRIMARY KEY (`key`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `posts` (`key` TEXT NOT NULL, `domain_key` TEXT NOT NULL, `domain_background_color_hex` TEXT NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `icon_url` TEXT NOT NULL, PRIMARY KEY (`key`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `posts` (`key` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `attachment_count` INTEGER NOT NULL, `category_key` TEXT NOT NULL, `multi_party_transaction_key` TEXT, `latitude` REAL NOT NULL, `longitude` REAL NOT NULL, `address` TEXT NOT NULL, `important` INTEGER NOT NULL, `uncertain` INTEGER NOT NULL, `sensitive_info` INTEGER NOT NULL, `type` TEXT NOT NULL, `from` TEXT NOT NULL, `to` TEXT NOT NULL, `date` TEXT NOT NULL, `holiday` TEXT NOT NULL, `all_day` INTEGER NOT NULL, `business_partners_keys` TEXT NOT NULL, `single_party_transaction_keys` TEXT NOT NULL, `attachment_keys` TEXT NOT NULL, PRIMARY KEY (`key`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `business_partners` (`key` TEXT NOT NULL, `name` TEXT NOT NULL, `icon_url` TEXT NOT NULL, PRIMARY KEY (`key`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `single_party_transactions` (`key` TEXT PRIMARY KEY AUTOINCREMENT NOT NULL, `originating_post_key` TEXT NOT NULL, `amount` REAL NOT NULL, `currency_code` TEXT NOT NULL, `currency_symbol` TEXT NOT NULL, `date` TEXT NOT NULL, `type` TEXT NOT NULL, `wallet` TEXT NOT NULL, `wallet_name` TEXT NOT NULL, `wallet_type_icon_url` TEXT NOT NULL, `ordinary` INTEGER NOT NULL, `variable` INTEGER NOT NULL, `planned` INTEGER NOT NULL, `tax_relevant` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `multi_party_transactions` (`key` TEXT PRIMARY KEY AUTOINCREMENT NOT NULL, `originating_post_key` TEXT NOT NULL, `amount_in` REAL NOT NULL, `amount_out` REAL NOT NULL, `amount_in_currency_code` TEXT NOT NULL, `amount_in_currency_symbol` TEXT NOT NULL, `amount_out_currency_code` TEXT NOT NULL, `amount_out_currency_symbol` TEXT NOT NULL, `date` TEXT NOT NULL, `type` TEXT NOT NULL, `from_wallet` TEXT NOT NULL, `from_wallet_name` TEXT NOT NULL, `from_wallet_type_icon_url` TEXT NOT NULL, `to_wallet` TEXT NOT NULL, `to_wallet_name` TEXT NOT NULL, `to_wallet_type_icon_url` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AttachmentEntityDao get attachmentEntityDao {
    return _attachmentEntityDaoInstance ??=
        _$AttachmentEntityDao(database, changeListener);
  }

  @override
  CategoryEntityDao get categoryEntityDao {
    return _categoryEntityDaoInstance ??=
        _$CategoryEntityDao(database, changeListener);
  }

  @override
  PostEntityDao get postEntityDao {
    return _postEntityDaoInstance ??= _$PostEntityDao(database, changeListener);
  }

  @override
  PartnerEntityDao get partnerEntityDao {
    return _partnerEntityDaoInstance ??=
        _$PartnerEntityDao(database, changeListener);
  }

  @override
  SinglePartyTransactionPostEntityDao get singlePartyTransactionPostEntityDao {
    return _singlePartyTransactionPostEntityDaoInstance ??=
        _$SinglePartyTransactionPostEntityDao(database, changeListener);
  }

  @override
  MultiPartyTransactionEntityDao get multiPartyTransactionEntityDao {
    return _multiPartyTransactionEntityDaoInstance ??=
        _$MultiPartyTransactionEntityDao(database, changeListener);
  }
}

class _$AttachmentEntityDao extends AttachmentEntityDao {
  _$AttachmentEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _attachmentEntityUpdateAdapter = UpdateAdapter(
            database,
            'attachments',
            ['key'],
            (AttachmentEntity item) => <String, Object?>{
                  'key': item.key,
                  'name': item.name,
                  'type': item.type,
                  'icon_url': item.iconUrl,
                  'content_type': item.contentType,
                  'location': item.location,
                  'size_in_kb': item.sizeInKb
                }),
        _attachmentEntityDeletionAdapter = DeletionAdapter(
            database,
            'attachments',
            ['key'],
            (AttachmentEntity item) => <String, Object?>{
                  'key': item.key,
                  'name': item.name,
                  'type': item.type,
                  'icon_url': item.iconUrl,
                  'content_type': item.contentType,
                  'location': item.location,
                  'size_in_kb': item.sizeInKb
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<AttachmentEntity> _attachmentEntityUpdateAdapter;

  final DeletionAdapter<AttachmentEntity> _attachmentEntityDeletionAdapter;

  @override
  Future<AttachmentEntity?> getAttachmentByKey(String key) async {
    return _queryAdapter.query('SELECT * FROM attachments WHERE key = ?1',
        mapper: (Map<String, Object?> row) => AttachmentEntity(
            name: row['name'] as String,
            key: row['key'] as String,
            type: row['type'] as String,
            iconUrl: row['icon_url'] as String,
            contentType: row['content_type'] as String,
            location: row['location'] as String,
            sizeInKb: row['size_in_kb'] as int),
        arguments: [key]);
  }

  @override
  Future<List<AttachmentEntity>> getAllAttachments() async {
    return _queryAdapter.queryList('SELECT * FROM attachments',
        mapper: (Map<String, Object?> row) => AttachmentEntity(
            name: row['name'] as String,
            key: row['key'] as String,
            type: row['type'] as String,
            iconUrl: row['icon_url'] as String,
            contentType: row['content_type'] as String,
            location: row['location'] as String,
            sizeInKb: row['size_in_kb'] as int));
  }

  @override
  Future<void> updateAttachment(AttachmentEntity attachment) async {
    await _attachmentEntityUpdateAdapter.update(
        attachment, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAttachment(AttachmentEntity attachment) async {
    await _attachmentEntityDeletionAdapter.delete(attachment);
  }
}

class _$CategoryEntityDao extends CategoryEntityDao {
  _$CategoryEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'posts',
            ['key'],
            (CategoryEntity item) => <String, Object?>{
                  'key': item.key,
                  'domain_key': item.domainKey,
                  'domain_background_color_hex': item.domainBackgroundColorHex,
                  'name': item.name,
                  'type': item.type,
                  'icon_url': item.iconUrl
                }),
        _categoryEntityDeletionAdapter = DeletionAdapter(
            database,
            'posts',
            ['key'],
            (CategoryEntity item) => <String, Object?>{
                  'key': item.key,
                  'domain_key': item.domainKey,
                  'domain_background_color_hex': item.domainBackgroundColorHex,
                  'name': item.name,
                  'type': item.type,
                  'icon_url': item.iconUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<CategoryEntity> _categoryEntityUpdateAdapter;

  final DeletionAdapter<CategoryEntity> _categoryEntityDeletionAdapter;

  @override
  Future<CategoryEntity?> getCategoryByKey(String key) async {
    return _queryAdapter.query('SELECT * FROM categories WHERE key = ?1',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            key: row['key'] as String,
            domainKey: row['domain_key'] as String,
            domainBackgroundColorHex:
                row['domain_background_color_hex'] as String,
            name: row['name'] as String,
            type: row['type'] as String,
            iconUrl: row['icon_url'] as String),
        arguments: [key]);
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    return _queryAdapter.queryList('SELECT * FROM categories',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            key: row['key'] as String,
            domainKey: row['domain_key'] as String,
            domainBackgroundColorHex:
                row['domain_background_color_hex'] as String,
            name: row['name'] as String,
            type: row['type'] as String,
            iconUrl: row['icon_url'] as String));
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    await _categoryEntityUpdateAdapter.update(
        category, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCategory(CategoryEntity category) async {
    await _categoryEntityDeletionAdapter.delete(category);
  }
}

class _$PostEntityDao extends PostEntityDao {
  _$PostEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _postEntityInsertionAdapter = InsertionAdapter(
            database,
            'posts',
            (PostEntity item) => <String, Object?>{
                  'key': item.key,
                  'title': item.title,
                  'description': item.description,
                  'attachment_count': item.attachmentCount,
                  'category_key': item.categoryKey,
                  'multi_party_transaction_key': item.multiPartyTransactionKey,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'address': item.address,
                  'important': item.important ? 1 : 0,
                  'uncertain': item.uncertain ? 1 : 0,
                  'sensitive_info': item.sensitiveInfo ? 1 : 0,
                  'type': item.type,
                  'from': item.from,
                  'to': item.to,
                  'date': item.date,
                  'holiday': item.holiday,
                  'all_day': item.allDay ? 1 : 0,
                  'business_partners_keys': item.businessPartnersKeys,
                  'single_party_transaction_keys':
                      item.singlePartyTransactionKeys,
                  'attachment_keys': item.attachmentIds
                }),
        _postEntityUpdateAdapter = UpdateAdapter(
            database,
            'posts',
            ['key'],
            (PostEntity item) => <String, Object?>{
                  'key': item.key,
                  'title': item.title,
                  'description': item.description,
                  'attachment_count': item.attachmentCount,
                  'category_key': item.categoryKey,
                  'multi_party_transaction_key': item.multiPartyTransactionKey,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'address': item.address,
                  'important': item.important ? 1 : 0,
                  'uncertain': item.uncertain ? 1 : 0,
                  'sensitive_info': item.sensitiveInfo ? 1 : 0,
                  'type': item.type,
                  'from': item.from,
                  'to': item.to,
                  'date': item.date,
                  'holiday': item.holiday,
                  'all_day': item.allDay ? 1 : 0,
                  'business_partners_keys': item.businessPartnersKeys,
                  'single_party_transaction_keys':
                      item.singlePartyTransactionKeys,
                  'attachment_keys': item.attachmentIds
                }),
        _postEntityDeletionAdapter = DeletionAdapter(
            database,
            'posts',
            ['key'],
            (PostEntity item) => <String, Object?>{
                  'key': item.key,
                  'title': item.title,
                  'description': item.description,
                  'attachment_count': item.attachmentCount,
                  'category_key': item.categoryKey,
                  'multi_party_transaction_key': item.multiPartyTransactionKey,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'address': item.address,
                  'important': item.important ? 1 : 0,
                  'uncertain': item.uncertain ? 1 : 0,
                  'sensitive_info': item.sensitiveInfo ? 1 : 0,
                  'type': item.type,
                  'from': item.from,
                  'to': item.to,
                  'date': item.date,
                  'holiday': item.holiday,
                  'all_day': item.allDay ? 1 : 0,
                  'business_partners_keys': item.businessPartnersKeys,
                  'single_party_transaction_keys':
                      item.singlePartyTransactionKeys,
                  'attachment_keys': item.attachmentIds
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PostEntity> _postEntityInsertionAdapter;

  final UpdateAdapter<PostEntity> _postEntityUpdateAdapter;

  final DeletionAdapter<PostEntity> _postEntityDeletionAdapter;

  @override
  Future<List<PostEntity>> getAllPosts() async {
    return _queryAdapter.queryList('SELECT * FROM posts',
        mapper: (Map<String, Object?> row) => PostEntity(
            key: row['key'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            attachmentCount: row['attachment_count'] as int,
            categoryKey: row['category_key'] as String,
            multiPartyTransactionKey:
                row['multi_party_transaction_key'] as String?,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            address: row['address'] as String,
            important: (row['important'] as int) != 0,
            uncertain: (row['uncertain'] as int) != 0,
            sensitiveInfo: (row['sensitive_info'] as int) != 0,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            date: row['date'] as String,
            holiday: row['holiday'] as String,
            allDay: (row['all_day'] as int) != 0,
            businessPartnersKeys: row['business_partners_keys'] as String,
            singlePartyTransactionKeys:
                row['single_party_transaction_keys'] as String,
            attachmentIds: row['attachment_keys'] as String));
  }

  @override
  Future<List<PostEntity>> getPostsForMonth(String yearMonth) async {
    return _queryAdapter.queryList(
        'SELECT * FROM posts WHERE date LIKE ?1 || \"-%\"',
        mapper: (Map<String, Object?> row) => PostEntity(
            key: row['key'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            attachmentCount: row['attachment_count'] as int,
            categoryKey: row['category_key'] as String,
            multiPartyTransactionKey:
                row['multi_party_transaction_key'] as String?,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            address: row['address'] as String,
            important: (row['important'] as int) != 0,
            uncertain: (row['uncertain'] as int) != 0,
            sensitiveInfo: (row['sensitive_info'] as int) != 0,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            date: row['date'] as String,
            holiday: row['holiday'] as String,
            allDay: (row['all_day'] as int) != 0,
            businessPartnersKeys: row['business_partners_keys'] as String,
            singlePartyTransactionKeys:
                row['single_party_transaction_keys'] as String,
            attachmentIds: row['attachment_keys'] as String),
        arguments: [yearMonth]);
  }

  @override
  Future<PostEntity?> getPostById(String key) async {
    return _queryAdapter.query('SELECT * FROM posts WHERE key = ?1',
        mapper: (Map<String, Object?> row) => PostEntity(
            key: row['key'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            attachmentCount: row['attachment_count'] as int,
            categoryKey: row['category_key'] as String,
            multiPartyTransactionKey:
                row['multi_party_transaction_key'] as String?,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            address: row['address'] as String,
            important: (row['important'] as int) != 0,
            uncertain: (row['uncertain'] as int) != 0,
            sensitiveInfo: (row['sensitive_info'] as int) != 0,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            date: row['date'] as String,
            holiday: row['holiday'] as String,
            allDay: (row['all_day'] as int) != 0,
            businessPartnersKeys: row['business_partners_keys'] as String,
            singlePartyTransactionKeys:
                row['single_party_transaction_keys'] as String,
            attachmentIds: row['attachment_keys'] as String),
        arguments: [key]);
  }

  @override
  Future<List<PostEntity>> getPostsByCategory(String categoryKey) async {
    return _queryAdapter.queryList(
        'SELECT * FROM posts WHERE category_key = ?1',
        mapper: (Map<String, Object?> row) => PostEntity(
            key: row['key'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            attachmentCount: row['attachment_count'] as int,
            categoryKey: row['category_key'] as String,
            multiPartyTransactionKey:
                row['multi_party_transaction_key'] as String?,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            address: row['address'] as String,
            important: (row['important'] as int) != 0,
            uncertain: (row['uncertain'] as int) != 0,
            sensitiveInfo: (row['sensitive_info'] as int) != 0,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            date: row['date'] as String,
            holiday: row['holiday'] as String,
            allDay: (row['all_day'] as int) != 0,
            businessPartnersKeys: row['business_partners_keys'] as String,
            singlePartyTransactionKeys:
                row['single_party_transaction_keys'] as String,
            attachmentIds: row['attachment_keys'] as String),
        arguments: [categoryKey]);
  }

  @override
  Future<List<PostEntity>> getPostsByName(String searchString) async {
    return _queryAdapter.queryList(
        'SELECT * FROM posts WHERE title LIKE \"%\" || ?1 || \"%\"',
        mapper: (Map<String, Object?> row) => PostEntity(
            key: row['key'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            attachmentCount: row['attachment_count'] as int,
            categoryKey: row['category_key'] as String,
            multiPartyTransactionKey:
                row['multi_party_transaction_key'] as String?,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            address: row['address'] as String,
            important: (row['important'] as int) != 0,
            uncertain: (row['uncertain'] as int) != 0,
            sensitiveInfo: (row['sensitive_info'] as int) != 0,
            type: row['type'] as String,
            from: row['from'] as String,
            to: row['to'] as String,
            date: row['date'] as String,
            holiday: row['holiday'] as String,
            allDay: (row['all_day'] as int) != 0,
            businessPartnersKeys: row['business_partners_keys'] as String,
            singlePartyTransactionKeys:
                row['single_party_transaction_keys'] as String,
            attachmentIds: row['attachment_keys'] as String),
        arguments: [searchString]);
  }

  @override
  Future<void> insertPost(PostEntity post) async {
    await _postEntityInsertionAdapter.insert(post, OnConflictStrategy.ignore);
  }

  @override
  Future<void> insertMultiplePosts(List<PostEntity> posts) async {
    await _postEntityInsertionAdapter.insertList(
        posts, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updatePost(PostEntity post) async {
    await _postEntityUpdateAdapter.update(post, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    await _postEntityDeletionAdapter.delete(post);
  }
}

class _$PartnerEntityDao extends PartnerEntityDao {
  _$PartnerEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _businessPartnerEntityUpdateAdapter = UpdateAdapter(
            database,
            'business_partners',
            ['key'],
            (BusinessPartnerEntity item) => <String, Object?>{
                  'key': item.key,
                  'name': item.name,
                  'icon_url': item.iconUrl
                }),
        _businessPartnerEntityDeletionAdapter = DeletionAdapter(
            database,
            'business_partners',
            ['key'],
            (BusinessPartnerEntity item) => <String, Object?>{
                  'key': item.key,
                  'name': item.name,
                  'icon_url': item.iconUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<BusinessPartnerEntity>
      _businessPartnerEntityUpdateAdapter;

  final DeletionAdapter<BusinessPartnerEntity>
      _businessPartnerEntityDeletionAdapter;

  @override
  Future<BusinessPartnerEntity?> getPartnerByKey(String key) async {
    return _queryAdapter.query('SELECT * FROM partners WHERE key = ?1',
        mapper: (Map<String, Object?> row) => BusinessPartnerEntity(
            key: row['key'] as String,
            name: row['name'] as String,
            iconUrl: row['icon_url'] as String),
        arguments: [key]);
  }

  @override
  Future<List<BusinessPartnerEntity>> getAllPartners() async {
    return _queryAdapter.queryList('SELECT * FROM partners',
        mapper: (Map<String, Object?> row) => BusinessPartnerEntity(
            key: row['key'] as String,
            name: row['name'] as String,
            iconUrl: row['icon_url'] as String));
  }

  @override
  Future<void> updatePartner(BusinessPartnerEntity partner) async {
    await _businessPartnerEntityUpdateAdapter.update(
        partner, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePartner(BusinessPartnerEntity partner) async {
    await _businessPartnerEntityDeletionAdapter.delete(partner);
  }
}

class _$SinglePartyTransactionPostEntityDao
    extends SinglePartyTransactionPostEntityDao {
  _$SinglePartyTransactionPostEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _singlePartyTransactionPostEntityUpdateAdapter = UpdateAdapter(
            database,
            'single_party_transactions',
            ['key'],
            (SinglePartyTransactionPostEntity item) => <String, Object?>{
                  'key': item.key,
                  'originating_post_key': item.originatingPostKey,
                  'amount': item.amount,
                  'currency_code': item.currencyCode,
                  'currency_symbol': item.currencySymbol,
                  'date': item.date,
                  'type': item.type,
                  'wallet': item.wallet,
                  'wallet_name': item.walletName,
                  'wallet_type_icon_url': item.walletTypeIconUrl,
                  'ordinary': item.ordinary ? 1 : 0,
                  'variable': item.variable ? 1 : 0,
                  'planned': item.planned ? 1 : 0,
                  'tax_relevant': item.taxRelevant ? 1 : 0
                }),
        _singlePartyTransactionPostEntityDeletionAdapter = DeletionAdapter(
            database,
            'single_party_transactions',
            ['key'],
            (SinglePartyTransactionPostEntity item) => <String, Object?>{
                  'key': item.key,
                  'originating_post_key': item.originatingPostKey,
                  'amount': item.amount,
                  'currency_code': item.currencyCode,
                  'currency_symbol': item.currencySymbol,
                  'date': item.date,
                  'type': item.type,
                  'wallet': item.wallet,
                  'wallet_name': item.walletName,
                  'wallet_type_icon_url': item.walletTypeIconUrl,
                  'ordinary': item.ordinary ? 1 : 0,
                  'variable': item.variable ? 1 : 0,
                  'planned': item.planned ? 1 : 0,
                  'tax_relevant': item.taxRelevant ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<SinglePartyTransactionPostEntity>
      _singlePartyTransactionPostEntityUpdateAdapter;

  final DeletionAdapter<SinglePartyTransactionPostEntity>
      _singlePartyTransactionPostEntityDeletionAdapter;

  @override
  Future<List<SinglePartyTransactionPostEntity>> getTransactionPostsByPostKey(
      String originatingPostKey) async {
    return _queryAdapter.queryList(
        'SELECT * FROM single_party_transaction_posts WHERE originating_post_key = ?1',
        mapper: (Map<String, Object?> row) => SinglePartyTransactionPostEntity(key: row['key'] as String, amount: row['amount'] as double, currencyCode: row['currency_code'] as String, currencySymbol: row['currency_symbol'] as String, date: row['date'] as String, originatingPostKey: row['originating_post_key'] as String, type: row['type'] as String, wallet: row['wallet'] as String, walletName: row['wallet_name'] as String, walletTypeIconUrl: row['wallet_type_icon_url'] as String, ordinary: (row['ordinary'] as int) != 0, variable: (row['variable'] as int) != 0, planned: (row['planned'] as int) != 0, taxRelevant: (row['tax_relevant'] as int) != 0),
        arguments: [originatingPostKey]);
  }

  @override
  Future<List<SinglePartyTransactionPostEntity>>
      getAllTransactionPosts() async {
    return _queryAdapter.queryList(
        'SELECT * FROM single_party_transaction_posts',
        mapper: (Map<String, Object?> row) => SinglePartyTransactionPostEntity(
            key: row['key'] as String,
            amount: row['amount'] as double,
            currencyCode: row['currency_code'] as String,
            currencySymbol: row['currency_symbol'] as String,
            date: row['date'] as String,
            originatingPostKey: row['originating_post_key'] as String,
            type: row['type'] as String,
            wallet: row['wallet'] as String,
            walletName: row['wallet_name'] as String,
            walletTypeIconUrl: row['wallet_type_icon_url'] as String,
            ordinary: (row['ordinary'] as int) != 0,
            variable: (row['variable'] as int) != 0,
            planned: (row['planned'] as int) != 0,
            taxRelevant: (row['tax_relevant'] as int) != 0));
  }

  @override
  Future<void> updateTransactionPost(
      SinglePartyTransactionPostEntity transactionPost) async {
    await _singlePartyTransactionPostEntityUpdateAdapter.update(
        transactionPost, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTransactionPost(
      SinglePartyTransactionPostEntity transactionPost) async {
    await _singlePartyTransactionPostEntityDeletionAdapter
        .delete(transactionPost);
  }
}

class _$MultiPartyTransactionEntityDao extends MultiPartyTransactionEntityDao {
  _$MultiPartyTransactionEntityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _multiPartyTransactionEntityUpdateAdapter = UpdateAdapter(
            database,
            'multi_party_transactions',
            ['key'],
            (MultiPartyTransactionEntity item) => <String, Object?>{
                  'key': item.key,
                  'originating_post_key': item.originatingPostKey,
                  'amount_in': item.amountIn,
                  'amount_out': item.amountOut,
                  'amount_in_currency_code': item.amountInCurrencyCode,
                  'amount_in_currency_symbol': item.amountInCurrencySymbol,
                  'amount_out_currency_code': item.amountOutCurrencyCode,
                  'amount_out_currency_symbol': item.amountOutCurrencySymbol,
                  'date': item.date,
                  'type': item.type,
                  'from_wallet': item.fromWallet,
                  'from_wallet_name': item.fromWalletName,
                  'from_wallet_type_icon_url': item.fromWalletTypeIconUrl,
                  'to_wallet': item.toWallet,
                  'to_wallet_name': item.toWalletName,
                  'to_wallet_type_icon_url': item.toWalletTypeIconUrl
                }),
        _multiPartyTransactionEntityDeletionAdapter = DeletionAdapter(
            database,
            'multi_party_transactions',
            ['key'],
            (MultiPartyTransactionEntity item) => <String, Object?>{
                  'key': item.key,
                  'originating_post_key': item.originatingPostKey,
                  'amount_in': item.amountIn,
                  'amount_out': item.amountOut,
                  'amount_in_currency_code': item.amountInCurrencyCode,
                  'amount_in_currency_symbol': item.amountInCurrencySymbol,
                  'amount_out_currency_code': item.amountOutCurrencyCode,
                  'amount_out_currency_symbol': item.amountOutCurrencySymbol,
                  'date': item.date,
                  'type': item.type,
                  'from_wallet': item.fromWallet,
                  'from_wallet_name': item.fromWalletName,
                  'from_wallet_type_icon_url': item.fromWalletTypeIconUrl,
                  'to_wallet': item.toWallet,
                  'to_wallet_name': item.toWalletName,
                  'to_wallet_type_icon_url': item.toWalletTypeIconUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<MultiPartyTransactionEntity>
      _multiPartyTransactionEntityUpdateAdapter;

  final DeletionAdapter<MultiPartyTransactionEntity>
      _multiPartyTransactionEntityDeletionAdapter;

  @override
  Future<MultiPartyTransactionEntity?> getTransactionByKey(String key) async {
    return _queryAdapter.query(
        'SELECT * FROM multi_party_transactions WHERE key = ?1',
        mapper: (Map<String, Object?> row) => MultiPartyTransactionEntity(
            key: row['key'] as String,
            originatingPostKey: row['originating_post_key'] as String,
            amountIn: row['amount_in'] as double,
            amountOut: row['amount_out'] as double,
            amountInCurrencyCode: row['amount_in_currency_code'] as String,
            amountInCurrencySymbol: row['amount_in_currency_symbol'] as String,
            amountOutCurrencyCode: row['amount_out_currency_code'] as String,
            amountOutCurrencySymbol:
                row['amount_out_currency_symbol'] as String,
            date: row['date'] as String,
            type: row['type'] as String,
            fromWallet: row['from_wallet'] as String,
            fromWalletName: row['from_wallet_name'] as String,
            fromWalletTypeIconUrl: row['from_wallet_type_icon_url'] as String,
            toWallet: row['to_wallet'] as String,
            toWalletName: row['to_wallet_name'] as String,
            toWalletTypeIconUrl: row['to_wallet_type_icon_url'] as String),
        arguments: [key]);
  }

  @override
  Future<List<MultiPartyTransactionEntity>> getAllTransactions() async {
    return _queryAdapter.queryList('SELECT * FROM multi_party_transactions',
        mapper: (Map<String, Object?> row) => MultiPartyTransactionEntity(
            key: row['key'] as String,
            originatingPostKey: row['originating_post_key'] as String,
            amountIn: row['amount_in'] as double,
            amountOut: row['amount_out'] as double,
            amountInCurrencyCode: row['amount_in_currency_code'] as String,
            amountInCurrencySymbol: row['amount_in_currency_symbol'] as String,
            amountOutCurrencyCode: row['amount_out_currency_code'] as String,
            amountOutCurrencySymbol:
                row['amount_out_currency_symbol'] as String,
            date: row['date'] as String,
            type: row['type'] as String,
            fromWallet: row['from_wallet'] as String,
            fromWalletName: row['from_wallet_name'] as String,
            fromWalletTypeIconUrl: row['from_wallet_type_icon_url'] as String,
            toWallet: row['to_wallet'] as String,
            toWalletName: row['to_wallet_name'] as String,
            toWalletTypeIconUrl: row['to_wallet_type_icon_url'] as String));
  }

  @override
  Future<List<MultiPartyTransactionEntity>> getTransactionsByPostKey(
      String originatingPostKey) async {
    return _queryAdapter.queryList(
        'SELECT * FROM multi_party_transactions WHERE originating_post_key = ?1',
        mapper: (Map<String, Object?> row) => MultiPartyTransactionEntity(key: row['key'] as String, originatingPostKey: row['originating_post_key'] as String, amountIn: row['amount_in'] as double, amountOut: row['amount_out'] as double, amountInCurrencyCode: row['amount_in_currency_code'] as String, amountInCurrencySymbol: row['amount_in_currency_symbol'] as String, amountOutCurrencyCode: row['amount_out_currency_code'] as String, amountOutCurrencySymbol: row['amount_out_currency_symbol'] as String, date: row['date'] as String, type: row['type'] as String, fromWallet: row['from_wallet'] as String, fromWalletName: row['from_wallet_name'] as String, fromWalletTypeIconUrl: row['from_wallet_type_icon_url'] as String, toWallet: row['to_wallet'] as String, toWalletName: row['to_wallet_name'] as String, toWalletTypeIconUrl: row['to_wallet_type_icon_url'] as String),
        arguments: [originatingPostKey]);
  }

  @override
  Future<void> updateTransaction(
      MultiPartyTransactionEntity transaction) async {
    await _multiPartyTransactionEntityUpdateAdapter.update(
        transaction, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTransaction(
      MultiPartyTransactionEntity transaction) async {
    await _multiPartyTransactionEntityDeletionAdapter.delete(transaction);
  }
}
