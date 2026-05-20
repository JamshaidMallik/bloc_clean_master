import '../../../../core/network/dio_client.dart';
import '../models/post_model.dart';

class PostRemoteDataSource {
  final DioClient dioClient;

  PostRemoteDataSource(this.dioClient);

  Future<List<PostModel>> getPosts() async {
    final response = await dioClient.dio.get('/posts');
    return (response.data as List).map((json) => PostModel.fromJson(json)).toList();
  }
}
