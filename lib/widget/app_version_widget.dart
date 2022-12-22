import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/cubit/app_package_cubit/app_package_cubit.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppPackageCubit()..getPackageInfo(),
        child: BlocBuilder<AppPackageCubit, AppPackageState>(
            builder: (context, state) {
          if (state is AppPackageLoaded) {
            return Text(state.packageInfo.version);
          }
          return const Text('');
        }));
  }
}
