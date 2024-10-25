import 'package:durovswall/features/wall/presentation/bloc/posts_list_bloc.dart';
import 'package:durovswall/features/wall/presentation/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

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
      appBar: AppBar(
        title: Text(TelegramWebApp.instance.platform),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: BlocConsumer<PostsListBloc, PostsListState>(
          listener: (context, state) {
            if (state is PostsListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message,
                        style: const TextStyle(color: Colors.black))),
              );
            }
          },
          builder: (context, state) {
            if (state is PostsListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF101010),
                ),
              );
            }

            if (state is PostsListLoaded) {
              return ListView.separated(
                  itemCount: state.listOfPosts.length,
                  itemBuilder: (context, index) {
                    final post = state.listOfPosts[index];

                    return PostWidget(
                      title: post.channel ?? '',
                      postTextHtml: post.postTextHtml ?? '',
                      avatarUrl: post.avatarUrl ?? '',
                      mediaUrls: post.mediaUrl ?? [],
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(thickness: 1, color: Color(0x15101010),),
                    );
              },);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
