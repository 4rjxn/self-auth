import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';
import 'package:qauth/Presentation/Pages/HomePage/States/home_page_initial.dart';
import 'package:qauth/Presentation/Pages/HomePage/States/home_page_loaded.dart';
import 'package:qauth/Presentation/Pages/HomePage/States/home_page_loading.dart';
import 'package:qauth/Presentation/Router/router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomePageBloc>().add(RefreshHomePageEvent());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            print("current state is :::$state");
            if (state is HomepageLoaded) {
              return FloatingActionButton(
                onPressed: () async {
                  await AutoRouter.of(context).push(AccountEditRoute());
                },
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(Icons.add),
              );
            }
            return SizedBox.shrink();
          },
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await AutoRouter.of(context).push(ScanCodeRoute());
              },
              icon: Icon(Icons.qr_code),
            ),
          ],
          title: Text("Welcome", style: TextStyle(fontSize: 25.sp)),
        ),
        body: BlocListener<HomePageBloc, HomePageState>(
          listenWhen: (previous, current) => current is HomePageNonViewState,
          listener: (context, state) {
            if (state is HomePageErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10.w),
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<HomePageBloc, HomePageState>(
            buildWhen: (previous, current) => current is HomePageViewState,
            builder: (context, state) {
              if (state is HomePageInitial) {
                return HomePageInitialScreen();
              }
              if (state is HomepageLoaded) {
                return HomePageLoadedScreen(
                  listOfAccounts: state.listOfAccounts,
                  otpEntity: state.listOfOtps,
                );
              }
              if (state is HomePageLoading) {
                return HomePageLoadingScreen();
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
