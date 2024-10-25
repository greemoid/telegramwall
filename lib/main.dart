import 'dart:async';

import 'package:durovswall/features/wall/data/datasources/posts_network_datasource.dart';
import 'package:durovswall/features/wall/presentation/bloc/posts_list_bloc.dart';
import 'package:durovswall/features/wall/presentation/screens/wall_screen.dart';
import 'package:durovswall/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

void main() {
  runZonedGuarded(() async {
    try {
      if (TelegramWebApp.instance.isSupported) {
        TelegramWebApp.instance.ready();
        Future.delayed(
            const Duration(seconds: 1), TelegramWebApp.instance.expand);
      }
    } catch (e) {
      GetIt.I<Talker>()
          .info("Error happened in Flutter while loading Telegram $e");
      // add delay for 'Telegram seldom not loading' bug
      await Future.delayed(const Duration(milliseconds: 200));
      main();
      return;
    }

    FlutterError.onError = (details) {
      GetIt.I<Talker>().info("Flutter error happened: $details");
    };

    WidgetsFlutterBinding.ensureInitialized();

    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton(talker);
    GetIt.I<Talker>().debug('Talker started');

    FlutterError.onError =
        (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
    Bloc.observer = TalkerBlocObserver(talker: talker);

    initDependencies();
    GetIt.I<PostsNetworkDatasource>().parsePosts();
    runApp(MultiBlocProvider(providers: [
      BlocProvider(create: (_) => serviceLocator<PostsListBloc>())
    ], child: const MyApp()));
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WallScreen(),
    );
  }
}
