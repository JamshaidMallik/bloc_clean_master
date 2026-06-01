import 'package:bloc/bloc.dart';
import 'package:bloc_clean_master/core/network/dio_client.dart';
import 'package:bloc_clean_master/features/posts/data/models/post_model.dart';
import 'package:bloc_clean_master/features/posts/presentation/bloc/posts_event.dart';
import 'package:bloc_clean_master/features/posts/presentation/bloc/posts_state.dart';
import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<E> debounceRestartable<E>(Duration duration) {
  return (events, mapper) {
    return restartable<E>().call(
      events.debounce(duration),
      mapper,
    );
  };
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostInitial()) {
    on<LoadPostsEvents>(_onLoadPosts);
    on<SearchPostsEvents>(
      _onSearchPosts,
      transformer: debounceRestartable(const Duration(milliseconds: 300)),
    );
    on<SubmitPostsSummaryEvent>(_onSubmitPostsSummary);
  }

  List<PostModel> _allPosts = [];

  Future<void> _onLoadPosts(LoadPostsEvents events, Emitter<PostsState> emit) async {
    try{
      emit(const PostsLoading());
      final response = await DioClient().dio.get('/posts?_limit=3');
      final posts = (response.data as List)
          .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
          .toList();
      _allPosts = posts;
      emit(PostsLoaded(posts));
    }catch(e){
        emit(PostsError(e.toString()));
    }

  }

  void _onSearchPosts(SearchPostsEvents events, Emitter<PostsState> emit) {
    final query = events.query.trim().toLowerCase();
    if (query.isEmpty) {
      emit(PostsLoaded(_allPosts));
      return;
    }

    final filteredPosts = _allPosts.where((post) {
      return post.title.toLowerCase().contains(query) ||
          post.body.toLowerCase().contains(query);
    }).toList();
    emit(PostsLoaded(filteredPosts));
  }

  Future<void> _onSubmitPostsSummary(SubmitPostsSummaryEvent events, Emitter<PostsState> emit) async {
    try {
      emit(const PostSubmitting());
      final totalPostCount = _allPosts.length;
      debugPrint('Submitting posts summary with $totalPostCount posts...');
      debugPrint('Submitting events parameters with ${events.totalPosts} posts...');
      await Future.delayed(const Duration(seconds: 3));
      debugPrint('Posts summary submitted successfully');
      emit(const PostsSubmitSuccess('Posts summary submitted successfully'));
      await Future.delayed(const Duration(seconds: 1));
      emit(PostsLoaded(_allPosts));
    } catch (e){
      emit(PostsError(e.toString()));
    }

  }
}
