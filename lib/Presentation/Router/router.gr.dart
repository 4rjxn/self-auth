// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:qauth/Domain/Entity/account_entity.dart' as _i9;
import 'package:qauth/Presentation/Pages/AccountEditPage/account_edit_page.dart'
    as _i1;
import 'package:qauth/Presentation/Pages/HomePage/home_page.dart' as _i3;
import 'package:qauth/Presentation/Pages/ScanCodePage/scan_code_page.dart'
    as _i5;
import 'package:qauth/Presentation/Pages/SettingsPage/settings_page.dart'
    as _i6;
import 'package:qauth/Presentation/Pages/SettingsPage/SubPages/backup_page.dart'
    as _i2;
import 'package:qauth/Presentation/Pages/SettingsPage/SubPages/restore_page.dart'
    as _i4;

/// generated route for
/// [_i1.AccountEditPage]
class AccountEditRoute extends _i7.PageRouteInfo<AccountEditRouteArgs> {
  AccountEditRoute({
    _i8.Key? key,
    _i9.AccountEntity? account,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         AccountEditRoute.name,
         args: AccountEditRouteArgs(key: key, account: account),
         initialChildren: children,
       );

  static const String name = 'AccountEditRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccountEditRouteArgs>(
        orElse: () => const AccountEditRouteArgs(),
      );
      return _i1.AccountEditPage(key: args.key, account: args.account);
    },
  );
}

class AccountEditRouteArgs {
  const AccountEditRouteArgs({this.key, this.account});

  final _i8.Key? key;

  final _i9.AccountEntity? account;

  @override
  String toString() {
    return 'AccountEditRouteArgs{key: $key, account: $account}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccountEditRouteArgs) return false;
    return key == other.key && account == other.account;
  }

  @override
  int get hashCode => key.hashCode ^ account.hashCode;
}

/// generated route for
/// [_i2.BackupPage]
class BackupRoute extends _i7.PageRouteInfo<BackupRouteArgs> {
  BackupRoute({_i8.Key? key, List<_i7.PageRouteInfo>? children})
    : super(
        BackupRoute.name,
        args: BackupRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'BackupRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BackupRouteArgs>(
        orElse: () => const BackupRouteArgs(),
      );
      return _i2.BackupPage(key: args.key);
    },
  );
}

class BackupRouteArgs {
  const BackupRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'BackupRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BackupRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.RestorePage]
class RestoreRoute extends _i7.PageRouteInfo<void> {
  const RestoreRoute({List<_i7.PageRouteInfo>? children})
    : super(RestoreRoute.name, initialChildren: children);

  static const String name = 'RestoreRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.RestorePage();
    },
  );
}

/// generated route for
/// [_i5.ScanCodePage]
class ScanCodeRoute extends _i7.PageRouteInfo<ScanCodeRouteArgs> {
  ScanCodeRoute({_i8.Key? key, List<_i7.PageRouteInfo>? children})
    : super(
        ScanCodeRoute.name,
        args: ScanCodeRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ScanCodeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScanCodeRouteArgs>(
        orElse: () => const ScanCodeRouteArgs(),
      );
      return _i5.ScanCodePage(key: args.key);
    },
  );
}

class ScanCodeRouteArgs {
  const ScanCodeRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'ScanCodeRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScanCodeRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SettingsPage();
    },
  );
}
