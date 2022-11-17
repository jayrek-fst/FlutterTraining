import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fumiya_flutter/bloc/auth_bloc/auth_bloc.dart';

import '../../data/datasource/remote/auth/auth_remote_datasource_impl.dart';
import '../../data/datasource/remote/user/user_remote_datasource_impl.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/user_repository_impl.dart';
import '../../domain/use_case/app_use_cases.dart';
import '../../util/route_util.dart';
import '../../widget/common_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                appUseCases: AppUseCases(
                    authRepository: AuthRepositoryImpl(
                        authRemoteDataSource: AuthRemoteDataSourceImpl()),
                    userRepository: UserRepositoryImpl(
                        userRemoteDataSource: UserRemoteDataSourceImpl())))
              ..add(CheckAuthUser()),
            child:
                BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthUserAuthenticated) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteUtil.dashboard, (route) => false);
              }
              if (state is AuthUserUnAuthenticated ||
                  state is AuthExceptionOccurred) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteUtil.tutorialOne, (route) => false);
              }
            }, builder: (context, state) {
              return Stack(children: [
                Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height),
                progressDialog()
              ]);
            })));
  }
}
