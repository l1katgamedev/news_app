import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/network/network_bloc.dart';

import 'core/constants/themes/light/theme.dart';
import 'presentation/blocs/news/news_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(),
        ),
        BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc(),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return BlocListener<NetworkBloc, NetworkState>(
            listener: (_, state) {
              if (state is ConnectedNetworkState) {
                showDialog(
                  context: _,
                  builder: (_) {
                    return Text(state.message);
                  },
                );
              }
              if (state is ErrorNetworkState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: child,
          );
        },
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(Brightness.light),
        home: const HomePage(),
      ),
    );
  }
}
