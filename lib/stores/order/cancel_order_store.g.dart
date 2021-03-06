// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CancelOrderStore on _CancelOrderStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_CancelOrderStoreBase.isLoading', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_CancelOrderStoreBase.errorMessage', context: context);

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

  late final _$orderIdAtom =
      Atom(name: '_CancelOrderStoreBase.orderId', context: context);

  @override
  String get orderId {
    _$orderIdAtom.reportRead();
    return super.orderId;
  }

  @override
  set orderId(String value) {
    _$orderIdAtom.reportWrite(value, super.orderId, () {
      super.orderId = value;
    });
  }

  late final _$noteAtom =
      Atom(name: '_CancelOrderStoreBase.note', context: context);

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  late final _$cancelOrderAsyncAction =
      AsyncAction('_CancelOrderStoreBase.cancelOrder', context: context);

  @override
  Future<void> cancelOrder() {
    return _$cancelOrderAsyncAction.run(() => super.cancelOrder());
  }

  late final _$_CancelOrderStoreBaseActionController =
      ActionController(name: '_CancelOrderStoreBase', context: context);

  @override
  void setOrderId(String id) {
    final _$actionInfo = _$_CancelOrderStoreBaseActionController.startAction(
        name: '_CancelOrderStoreBase.setOrderId');
    try {
      return super.setOrderId(id);
    } finally {
      _$_CancelOrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNote(String note) {
    final _$actionInfo = _$_CancelOrderStoreBaseActionController.startAction(
        name: '_CancelOrderStoreBase.setNote');
    try {
      return super.setNote(note);
    } finally {
      _$_CancelOrderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
orderId: ${orderId},
note: ${note}
    ''';
  }
}
