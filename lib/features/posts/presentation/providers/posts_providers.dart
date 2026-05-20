import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloc_clean_master/core/network/dio_client_provider.dart';
import 'package:bloc_clean_master/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:bloc_clean_master/features/posts/data/repositories/post_repository_impl.dart';
import 'package:bloc_clean_master/features/posts/domain/repositories/post_repository.dart';
import 'package:bloc_clean_master/features/posts/domain/usecases/get_posts.dart';

// ─── Composition Root ────────────────────────────────────────────────────────
//
// This file is intentionally the ONLY place that imports Riverpod into the
// data and domain objects. Domain (entities, repositories, use cases) and
// Data (datasources, models, repository impls) are all pure Dart — they have
// no knowledge of Riverpod whatsoever.
//
// The presentation layer acts as the "composition root": it knows about every
// layer and wires them together. This is the dependency injection glue.
// ─────────────────────────────────────────────────────────────────────────────

final remoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PostRemoteDataSource(dioClient);
});

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final remoteDataSource = ref.watch(remoteDataSourceProvider);
  return PostRepositoryImpl(remoteDataSource);
});

final getPostsProvider = Provider<GetPosts>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return GetPosts(repository);
});
