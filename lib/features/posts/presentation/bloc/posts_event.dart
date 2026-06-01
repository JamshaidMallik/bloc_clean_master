import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPostsEvents extends PostsEvent {
  const LoadPostsEvents();
}


class SearchPostsEvents extends PostsEvent {
  const SearchPostsEvents(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class SubmitPostsSummaryEvent extends PostsEvent {
  final int totalPosts;
  const SubmitPostsSummaryEvent({required this.totalPosts});

  @override
  List<Object?> get props => [totalPosts];
}
