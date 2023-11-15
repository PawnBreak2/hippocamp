import 'package:hippocamp/constants/common.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;

  // Call this method to get the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Lazily instantiate the db the first time it is accessed.
    _database = await _initDatabase();
    return _database!;
  }

  // This opens the database (and creates it if it doesn't exist).
  _initDatabase() async {
    String path = join(await getDatabasesPath(), Constants.databaseName);
    return await openDatabase(path,
        version: Constants.databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database and the table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Post (
    title TEXT,
    key TEXT PRIMARY KEY,
    description TEXT,
    attachmentCount INTEGER,
    categoryKey TEXT,
    multiPartyTransactionKey TEXT,
    latitude TEXT,
    longitude TEXT,
    address TEXT,
    important INTEGER,  -- SQLite does not have a boolean type, so we use INTEGER (0 for false, 1 for true)
    canceled INTEGER,
    uncertain INTEGER,
    sensitiveInfo INTEGER,
    type TEXT,
    rating TEXT,
    fromTime TEXT,
    toTime TEXT,
    interval TEXT,
    date TEXT,
    holiday TEXT,
    at TEXT,
    within TEXT,
    notificationsUnit TEXT,
    morning INTEGER,
    afternoon INTEGER,
    evening INTEGER,
    wholeDay INTEGER,
    notificationsActive INTEGER,
    stories TEXT,  
    FOREIGN KEY(categoryKey) REFERENCES Category(key),
    FOREIGN KEY(multiPartyTransactionKey) REFERENCES MultiPartyTransaction(key)
    FOREIGN KEY(SinglePartyTransactionKey) REFERENCES SinglePartyTransaction(key)

    -- Add more foreign keys if needed for other relationships
);

CREATE TABLE Category (
    key TEXT PRIMARY KEY,
    domainKey TEXT,
    domainBackgroundColorHex TEXT,
    name TEXT,
    type TEXT,
    iconUrl TEXT
);
CREATE TABLE MultiPartyTransaction (
    key TEXT PRIMARY KEY,
    amountIn REAL,
    amountOut REAL,
    amountInCurrencyCode TEXT,
    amountInCurrencySymbol TEXT,
    amountOutCurrencyCode TEXT,
    amountOutCurrencySymbol TEXT,
    date TEXT,
    type TEXT,
    fromWallet TEXT,
    fromWalletName TEXT,
    fromWalletTypeIconUrl TEXT,
    toWallet TEXT,
    toWalletName TEXT,
    toWalletTypeIconUrl TEXT
    FOREIGN KEY(postKey) REFERENCES Post(key)  

);

CREATE TABLE Partner (
    key TEXT PRIMARY KEY,
    name TEXT,
    iconUrl TEXT
);

CREATE TABLE SinglePartyTransaction (
    amount REAL,
    currencyCode TEXT,
    currencySymbol TEXT,
    date TEXT,
    type TEXT,
    wallet TEXT,
    walletName TEXT,
    walletTypeIconUrl TEXT,
    ordinary INTEGER,
    variable INTEGER,
    planned INTEGER,
    taxRelevant INTEGER,
    postKey TEXT,
    FOREIGN KEY(postKey) REFERENCES Post(key)  
);
    CREATE TABLE Attachment (
    name TEXT,
    key TEXT PRIMARY KEY,
    type TEXT,
    iconUrl TEXT,
    contentType TEXT,
    location TEXT,
    sizeInKb INTEGER,
    postKey TEXT,
    FOREIGN KEY(postKey) REFERENCES Post(key)  -- Assuming a relationship with the Post table
);

          ''');
  }
}
