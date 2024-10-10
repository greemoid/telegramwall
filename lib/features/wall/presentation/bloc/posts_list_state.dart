part of 'posts_list_bloc.dart';

@immutable
sealed class PostsListState {}

final class PostsListInitial extends PostsListState {}

final class PostsListLoaded extends PostsListState {
  final List<Post> listOfPosts;

  PostsListLoaded({required this.listOfPosts});
}

final class PostsListError extends PostsListState {
  final String message;

  PostsListError({required this.message});
}

final class PostsListLoading extends PostsListState {}
