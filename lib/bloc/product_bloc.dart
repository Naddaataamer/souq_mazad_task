import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:faker/faker.dart';
import '../models/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final faker = Faker();
  List<Product> allProducts = [];
  int currentPage = 0;
  final int itemsPerPage = 10;

  ProductBloc() : super(ProductInitial()) {
    on<LoadMoreProducts>(_onLoadMoreProducts);
  }

  void _onLoadMoreProducts(LoadMoreProducts event, Emitter<ProductState> emit) async {
    if (state is ProductLoading)
      return;

    emit(ProductLoading());


    await Future.delayed(const Duration(seconds: 1), () {
      final startIndex = currentPage * itemsPerPage;
      final newProducts = List.generate(
        itemsPerPage,
            (index) =>
            Product(
              name: faker.food.dish(),
              price: '\$${faker.randomGenerator.integer(100, min: 10)}',
              thumbnailUrl: 'https://via.placeholder.com/150',
              description: faker.lorem.sentence(),
              largeImageUrl: 'https://via.placeholder.com/600',
            ),
      );

      allProducts.addAll(newProducts);
      currentPage++;

      final hasMore = allProducts.length < 26;

      emit(ProductLoaded(
          List.from(allProducts), hasMore));
    });
  }
}