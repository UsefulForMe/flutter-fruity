// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStoreBase, Store {
  Computed<List<String>>? _$productIdsComputed;

  @override
  List<String> get productIds =>
      (_$productIdsComputed ??= Computed<List<String>>(() => super.productIds,
              name: '_SearchStoreBase.productIds'))
          .value;

  final _$productsAtom = Atom(name: '_SearchStoreBase.products');

  @override
  List<ProductSimplify> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<ProductSimplify> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  final _$loadingAtom = Atom(name: '_SearchStoreBase.loading');

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

  final _$keywordAtom = Atom(name: '_SearchStoreBase.keyword');

  @override
  String get keyword {
    _$keywordAtom.reportRead();
    return super.keyword;
  }

  @override
  set keyword(String value) {
    _$keywordAtom.reportWrite(value, super.keyword, () {
      super.keyword = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_SearchStoreBase.errorMessage');

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

  final _$searchProductAsyncAction =
      AsyncAction('_SearchStoreBase.searchProduct');

  @override
  Future<void> searchProduct(int limit) {
    return _$searchProductAsyncAction.run(() => super.searchProduct(limit));
  }

  final _$_SearchStoreBaseActionController =
      ActionController(name: '_SearchStoreBase');

  @override
  void dispose() {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction(
        name: '_SearchStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
loading: ${loading},
keyword: ${keyword},
errorMessage: ${errorMessage},
productIds: ${productIds}
    ''';
  }
}
