import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_mazad_test/screens/product_list.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';

void main() {
  runApp(SouqMazadApp());
}

class SouqMazadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Souq Mazad',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => ProductBloc()..add(LoadMoreProducts()), //
        child: ProductListScreen(),
      ),
    );
  }
}