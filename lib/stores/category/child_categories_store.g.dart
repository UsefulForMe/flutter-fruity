// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChildCategoryStore on _ChildCategoryStoreBase, Store {
  final _$categoriesAtom = Atom(name: '_ChildCategoryStoreBase.categories');

  @override
  List<Category> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<Category> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ChildCategoryStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_ChildCategoryStoreBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$getCategoriesAsyncAction =
      AsyncAction('_ChildCategoryStoreBase.getCategories');

  @override
  Future<void> getCategories(Category category) {
    return _$getCategoriesAsyncAction.run(() => super.getCategories(category));
  }

  @override
  String toString() {
    return '''
categories: ${categories},
loading: ${loading},
errorMessage: ${errorMessage}
    ''';
  }
}