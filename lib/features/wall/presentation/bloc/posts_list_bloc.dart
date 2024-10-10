import 'package:durovswall/features/wall/domain/post.dart';
import 'package:durovswall/features/wall/domain/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'posts_list_event.dart';
part 'posts_list_state.dart';

class PostsListBloc extends Bloc<PostsListEvent, PostsListState> {
  final PostsRepository _postsRepository;

  PostsListBloc({required PostsRepository postsRepository})
      : _postsRepository = postsRepository,
        super(PostsListInitial()) {
    on<PostsListEvent>((event, emit) {
      PostsListLoading();
    });
    on<FetchPostsEvent>(_fetchPosts);
  }

  void _fetchPosts(FetchPostsEvent event, Emitter<PostsListState> emit) async {
    try {
      final result = await _postsRepository.getPostsFromChannel();
      GetIt.I<Talker>().info("BlocList: ${result.toString()}");
      emit(PostsListLoaded(listOfPosts: result));
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }
}
