import 'package:bloc_clean_master/features/posts/data/models/post_model.dart';

import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;


  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PostEntity>> getPosts() async {
    final posts = await remoteDataSource.getPosts();
    return posts.map((post) => post.toEntity()).toList();
  }
}