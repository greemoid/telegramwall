import 'package:durovswall/features/wall/presentation/bloc/posts_list_bloc.dart';
import 'package:durovswall/features/wall/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

// todo: десь блокується мейн тред, не рухається індикатор
// for starting server npx http-server build/web --cors

class WallScreen extends StatefulWidget {
  const WallScreen({super.key});

  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
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
                    // GetIt.I<Talker>().warning(state.listOfPosts.length);
                    final post = state.listOfPosts[index];

                    return PostWidget(
                      title: post.channel ?? '',
                      postTextHtml: post.postTextHtml ?? '',
                      avatarUrl: post.avatarUrl ?? '',
                      imageUrls: post.imageUrls ?? [],
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
