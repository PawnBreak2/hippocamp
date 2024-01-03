import 'package:floor/floor.dart';
import 'package:hippocapp/helpers/db/entities/category.dart';

@dao
abstract class CategoryEntityDao {
  // Retrieve a category by key
  @Query('SELECT * FROM categories WHERE key = :key')
  Future<CategoryEntity?> getCategoryByKey(String key);

  // Retrieve all categories
  @Query('SELECT * FROM categories')
  Future<List<CategoryEntity>> getAllCategories();

  // Update a category
  @update
  Future<void> updateCategory(CategoryEntity category);

  // Delete a category
  @delete
  Future<void> deleteCategory(CategoryEntity category);
}
