part of 'home_page_bloc.dart';

abstract class HomePageState {}

abstract class HomePageViewState extends HomePageState {}

abstract class HomePageNonViewState extends HomePageState {}

class HomePageInitial extends HomePageViewState {
  HomePageInitial();
}

class HomePageLoading extends HomePageViewState {
  HomePageLoading();
}

class HomepageLoaded extends HomePageViewState {
  final List<AccountEntity> listOfAccounts;
  final List<OtpEntity> listOfOtps;
  HomepageLoaded({required this.listOfAccounts, required this.listOfOtps});
}

class HomePageErrorState extends HomePageNonViewState {
  final String error;

  HomePageErrorState({required this.error});
}
