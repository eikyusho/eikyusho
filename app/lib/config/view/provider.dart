import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/injector/injector.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:app/src/browse/presentation/presentation.dart';
import 'package:app/src/discover/data/data.dart';
import 'package:app/src/discover/presentation/presentation.dart';
import 'package:app/src/library/data/data.dart';
import 'package:app/src/library/presentation/presentation.dart';
import 'package:app/src/search/data/data.dart';
import 'package:app/src/search/presentation/presentation.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DiscoverCubit(
            getIt<ExtensionsRepository>(),
            getIt<DiscoverRepository>(),
          )..getSources(),
        ),
        BlocProvider(
          create: (_) => LibraryCubit(
            getIt<LibraryRepository>(),
          )..loadLibrary(),
        ),
        BlocProvider(
          create: (_) => SearchCubit(
            getIt<SearchRepository>(),
            getIt<LibraryRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) => BrowseCubit(
            getIt<ExtensionsRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
