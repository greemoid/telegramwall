import 'package:durovswall/features/wall/presentation/bloc/posts_list_bloc.dart';
import 'package:durovswall/features/wall/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return BlocConsumer<PostsListBloc, PostsListState>(
                listener: (context, state) {
                  if (state is PostsListError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(
                          state.message, style: const TextStyle(color: Colors
                          .white))),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PostsListLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if (state is PostsListLoaded) {
                    return PostWidget(
                        title: state.listOfPosts[index].channel ?? '',
                        postTextHtml: state.listOfPosts[index].postTextHtml ??
                            '');
                  }
                  return const SizedBox();
                },
              );
            }),
      ),
    );
  }
}
