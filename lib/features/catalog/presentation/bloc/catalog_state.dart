import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Product> products;
  final String selectedCategory;
  final String searchQuery;

  const CatalogLoaded({
    required this.products,
    this.selectedCategory = 'all',
    this.searchQuery = '',
  });

  List<Product> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory == 'all' || product.category == selectedCategory;
      final matchesQuery = searchQuery.isEmpty ||
          product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  List<Object?> get props => [products, selectedCategory, searchQuery];
}

class CatalogError extends CatalogState {
  final String message;
  const CatalogError(this.message);

  @override
  List<Object?> get props => [message];
}
