import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/brasileirao_provider.dart';
import 'screens/tabela_classificacao_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BrasileiraoProvider(),
      child: Consumer<BrasileiraoProvider>(
        builder: (context, provider, child) {
          final lightTheme = ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
            ),
            cardTheme: const CardThemeData(elevation: 2),
          );

          final darkTheme = ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.green[900],
              foregroundColor: Colors.white,
            ),
            cardTheme: const CardThemeData(elevation: 2),
          );

          return MaterialApp(
            title: 'Brasileirão 2025',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const TabelaClassificacaoScreen(),
          );
        },
      ),
    );
  }
}
