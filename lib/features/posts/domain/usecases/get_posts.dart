import 'package:bloc_clean_master/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_clean_master/features/posts/domain/repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;
  GetPosts(this.repository);

  Future<List<PostEntity>> call() async {
    return await repository.getPosts();
  }

}