import 'package:floor/floor.dart';

import 'package:floor/floor.dart';
import 'package:hippocamp/helpers/db/entities/multi_party_transaction.dart';

@dao
abstract class MultiPartyTransactionEntityDao {
  // Retrieve a transaction by key
  @Query('SELECT * FROM multi_party_transactions WHERE key = :key')
  Future<MultiPartyTransactionEntity?> getTransactionByKey(String key);

  // Retrieve all transactions
  @Query('SELECT * FROM multi_party_transactions')
  Future<List<MultiPartyTransactionEntity>> getAllTransactions();

  // Update a transaction
  @update
  Future<void> updateTransaction(MultiPartyTransactionEntity transaction);

  // Delete a transaction
  @delete
  Future<void> deleteTransaction(MultiPartyTransactionEntity transaction);

  // Retrieve all transactions for a given originating post key
  @Query(
      'SELECT * FROM multi_party_transactions WHERE originating_post_key = :originatingPostKey')
  Future<List<MultiPartyTransactionEntity>> getTransactionsByPostKey(
      String originatingPostKey);
}
