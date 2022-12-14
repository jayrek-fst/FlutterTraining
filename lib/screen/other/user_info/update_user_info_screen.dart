import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fumiya_flutter/domain/use_case/user_use_case.dart';
import 'package:fumiya_flutter/widget/common_widget.dart';
import '../../../business_logic/bloc/user_bloc/user_bloc.dart';
import '../../../data/model/user_model.dart';
import '../../../util/app_color_util.dart';
import '../../../util/gender_value_util.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/alert_dialog_widget.dart';
import '../../../widget/elevated_button_widget.dart';
import '../../../widget/text_form_field_widget.dart';

class UpdateUserInfoScreen extends StatelessWidget {
  UpdateUserInfoScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final userBloc = UserBloc(userUseCase: UserUseCase());

  @override
  Widget build(BuildContext context) {
    userBloc.add(GetUserInfo());
    var appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
            title: Text(appLocalizations.raw_update_user_info_screen_title,
                style: appBarTitleTextStyle)),
        body: BlocConsumer<UserBloc, UserState>(
            bloc: userBloc,
            listener: (context, state) {
              // if (state is UserActionSuccess) {
              //   _showDialog(context, 'updated success', 'success', actions: [
              //     TextButton(
              //         onPressed: () => Navigator.of(context).pop(),
              //         child: Text(appLocalizations.raw_common_dialog_button_no)),
              //     TextButton(
              //         onPressed: () {
              //           Navigator.of(context).pop();
              //         },
              //         child: Text(appLocalizations.raw_common_dialog_button_yes))
              //   ]);
              // }
              // if (state is ExceptionOccurred) {
              //   ScaffoldMessenger.of(context)
              //       .showSnackBar(SnackBar(content: Text(state.message)));
              // }
            },
            builder: (context, state) {
              if (state is UserActionSuccess) {
                _showDialog(context, 'updated success', 'success', actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child:
                          Text(appLocalizations.raw_common_dialog_button_no)),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child:
                          Text(appLocalizations.raw_common_dialog_button_yes))
                ]);
              }
              if (state is ExceptionOccurred) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is UserInformationLoaded) {
                final user = state.userModel;
                debugPrint('user: $user');
                return Stack(children: [
                  SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FormBuilder(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 30),
                                        child: Text(
                                            appLocalizations
                                                .raw_update_user_info_screen_title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    _nickNameWidget(appLocalizations,
                                        user.fullName!.nickName.toString()),
                                    const SizedBox(height: 20),
                                    _fullNameWidget(
                                        appLocalizations,
                                        user.fullName!.lastName.toString(),
                                        user.fullName!.firstName.toString()),
                                    const SizedBox(height: 20),
                                    _kanaFullNameWidget(
                                        appLocalizations,
                                        user.kanaFullName!.lastNameKana
                                            .toString(),
                                        user.kanaFullName!.firstNameKana
                                            .toString()),
                                    const SizedBox(height: 20),

                                    ///birthdate here

                                    _genderWidget(context, appLocalizations,
                                        user.sex.toString()),
                                    const SizedBox(height: 20),
                                    _addressNote(appLocalizations),
                                    const SizedBox(height: 20),
                                    _postalCodeWidget(appLocalizations,
                                        user.address!.postalCode.toString()),
                                    const SizedBox(height: 20),
                                    _prefectureWidget(
                                        appLocalizations,
                                        user.address!.addressPrefecture
                                            .toString()),
                                    const SizedBox(height: 20),
                                    _cityWidget(appLocalizations,
                                        user.address!.addressCity.toString()),
                                    const SizedBox(height: 20),
                                    _addressNumberWidget(appLocalizations,
                                        user.address!.addressNumber.toString()),
                                    const SizedBox(height: 20),
                                    _addressStructureWidget(
                                        appLocalizations,
                                        user.address!.addressStructure
                                            .toString()),
                                    const SizedBox(height: 20),
                                    _phoneNumberWidget(appLocalizations,
                                        user.phoneNumber.toString()),
                                    ElevatedButtonWidget(
                                        label:
                                            appLocalizations.raw_common_confirm,
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .saveAndValidate()) {
                                            FocusScope.of(context).unfocus();
                                            context.read<UserBloc>().add(
                                                UpdateUserInfo(
                                                    userModel:
                                                        updatedUserModel()));
                                          }
                                        })
                                  ]))))),
                  if (state is Loading) progressDialog()
                ]);
              }
              return Container();
            }));
  }

  _nickNameWidget(AppLocalizations appLocalizations, String nickName) =>
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
        TextFormFieldWidget(
            initialValue: nickName,
            name: StringConstants.nickName,
            textInputType: TextInputType.text,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: appLocalizations.raw_invalid_nickname_empty)
            ])),
        Text(appLocalizations.raw_common_nick_name_note)
      ]);

  _fullNameWidget(AppLocalizations appLocalizations, String lastName,
          String firstName) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Text(appLocalizations.raw_common_full_name),
              Container(
                  color: AppColorUtil.appGreenColor,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(appLocalizations.raw_common_required))
            ])),
        Row(children: [
          Flexible(
              child: TextFormFieldWidget(
                  initialValue: lastName,
                  hint: appLocalizations.raw_sign_up_input_hint_last_name,
                  name: StringConstants.lastName,
                  textInputType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: appLocalizations.raw_invalid_lastname_empty)
                  ]))),
          const SizedBox(width: 20),
          Flexible(
              child: TextFormFieldWidget(
                  initialValue: firstName,
                  hint: appLocalizations.raw_sign_up_input_hint_first_name,
                  name: StringConstants.firstName,
                  textInputType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: appLocalizations.raw_invalid_firstname_empty)
                  ])))
        ])
      ]);

  _kanaFullNameWidget(AppLocalizations appLocalizations, String kanaLastName,
          String kanaFirstName) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_full_name_kana)),
        Row(children: [
          Flexible(
              child: TextFormFieldWidget(
                  initialValue: kanaLastName,
                  name: StringConstants.kanaLastName,
                  textInputType: TextInputType.text)),
          const SizedBox(width: 20),
          Flexible(
              child: TextFormFieldWidget(
                  initialValue: kanaFirstName,
                  name: StringConstants.kanaFirstName,
                  textInputType: TextInputType.text))
        ])
      ]);

  _genderWidget(
      BuildContext context, AppLocalizations appLocalizations, String gender) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(appLocalizations.raw_common_gender),
      FormBuilderSegmentedControl<String>(
          padding: const EdgeInsets.all(0),
          initialValue: GenderValueUtil()
              .genderList(context)[StringConstants.genderList.indexOf(gender)],
          name: StringConstants.gender,
          selectedColor: AppColorUtil.appBlueDarkColor,
          options: GenderValueUtil()
              .genderList(context)
              .map((gender) => FormBuilderFieldOption(
                  value: gender,
                  child:
                      SizedBox(height: 30, child: Center(child: Text(gender)))))
              .toList(),
          decoration:
              const InputDecoration(border: InputBorder.none, filled: false))
    ]);
  }

  _addressNote(AppLocalizations appLocalizations) => Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Text(appLocalizations.raw_sign_up_input_note_address));

  _postalCodeWidget(AppLocalizations appLocalizations, String postalCode) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_label_address_postal_code)),
        TextFormFieldWidget(
            initialValue: postalCode,
            hint: appLocalizations.raw_sign_up_input_hint_postal,
            name: StringConstants.postalCode,
            textInputType: TextInputType.number)
      ]);

  _prefectureWidget(AppLocalizations appLocalizations, String prefecture) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
              appLocalizations.raw_sign_up_input_label_address_prefecture)),
      FormBuilderDropdown(
          initialValue: prefecture.isNotEmpty
              ? StringConstants.prefectureList[
                  StringConstants.prefectureList.indexOf(prefecture)]
              : null,
          name: StringConstants.prefecture,
          isExpanded: false,
          items: StringConstants.prefectureList
              .map((prefecture) =>
                  DropdownMenuItem(value: prefecture, child: Text(prefecture)))
              .toList(),
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintStyle: hintTextStyle,
              hintText:
                  appLocalizations.raw_sign_up_input_hint_address_prefecture))
    ]);
  }

  _cityWidget(AppLocalizations appLocalizations, String city) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_city)),
        TextFormFieldWidget(
            initialValue: city,
            hint: appLocalizations.raw_sign_up_input_hint_address_city,
            name: StringConstants.city,
            textInputType: TextInputType.streetAddress)
      ]);

  _addressNumberWidget(
          AppLocalizations appLocalizations, String addressNumber) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_address_number)),
        TextFormFieldWidget(
            initialValue: addressNumber,
            hint: appLocalizations.raw_sign_up_input_hint_address_number,
            name: StringConstants.addressNumber,
            textInputType: TextInputType.streetAddress)
      ]);

  _addressStructureWidget(
          AppLocalizations appLocalizations, String addressStructure) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_address_structure)),
        TextFormFieldWidget(
            initialValue: addressStructure,
            hint: appLocalizations.raw_sign_up_input_hint_address_structure,
            name: StringConstants.addressStructure,
            textInputType: TextInputType.streetAddress)
      ]);

  _phoneNumberWidget(AppLocalizations appLocalizations, String phone) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_phone_number)),
        TextFormFieldWidget(
            initialValue: phone,
            hint: appLocalizations.raw_sign_up_input_hint_phone_number,
            name: StringConstants.phoneNumber,
            textInputType: TextInputType.phone)
      ]);

  UserModel updatedUserModel() {
    return UserModel(
        fullName: FullName(
            nickName: _formKey.currentState?.value[StringConstants.nickName],
            firstName: _formKey.currentState?.value[StringConstants.firstName],
            lastName: _formKey.currentState?.value[StringConstants.lastName]),
        kanaFullName: KanaFullName(
            firstNameKana:
                _formKey.currentState?.value[StringConstants.kanaFirstName],
            lastNameKana:
                _formKey.currentState?.value[StringConstants.kanaLastName]),
        sex: _formKey.currentState?.value[StringConstants.gender],
        phoneNumber: _formKey.currentState?.value[StringConstants.phoneNumber],
        address: Address(
            postalCode:
                _formKey.currentState?.value[StringConstants.postalCode],
            addressPrefecture:
                _formKey.currentState?.value[StringConstants.prefecture],
            addressCity: _formKey.currentState?.value[StringConstants.city],
            addressNumber:
                _formKey.currentState?.value[StringConstants.addressNumber],
            addressStructure: _formKey
                .currentState?.value[StringConstants.addressStructure]));
  }

  Future _showDialog(BuildContext context, String title, String message,
      {List<Widget>? actions}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialogWidget(
            title: title, message: message, widgetActions: actions));
  }
}
