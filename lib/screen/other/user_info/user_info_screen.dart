import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import '../../../business_logic/bloc/auth_bloc/auth_bloc.dart';
import '../../../business_logic/bloc/user_bloc/user_bloc.dart';
import '../../../data/model/user_model.dart';
import '../../../domain/use_case/auth_use_case.dart';
import '../../../util/route_util.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/common_widget.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key? key}) : super(key: key);

  final userInfo = AuthBloc(appUseCases: AuthUseCase());

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    userInfo.add(CheckAuthUser());

    return Scaffold(
        appBar: AppBar(
            title: Text(appLocalizations.raw_common_user_information,
                style: appBarTitleTextStyle)),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: BlocConsumer<AuthBloc, AuthState>(
                  bloc: userInfo,
                  listener: (context, state) {},
                  builder: (context, state) {
                    final UserModel userInfo;
                    if (state is AuthUserAuthenticated) {
                      userInfo = state.user;
                      return Column(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                                height: 200,
                                child: Column(children: [
                                  ProfileIcon(
                                      imageIcon: userInfo.icon.toString()),
                                  const SizedBox(height: 10),
                                  Text(
                                      '${userInfo.fullName?.firstName} ${userInfo.fullName?.lastName}'),
                                  Text('${userInfo.mail}')
                                ]))),
                        const Divider(
                            height: 0, thickness: 1, color: Colors.white),
                        otherListItem(
                            title:
                                appLocalizations.raw_common_update_user_title,
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18),
                            onTap: () => Navigator.of(context)
                                .pushNamed(RouteUtil.updateUserInfo)),
                        otherListItem(
                            title: appLocalizations.raw_common_update_email,
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18),
                            onTap: () => Navigator.of(context).pushNamed(
                                RouteUtil.reSignIn,
                                arguments: StringConstants.updateEmail)),
                        otherListItem(
                            title: appLocalizations.raw_common_update_password,
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18),
                            onTap: () => Navigator.of(context).pushNamed(
                                RouteUtil.reSignIn,
                                arguments: StringConstants.updatePassword))
                      ]);
                    }
                    if (state is AuthLoading) progressDialog();
                    return Container();
                  },
                ))));
  }
}

class ProfileIcon extends StatefulWidget {
  ProfileIcon({Key? key, this.imageIcon}) : super(key: key);

  String? imageIcon;

  @override
  State<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  File? iconFile;

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Wrap(children: [
                  _uploadPhotoItem(
                      icon: Icons.delete_rounded,
                      title: appLocalizations
                          .raw_bottom_sheet_photo_options_item_delete_photo,
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          iconFile = null;
                          widget.imageIcon = '';
                        });
                        context.read<UserBloc>().add(DeletePhoto());
                      },
                      isEnable: widget.imageIcon != "" || iconFile != null
                          ? true
                          : false),
                  _uploadPhotoItem(
                      icon: Icons.photo_library_rounded,
                      title: appLocalizations
                          .raw_bottom_sheet_photo_options_item_gallery,
                      onTap: () {
                        Navigator.of(context).pop();
                        pickImage(context: context, isOpenCamera: false);
                      },
                      isEnable: true),
                  _uploadPhotoItem(
                      icon: Icons.camera_alt_rounded,
                      title: appLocalizations
                          .raw_bottom_sheet_photo_options_item_camera,
                      onTap: () {
                        Navigator.of(context).pop();
                        pickImage(context: context, isOpenCamera: true);
                      },
                      isEnable: true)
                ]);
              });
        },
        child: Stack(children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: iconFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(iconFile!,
                          fit: BoxFit.cover, width: 100, height: 100))
                  : widget.imageIcon != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                              imageUrl: widget.imageIcon!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100))
                      : const Icon(Icons.person,
                          size: 100, color: Colors.black38)),
          circularAddIcon()
        ]));
  }

  Future pickImage(
      {required BuildContext context, required bool isOpenCamera}) async {
    final contextRead = context.read<UserBloc>();
    try {
      final image = await ImagePicker().pickImage(
          source: isOpenCamera ? ImageSource.camera : ImageSource.gallery,
          maxHeight: 512,
          maxWidth: 512,
          imageQuality: 75);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => iconFile = imageTemp);
      contextRead.add(UploadPhoto(imageFile: imageTemp));
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  _uploadPhotoItem(
      {required IconData icon,
      required String title,
      required Function() onTap,
      required bool isEnable}) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Icon(icon,
            color: isEnable ? Colors.black : Colors.black38, size: 20),
        title: Text(title,
            style: TextStyle(
                color: isEnable ? Colors.black : Colors.black38,
                fontFamily: StringConstants.fontNotoSans,
                fontSize: 15)),
        onTap: isEnable ? onTap : null);
  }
}
