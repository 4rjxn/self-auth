import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Entity/otp_entity.dart';
import 'package:qauth/Domain/Exceptions/scan_exception.dart';
import 'package:qauth/Domain/Usecases/add_account_usecase.dart';
import 'package:qauth/Domain/Usecases/delete_account_usecase.dart';
import 'package:qauth/Domain/Usecases/generate_otp_usecase.dart';
import 'package:qauth/Domain/Usecases/get_accounts_usecase.dart';
import 'package:qauth/Domain/Usecases/parse_uri_usecase.dart';
import 'package:qauth/Domain/Usecases/update_account_usecase.dart';
import 'package:qauth/Presentation/Core/DependencyInjection/dependancy_injection.dart';
import 'package:totp_dart/totp_dart.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  Timer? _timer;
  HomePageBloc() : super(HomePageLoading()) {
    on<RefreshHomePageEvent>(_onRefreshHomePage);
    on<AddNewAccountEvent>(_onAddNewAccount);
    on<OtpRefreshEvent>(_onOtpRefresh);
    on<UpdateAccountEvent>(_onUpdateAccount);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<AddScannedAccountEvent>(_onAddScannedAccountEvent);
  }

  Future<void> _onRefreshHomePage(
    RefreshHomePageEvent event,
    Emitter<HomePageState> emit,
  ) async {
    _timer?.cancel();
    final accounts = await getIt<GetAccountsUsecase>().call();
    final otps = await GenerateOtpUsecase().call(accountList: accounts);
    if (otps.isNotEmpty) {
      emit(HomepageLoaded(listOfAccounts: accounts, listOfOtps: otps));
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (TOTP.timeRemaining(interval: 30) == "30") {
          add(OtpRefreshEvent(accounts: accounts));
        }
      });
    } else {
      emit(HomePageInitial());
    }
  }

  // Handles adding a new account
  void _onAddNewAccount(
    AddNewAccountEvent event,
    Emitter<HomePageState> emit,
  ) async {
    (await getIt<AddAccountUsecase>().call(
      accountEntity: event.accountEntity,
    )).fold(
      (err) {
        emit(HomePageErrorState(error: err.error));
      },
      (_) {
        add(RefreshHomePageEvent());
      },
    );
  }

  Future _onOtpRefresh(
    OtpRefreshEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final List<OtpEntity> otps = await GenerateOtpUsecase().call(
      accountList: event.accounts,
    );
    emit(HomepageLoaded(listOfAccounts: event.accounts, listOfOtps: otps));
  }

  Future<void> _onUpdateAccount(
    UpdateAccountEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(HomePageLoading());
    (await getIt<UpdateAccountsUsecase>().call(
      accountEntity: event.account,
    )).fold(
      (err) {
        emit(HomePageErrorState(error: err.error));
      },
      (_) {
        add(RefreshHomePageEvent());
      },
    );
  }

  Future<void> _onDeleteAccount(
    DeleteAccountEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(HomePageLoading());
    (await getIt<DeleteAccountUsecase>().call(account: event.account)).fold(
      (err) {
        emit(HomePageErrorState(error: err.error));
      },
      (_) {
        add(RefreshHomePageEvent());
      },
    );
  }

  Future<void> _onAddScannedAccountEvent(
    AddScannedAccountEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final Either<ScanException, AccountEntity> result = await ParseUriUsecase()
        .call(data: event.qrdata);
    result.fold(
      (_) {
        emit(HomePageErrorState(error: "Invalid Qr Error"));
      },
      (account) {
        add(AddNewAccountEvent(accountEntity: account));
      },
    );
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
