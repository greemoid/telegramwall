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
    FlutterError.onError = (details) {
      GetIt.I<Talker>().info("Flutter error happened: $details");
    };

    // There can be a mistake because of lack of await
    _initTelegramWeb();

    WidgetsFlutterBinding.ensureInitialized();

    _initTalker();
    initDependencies();
    GetIt.I<PostsNetworkDatasource>().parsePosts();
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<PostsListBloc>(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Wall',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WallScreen(),
    );
  }
}

void _initTelegramWeb() async {
  try {
    if (TelegramWebApp.instance.isSupported) {
      TelegramWebApp.instance.ready();
      Future.delayed(
          const Duration(seconds: 1), TelegramWebApp.instance.expand);
    }
    TelegramWebApp.instance.disableVerticalSwipes();
  } catch (e) {
    GetIt.I<Talker>()
        .info("Error happened in Flutter while loading Telegram $e");
    await Future.delayed(const Duration(milliseconds: 200));
    main();
    return;
  }
}

void _initTalker() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started');

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);
  Bloc.observer = TalkerBlocObserver(talker: talker);
}
