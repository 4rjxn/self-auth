part of 'home_page_bloc.dart';

sealed class HomePageEvent {
  const HomePageEvent();
}

class AddScannedAccountEvent extends HomePageEvent {
  final String qrdata;

  AddScannedAccountEvent({required this.qrdata});
}

class DeleteAccountEvent extends HomePageEvent {
  final AccountEntity account;

  DeleteAccountEvent({required this.account});
}

class UpdateAccountEvent extends HomePageEvent {
  final AccountEntity account;

  UpdateAccountEvent({required this.account});
}

class OtpRefreshEvent extends HomePageEvent {
  final List<AccountEntity> accounts;

  OtpRefreshEvent({required this.accounts});
}

class AddNewAccountEvent extends HomePageEvent {
  final AccountEntity accountEntity;
  AddNewAccountEvent({required this.accountEntity});
}

class RefreshHomePageEvent extends HomePageEvent {
  final bool initial;
  RefreshHomePageEvent({this.initial = true});
}
