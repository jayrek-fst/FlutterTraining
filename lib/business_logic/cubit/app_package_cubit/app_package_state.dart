part of 'app_package_cubit.dart';

abstract class AppPackageState extends Equatable {
  const AppPackageState();

  @override
  List<Object> get props => [];
}

class AppPackageInitial extends AppPackageState {}

class AppPackageLoaded extends AppPackageState {
  final PackageInfo packageInfo;

  const AppPackageLoaded({required this.packageInfo});

  @override
  List<Object> get props => [packageInfo];
}
