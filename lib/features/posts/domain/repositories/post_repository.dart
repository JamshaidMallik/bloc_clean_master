import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
  // For multiple operations (delete, update, etc.), just add more abstract methods here.

  /*
  Future<PostEntity> getPostById(int id);     // fetch single post
  Future<void> deletePost(int id);            // delete post
  Future<PostEntity> addPost(PostEntity post); // add new post
  Future<PostEntity> updatePost(PostEntity post); // update post
  */

}