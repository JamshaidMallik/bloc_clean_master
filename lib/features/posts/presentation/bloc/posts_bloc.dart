import 'package:bloc/bloc.dart';
import 'package:bloc_clean_master/features/posts/presentation/bloc/posts_event.dart';
import 'package:bloc_clean_master/features/posts/presentation/bloc/posts_state.dart';

import '../pages/posts_page.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostInitial()) {
    on<LoadPostsEvents>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(
    LoadPostsEvents events,
    Emitter<PostsState> emit,
  ) async {
    emit(const PostsLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(const PostsLoaded(PostsPage.posts));
  }
}
