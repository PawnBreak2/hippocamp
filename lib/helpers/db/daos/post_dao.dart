import 'package:floor/floor.dart';
import 'package:hippocapp/helpers/db/entities/post.dart';

@dao
abstract class PostEntityDao {
  // 1) Add a post
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertPost(PostEntity post);

  // 1.1) Add a list of posts
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertMultiplePosts(List<PostEntity> posts);

  // 2) Update a post by key
  @update
  Future<void> updatePost(PostEntity post);

  // 3) Delete a post
  @delete
  Future<void> deletePost(PostEntity post);

  // 4) Get all posts
  @Query('SELECT * FROM posts')
  Future<List<PostEntity>> getAllPosts();

  // 5) Get posts for a given month
  // Assuming 'date' is stored in a 'YYYY-MM-DD' format
  @Query('SELECT * FROM posts WHERE date LIKE :yearMonth || "-%"')
  Future<List<PostEntity>> getPostsForMonth(
      String yearMonth); // yearMonth should be 'YYYY-MM'

  // 6) Get a post by id (key)
  @Query('SELECT * FROM posts WHERE key = :key')
  Future<PostEntity?> getPostById(String key);

  // 7) Get a post by category
  @Query('SELECT * FROM posts WHERE category_key = :categoryKey')
  Future<List<PostEntity>> getPostsByCategory(String categoryKey);

  // 8) Get all posts that contain a string in their name
  @Query('SELECT * FROM posts WHERE title LIKE "%" || :searchString || "%"')
  Future<List<PostEntity>> getPostsByName(
      String searchString); // searchString should contain the search term
}
