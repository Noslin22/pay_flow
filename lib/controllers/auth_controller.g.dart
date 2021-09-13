// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthController, Store {
  final _$userModelAtom = Atom(name: '_AuthController.userModel');

  @override
  UserModel? get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel? value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$currentUserAsyncAction = AsyncAction('_AuthController.currentUser');

  @override
  Future<void> currentUser(BuildContext context) {
    return _$currentUserAsyncAction.run(() => super.currentUser(context));
  }

  final _$_AuthControllerActionController =
      ActionController(name: '_AuthController');

  @override
  void setUser({required UserModel? user, required BuildContext context}) {
    final _$actionInfo = _$_AuthControllerActionController.startAction(
        name: '_AuthController.setUser');
    try {
      return super.setUser(user: user, context: context);
    } finally {
      _$_AuthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userModel: ${userModel}
    ''';
  }
}
