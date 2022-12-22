import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_package_state.dart';

class AppPackageCubit extends Cubit<AppPackageState> {
  AppPackageCubit() : super(AppPackageInitial());

  Future getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(AppPackageLoaded(packageInfo: packageInfo));
  }
}
