// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on _CartStoreBase, Store {
  Computed<bool>? _$canIncreaseQuantityComputed;

  @override
  bool get canIncreaseQuantity => (_$canIncreaseQuantityComputed ??=
          Computed<bool>(() => super.canIncreaseQuantity,
              name: '_CartStoreBase.canIncreaseQuantity'))
      .value;
  Computed<bool>? _$canDecreaseQuantityComputed;

  @override
  bool get canDecreaseQuantity => (_$canDecreaseQuantityComputed ??=
          Computed<bool>(() => super.canDecreaseQuantity,
              name: '_CartStoreBase.canDecreaseQuantity'))
      .value;
  Computed<bool>? _$canAddToCartComputed;

  @override
  bool get canAddToCart =>
      (_$canAddToCartComputed ??= Computed<bool>(() => super.canAddToCart,
              name: '_CartStoreBase.canAddToCart'))
          .value;
  Computed<Map<String, List<CartItem>>>? _$groupedItemsBySellerComputed;

  @override
  Map<String, List<CartItem>> get groupedItemsBySeller =>
      (_$groupedItemsBySellerComputed ??= Computed<Map<String, List<CartItem>>>(
              () => super.groupedItemsBySeller,
              name: '_CartStoreBase.groupedItemsBySeller'))
          .value;
  Computed<Map<String, List<CartItem>>>? _$groupedItemsBySellerSelectedComputed;

  @override
  Map<String, List<CartItem>> get groupedItemsBySellerSelected =>
      (_$groupedItemsBySellerSelectedComputed ??=
              Computed<Map<String, List<CartItem>>>(
                  () => super.groupedItemsBySellerSelected,
                  name: '_CartStoreBase.groupedItemsBySellerSelected'))
          .value;
  Computed<Map<String, double>>? _$totalPriceBySellerComputed;

  @override
  Map<String, double> get totalPriceBySeller =>
      (_$totalPriceBySellerComputed ??= Computed<Map<String, double>>(
              () => super.totalPriceBySeller,
              name: '_CartStoreBase.totalPriceBySeller'))
          .value;
  Computed<List<String>>? _$sellerIdsComputed;

  @override
  List<String> get sellerIds =>
      (_$sellerIdsComputed ??= Computed<List<String>>(() => super.sellerIds,
              name: '_CartStoreBase.sellerIds'))
          .value;

  late final _$itemsAtom = Atom(name: '_CartStoreBase.items', context: context);

  @override
  List<CartItem> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<CartItem> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CartStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: '_CartStoreBase.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$qtyAtom = Atom(name: '_CartStoreBase.qty', context: context);

  @override
  int get qty {
    _$qtyAtom.reportRead();
    return super.qty;
  }

  @override
  set qty(int value) {
    _$qtyAtom.reportWrite(value, super.qty, () {
      super.qty = value;
    });
  }

  late final _$addItemAsyncAction =
      AsyncAction('_CartStoreBase.addItem', context: context);

  @override
  Future<void> addItem(CartItem item) {
    return _$addItemAsyncAction.run(() => super.addItem(item));
  }

  late final _$addItemsAsyncAction =
      AsyncAction('_CartStoreBase.addItems', context: context);

  @override
  Future<void> addItems(List<CartItem> items) {
    return _$addItemsAsyncAction.run(() => super.addItems(items));
  }

  late final _$updateQuantityAsyncAction =
      AsyncAction('_CartStoreBase.updateQuantity', context: context);

  @override
  Future<void> updateQuantity(CartItem item, int quantty) {
    return _$updateQuantityAsyncAction
        .run(() => super.updateQuantity(item, quantty));
  }

  late final _$removeItemAsyncAction =
      AsyncAction('_CartStoreBase.removeItem', context: context);

  @override
  Future<void> removeItem(CartItem item) {
    return _$removeItemAsyncAction.run(() => super.removeItem(item));
  }

  late final _$removeItemsAsyncAction =
      AsyncAction('_CartStoreBase.removeItems', context: context);

  @override
  Future<void> removeItems(List<CartItem> items) {
    return _$removeItemsAsyncAction.run(() => super.removeItems(items));
  }

  late final _$_CartStoreBaseActionController =
      ActionController(name: '_CartStoreBase', context: context);

  @override
  void selectItem(CartItem item) {
    final _$actionInfo = _$_CartStoreBaseActionController.startAction(
        name: '_CartStoreBase.selectItem');
    try {
      return super.selectItem(item);
    } finally {
      _$_CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateQuantity(String quantity) {
    final _$actionInfo = _$_CartStoreBaseActionController.startAction(
        name: '_CartStoreBase.validateQuantity');
    try {
      return super.validateQuantity(quantity);
    } finally {
      _$_CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_CartStoreBaseActionController.startAction(
        name: '_CartStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanQty() {
    final _$actionInfo = _$_CartStoreBaseActionController.startAction(
        name: '_CartStoreBase.cleanQty');
    try {
      return super.cleanQty();
    } finally {
      _$_CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decreaseQuantity() {
    final _$actionInfo = _$_CartStoreBaseActionController.startAction(
        name: '_CartStoreBase.decreaseQuantity');
    try {
      return super.decreaseQuantity();
    } finally {
      _$_CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increaseQuantity() {
    final _$actionInfo = _$_CartStoreBaseActionController.startAction(
        name: '_CartStoreBase.increaseQuantity');
    try {
      return super.increaseQuantity();
    } finally {
      _$_CartStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
isLoading: ${isLoading},
error: ${error},
qty: ${qty},
canIncreaseQuantity: ${canIncreaseQuantity},
canDecreaseQuantity: ${canDecreaseQuantity},
canAddToCart: ${canAddToCart},
groupedItemsBySeller: ${groupedItemsBySeller},
groupedItemsBySellerSelected: ${groupedItemsBySellerSelected},
totalPriceBySeller: ${totalPriceBySeller},
sellerIds: ${sellerIds}
    ''';
  }
}
