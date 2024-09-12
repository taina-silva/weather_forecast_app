// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EntryStore on EntryStoreBase, Store {
  late final _$_currentPageAtom =
      Atom(name: 'EntryStoreBase._currentPage', context: context);

  int get currentPage {
    _$_currentPageAtom.reportRead();
    return super._currentPage;
  }

  @override
  int get _currentPage => currentPage;

  @override
  set _currentPage(int value) {
    _$_currentPageAtom.reportWrite(value, super._currentPage, () {
      super._currentPage = value;
    });
  }

  late final _$changePageAsyncAction =
      AsyncAction('EntryStoreBase.changePage', context: context);

  @override
  Future<void> changePage(int index) {
    return _$changePageAsyncAction.run(() => super.changePage(index));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
