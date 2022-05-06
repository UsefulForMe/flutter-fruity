// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_categories_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ParentCategoryStore on _ParentCategoryStoreBase, Store {
  final _$categoryIdAtom = Atom(name: '_ParentCategoryStoreBase.categoryId');

  @override
  String? get categoryId {
    _$categoryIdAtom.reportRead();
    return super.categoryId;
  }

  @override
  set categoryId(String? value) {
    _$categoryIdAtom.reportWrite(value, super.categoryId, () {
      super.categoryId = value;
    });
  }

  final _$categoriesAtom = Atom(name: '_ParentCategoryStoreBase.categories');

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

  final _$loadingAtom = Atom(name: '_ParentCategoryStoreBase.loading');

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

  final _$errorMessageAtom =
      Atom(name: '_ParentCategoryStoreBase.errorMessage');

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
      AsyncAction('_ParentCategoryStoreBase.getCategories');

  @override
  Future<void> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  final _$_ParentCategoryStoreBaseActionController =
      ActionController(name: '_ParentCategoryStoreBase');

  @override
  void setCategoryId(String? categoryId) {
    final _$actionInfo = _$_ParentCategoryStoreBaseActionController.startAction(
        name: '_ParentCategoryStoreBase.setCategoryId');
    try {
      return super.setCategoryId(categoryId);
    } finally {
      _$_ParentCategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoryId: ${categoryId},
categories: ${categories},
loading: ${loading},
errorMessage: ${errorMessage}
    ''';
  }
}
