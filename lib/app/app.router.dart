// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:google_docs/models/document_model.dart' as _i6;
import 'package:google_docs/ui/views/documentscreen/documentscreen_view.dart'
    as _i4;
import 'package:google_docs/ui/views/homescreen/homescreen_view.dart' as _i3;
import 'package:google_docs/ui/views/login/login_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i7;

class Routes {
  static const loginView = '/login-view';

  static const homescreenView = '/homescreen-view';

  static const documentscreenView = '/documentscreen-view';

  static const all = <String>{
    loginView,
    homescreenView,
    documentscreenView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.loginView,
      page: _i2.LoginView,
    ),
    _i1.RouteDef(
      Routes.homescreenView,
      page: _i3.HomescreenView,
    ),
    _i1.RouteDef(
      Routes.documentscreenView,
      page: _i4.DocumentscreenView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.LoginView(),
        settings: data,
      );
    },
    _i3.HomescreenView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomescreenView(),
        settings: data,
      );
    },
    _i4.DocumentscreenView: (data) {
      final args = data.getArgs<DocumentscreenViewArguments>(nullOk: false);
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.DocumentscreenView(key: args.key, document: args.document),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class DocumentscreenViewArguments {
  const DocumentscreenViewArguments({
    this.key,
    required this.document,
  });

  final _i5.Key? key;

  final _i6.DocumentModel document;

  @override
  String toString() {
    return '{"key": "$key", "document": "$document"}';
  }

  @override
  bool operator ==(covariant DocumentscreenViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.document == document;
  }

  @override
  int get hashCode {
    return key.hashCode ^ document.hashCode;
  }
}

extension NavigatorStateExtension on _i7.NavigationService {
  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomescreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homescreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDocumentscreenView({
    _i5.Key? key,
    required _i6.DocumentModel document,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.documentscreenView,
        arguments: DocumentscreenViewArguments(key: key, document: document),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomescreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homescreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDocumentscreenView({
    _i5.Key? key,
    required _i6.DocumentModel document,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.documentscreenView,
        arguments: DocumentscreenViewArguments(key: key, document: document),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
