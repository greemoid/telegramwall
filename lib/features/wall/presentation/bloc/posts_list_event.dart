part of 'posts_list_bloc.dart';

@immutable
sealed class PostsListEvent {}

final class FetchPostsEvent extends PostsListEvent {}
