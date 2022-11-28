import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../business_logic/bloc/auth_bloc/auth_bloc.dart';
import '../../data/model/user_model.dart';
import '../../util/app_color_util.dart';
import '../../util/gender_value_util.dart';
import '../../util/asset_path_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../util/style_util.dart';
import '../../widget/common_widget.dart';
import '../../widget/elevated_button_widget.dart';

class SignUpDetailsConfirmationScreen extends StatelessWidget {
  const SignUpDetailsConfirmationScreen({Key? key, required this.passData})
      : super(key: key);

  final dynamic passData;

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    final UserModel userModel = passData;

    return Scaffold(
        backgroundColor: AppColorUtil.appBlueColor,
        appBar: AppBar(
            leading: const BackButton(color: AppColorUtil.appBlueDarkColor),
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(appLocalizations.raw_sign_up_header,
                style: const TextStyle(color: AppColorUtil.appBlueDarkColor))),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthUserAuthenticated) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteUtil.dashboard, (route) => false);
          }
          if (state is AuthExceptionOccurred) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }, builder: (context, state) {
          return Stack(children: [
            SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child:
                              Text(appLocalizations.raw_sign_up_input_header)),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Image.asset(AssetPathUtil.stepFivePath)),
                      const SizedBox(height: 20),
                      _nickNameWidget(appLocalizations, userModel),
                      const SizedBox(height: 20),
                      _fullNameWidget(appLocalizations, userModel),
                      const SizedBox(height: 20),
                      _kanaFullNameWidget(
                          appLocalizations, userModel.kanaFullName!),
                      const SizedBox(height: 20),
                      _genderWidget(context, appLocalizations, userModel),
                      const SizedBox(height: 20),
                      _addressNote(appLocalizations),
                      const SizedBox(height: 20),
                      _addressInfoListWidget(
                          appLocalizations, userModel.address!),
                      _phoneNumberWidget(appLocalizations, userModel),
                      _linksWidget(appLocalizations, context),
                      _buttonWidget(context, appLocalizations, userModel)
                    ]))),
            if (state is AuthLoading) progressDialog()
          ]);
        }));
  }

  _setUserValue(String? value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(value ?? '')),
      const Divider(thickness: 1, color: Colors.white)
    ]);
  }

  Widget _nickNameWidget(
          AppLocalizations appLocalizations, UserModel userModel) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Text(appLocalizations.raw_common_nick_name),
              Container(
                  color: AppColorUtil.appGreenColor,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(appLocalizations.raw_common_required))
            ])),
        _setUserValue(userModel.fullName?.nickName),
        Text(appLocalizations.raw_common_nick_name_note)
      ]);

  Widget _fullNameWidget(
          AppLocalizations appLocalizations, UserModel userModel) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(appLocalizations.raw_common_full_name)),
          Container(
              color: AppColorUtil.appGreenColor,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(appLocalizations.raw_common_required))
        ]),
        Row(children: [
          Flexible(child: _setUserValue(userModel.fullName?.lastName)),
          const SizedBox(width: 20),
          Flexible(child: _setUserValue(userModel.fullName?.firstName))
        ])
      ]);

  Widget _kanaFullNameWidget(
      AppLocalizations appLocalizations, KanaFullName kanaFullName) {
    return Visibility(
        visible: kanaFullName.firstNameKana.toString().isNotEmpty ||
                kanaFullName.lastNameKana.toString().isNotEmpty
            ? true
            : false,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(appLocalizations.raw_common_full_name_kana)),
          Row(children: [
            Flexible(child: _setUserValue(kanaFullName.lastNameKana)),
            const SizedBox(width: 20),
            Flexible(child: _setUserValue(kanaFullName.firstNameKana))
          ])
        ]));
  }

  Widget _genderWidget(BuildContext context, AppLocalizations appLocalizations,
          UserModel userModel) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(appLocalizations.raw_common_gender),
        FormBuilderSegmentedControl<String>(
            padding: const EdgeInsets.all(0),
            initialValue: userModel.sex,
            name: StringConstants.gender,
            enabled: false,
            selectedColor: AppColorUtil.appBlueDarkColor,
            options: GenderValueUtil()
                .genderList(context)
                .map((gender) => FormBuilderFieldOption(
                    value: gender,
                    child: SizedBox(
                        height: 30, child: Center(child: Text(gender)))))
                .toList(),
            decoration:
                const InputDecoration(border: InputBorder.none, filled: false))
      ]);

  Widget _addressNote(AppLocalizations appLocalizations) => Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Text(appLocalizations.raw_sign_up_input_note_address));

  Widget _addressInfoListWidget(
      AppLocalizations appLocalizations, Address address) {
    var prefecture = address.addressPrefecture ?? '';

    return Column(children: [
      _addressInfoItemWidget(
          addressType: address.postalCode.toString(),
          label: appLocalizations.raw_common_label_address_postal_code),
      _addressInfoItemWidget(
          addressType: prefecture.toString(),
          label: appLocalizations.raw_sign_up_input_label_address_prefecture),
      _addressInfoItemWidget(
          addressType: address.addressCity.toString(),
          label: appLocalizations.raw_common_city),
      _addressInfoItemWidget(
          addressType: address.addressNumber.toString(),
          label: appLocalizations.raw_common_address_number),
      _addressInfoItemWidget(
          addressType: address.addressStructure.toString(),
          label: appLocalizations.raw_common_address_structure)
    ]);
  }

  Widget _addressInfoItemWidget(
      {required String addressType, required String label}) {
    return Visibility(
        visible: addressType.isNotEmpty ? true : false,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(label)),
          _setUserValue(addressType),
          const SizedBox(height: 20)
        ]));
  }

  Widget _phoneNumberWidget(
          AppLocalizations appLocalizations, UserModel userModel) =>
      Visibility(
          visible: userModel.phoneNumber.toString().isNotEmpty ? true : false,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(appLocalizations.raw_common_phone_number)),
            _setUserValue(userModel.phoneNumber.toString())
          ]));

  Widget _linksWidget(
          AppLocalizations appLocalizations, BuildContext context) =>
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Text(appLocalizations.raw_common_about_terms),
                  Container(
                      color: AppColorUtil.appGreenColor,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(appLocalizations.raw_common_required))
                ])),
            itemLinkWidget(
                appLocalizations.raw_common_terms_of_service,
                () =>
                    Navigator.of(context).pushNamed(RouteUtil.termsOfService)),
            itemLinkWidget(appLocalizations.raw_common_privacy,
                () => Navigator.of(context).pushNamed(RouteUtil.privacyPolicy))
          ]));

  Widget _buttonWidget(BuildContext context, AppLocalizations appLocalizations,
          UserModel userModel) =>
      Column(children: [
        Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: 150,
                child: FormBuilderCheckbox(
                    name: StringConstants.agreeCheckBox,
                    initialValue: true,
                    enabled: false,
                    activeColor: Colors.white,
                    title: Text(appLocalizations.raw_common_agreed,
                        style: hintTextStyle.copyWith(
                            color: Colors.white, fontSize: 20))))),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(
                    width: 1, color: AppColorUtil.appBlueDarkColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
            child: Text(appLocalizations.raw_sign_up_prelabel_back,
                style: const TextStyle(
                    fontSize: 22, color: AppColorUtil.appBlueDarkColor))),
        ElevatedButtonWidget(
            label: appLocalizations.raw_common_confirm,
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(UserInfoRegistration(userModel: userModel));
              // UserModel user = userModel;
              // debugPrint('UserModel: ${user.toJson()}');
            })
      ]);
}
