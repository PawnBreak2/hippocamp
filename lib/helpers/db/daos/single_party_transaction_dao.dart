import 'package:floor/floor.dart';

import 'package:floor/floor.dart';
import 'package:hippocapp/helpers/db/entities/single_party_transaction.dart';

@dao
abstract class SinglePartyTransactionPostEntityDao {
  // Retrieve all transaction posts for a given originating post key
  @Query(
      'SELECT * FROM single_party_transaction_posts WHERE originating_post_key = :originatingPostKey')
  Future<List<SinglePartyTransactionPostEntity>> getTransactionPostsByPostKey(
      String originatingPostKey);

  // Retrieve all transaction posts
  @Query('SELECT * FROM single_party_transaction_posts')
  Future<List<SinglePartyTransactionPostEntity>> getAllTransactionPosts();

  // Update a transaction post
  @update
  Future<void> updateTransactionPost(
      SinglePartyTransactionPostEntity transactionPost);

  // Delete a transaction post
  @delete
  Future<void> deleteTransactionPost(
      SinglePartyTransactionPostEntity transactionPost);
}
