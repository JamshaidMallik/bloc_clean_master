import 'package:bloc_clean_master/features/posts/data/models/post_model.dart';
import 'package:bloc_clean_master/features/posts/presentation/pages/posts_page.dart';
import 'package:equatable/equatable.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostsState {
  const PostInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  const PostsLoaded(this.posts);

  final List<PostModel> posts;

  @override
  List<Object?> get props => [posts];
}

class PostsError extends PostsState {
  const PostsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class PostSubmitting extends PostsState {
  const PostSubmitting();
}

class PostsSubmitSuccess extends PostsState {
  const PostsSubmitSuccess(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
