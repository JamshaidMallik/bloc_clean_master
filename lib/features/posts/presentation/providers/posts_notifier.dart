import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloc_clean_master/features/posts/domain/entities/post_entity.dart';
import 'posts_providers.dart';

/// Presentation layer only — depends on the use case via [getPostsProvider].
/// Never imports from data layer directly.
final postNotifierProvider =
    AsyncNotifierProvider<PostsNotifier, List<PostEntity>>(() => PostsNotifier());

class PostsNotifier extends AsyncNotifier<List<PostEntity>> {
  @override
  Future<List<PostEntity>> build() {
    return ref.read(getPostsProvider).call();
  }

  Future<void> refreshPosts() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(getPostsProvider).call());
  }
}