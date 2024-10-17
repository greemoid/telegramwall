import 'package:durovswall/features/wall/domain/post.dart';
import 'package:durovswall/features/wall/presentation/bloc/posts_list_bloc.dart';
import 'package:durovswall/features/wall/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WallScreen extends StatefulWidget {
  const WallScreen({super.key});

  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  static const _pageSize = 10;

  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  void _fetchPosts() {
    BlocProvider.of<PostsListBloc>(context).add(FetchPostsEvent());
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1621),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<PostsListBloc, PostsListState>(
          listener: (context, state) {
            if (state is PostsListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message,
                        style: const TextStyle(color: Colors.white))),
              );
            }
          },
          builder: (context, state) {
            if (state is PostsListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            if (state is PostsListLoaded) {
              return ListView.builder(
                  itemCount: state.listOfPosts.length,
                  itemBuilder: (context, index) {
                    final post = state.listOfPosts[index];

                    return PostWidget(
                      title: post.channel ?? '',
                      postTextHtml: post.postTextHtml ?? '',
                      avatarUrl: post.avatarUrl ?? '',
                      imageUrls: post.mediaUrl ?? [],
                    );
                  });
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
