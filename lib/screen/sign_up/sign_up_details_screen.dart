import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fumiya_flutter/data/model/user_model.dart';
import '../../util/app_color_util.dart';
import '../../util/gender_value_util.dart';
import '../../util/image_path_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../util/style_util.dart';
import '../../widget/common_widget.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class SignUpDetailsScreen extends StatelessWidget {
  SignUpDetailsScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: AppColorUtil.appBlueColor,
        appBar: AppBar(
            leading: const BackButton(color: AppColorUtil.appBlueDarkColor),
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(appLocalizations.raw_sign_up_header,
                style: const TextStyle(color: AppColorUtil.appBlueDarkColor))),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
          Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(appLocalizations.raw_sign_up_input_header)),
          Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Image.asset(ImagePathUtil.stepFourPath)),
          const SizedBox(height: 20),
          FormBuilder(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _nickNameWidget(appLocalizations),
                      const SizedBox(height: 20),
                      _fullNameWidget(appLocalizations),
                      const SizedBox(height: 20),
                      _kanaFullNameWidget(appLocalizations),
                      const SizedBox(height: 20),

                      ///birthdate here

                      _genderWidget(context, appLocalizations),
                      const SizedBox(height: 20),
                      _addressNote(appLocalizations),
                      const SizedBox(height: 20),
                      _postalCodeWidget(appLocalizations),
                      const SizedBox(height: 20),
                      _prefectureWidget(appLocalizations),
                      const SizedBox(height: 20),
                      _cityWidget(appLocalizations),
                      const SizedBox(height: 20),
                      _addressNumberWidget(appLocalizations),
                      const SizedBox(height: 20),
                      _addressStructureWidget(appLocalizations),
                      const SizedBox(height: 20),
                      _phoneNumberWidget(appLocalizations),
                      _linksWidget(appLocalizations),
                      _buttonWidget(context, appLocalizations)
                    ]))
        ]),
            )));
  }

  _nickNameWidget(AppLocalizations appLocalizations) =>
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
            name: StringConstants.nickName,
            textInputType: TextInputType.text,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: appLocalizations.raw_invalid_nickname_empty)
            ])),
        Text(appLocalizations.raw_common_nick_name_note)
      ]);

  _fullNameWidget(AppLocalizations appLocalizations) =>
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
                  hint: appLocalizations.raw_sign_up_input_hint_first_name,
                  name: StringConstants.firstName,
                  textInputType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: appLocalizations.raw_invalid_firstname_empty)
                  ])))
        ])
      ]);

  _kanaFullNameWidget(AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_full_name_kana)),
        Row(children: const [
          Flexible(
              child: TextFormFieldWidget(
                  name: StringConstants.kanaLastName,
                  textInputType: TextInputType.text)),
          SizedBox(width: 20),
          Flexible(
              child: TextFormFieldWidget(
                  name: StringConstants.kanaFirstName,
                  textInputType: TextInputType.text))
        ])
      ]);

  _genderWidget(BuildContext context, AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(appLocalizations.raw_common_gender),
        FormBuilderSegmentedControl<String>(
            padding: const EdgeInsets.all(0),
            initialValue: GenderValueUtil().genderList(context).asMap()[2],
            name: StringConstants.gender,
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

  _addressNote(AppLocalizations appLocalizations) => Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Text(appLocalizations.raw_sign_up_input_note_address));

  _postalCodeWidget(AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_label_address_postal_code)),
        TextFormFieldWidget(
            hint: appLocalizations.raw_sign_up_input_hint_postal,
            name: StringConstants.postalCode,
            textInputType: TextInputType.number)
      ]);

  _prefectureWidget(AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
                appLocalizations.raw_sign_up_input_label_address_prefecture)),
        FormBuilderDropdown(
            name: StringConstants.prefecture,
            isExpanded: false,
            items: StringConstants.prefectureList
                .map((prefecture) => DropdownMenuItem(
                    value: prefecture, child: Text(prefecture)))
                .toList(),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintStyle: hintTextStyle,
                hintText:
                    appLocalizations.raw_sign_up_input_hint_address_prefecture))
      ]);

  _cityWidget(AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_city)),
        TextFormFieldWidget(
            hint: appLocalizations.raw_sign_up_input_hint_address_city,
            name: StringConstants.city,
            textInputType: TextInputType.streetAddress)
      ]);

  _addressNumberWidget(AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_address_number)),
        TextFormFieldWidget(
            hint: appLocalizations.raw_sign_up_input_hint_address_number,
            name: StringConstants.addressNumber,
            textInputType: TextInputType.streetAddress)
      ]);

  _addressStructureWidget(AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_address_structure)),
        TextFormFieldWidget(
            hint: appLocalizations.raw_sign_up_input_hint_address_structure,
            name: StringConstants.addressStructure,
            textInputType: TextInputType.streetAddress)
      ]);

  _phoneNumberWidget(AppLocalizations appLocalizations) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(appLocalizations.raw_common_phone_number)),
        TextFormFieldWidget(
            hint: appLocalizations.raw_sign_up_input_hint_phone_number,
            name: StringConstants.phoneNumber,
            textInputType: TextInputType.phone)
      ]);

  _linksWidget(AppLocalizations appLocalizations) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(children: [
              Text(appLocalizations.raw_common_about_terms),
              Container(
                  color: AppColorUtil.appGreenColor,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(appLocalizations.raw_common_required))
            ])),
        itemLinkWidget(appLocalizations.raw_common_terms_of_service, () {}),
        itemLinkWidget(appLocalizations.raw_common_privacy, () {})
      ]));

  _buttonWidget(BuildContext context, AppLocalizations appLocalizations) =>
      Column(children: [
        Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: 150,
                child: FormBuilderCheckbox(
                    name: StringConstants.agreeCheckBox,
                    initialValue: false,
                    activeColor: Colors.white,
                    title: Text(appLocalizations.raw_sign_up_input_label_accept,
                        style: hintTextStyle.copyWith(
                            color: Colors.white, fontSize: 20)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.equal(true,
                          errorText: appLocalizations
                              .raw_validation_invalid_agree_terms)
                    ])))),
        ElevatedButtonWidget(
            label: appLocalizations.raw_common_confirm,
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pushNamed(
                    RouteUtil.signUpDetailsConfirmation,
                    arguments: _passUserInfoToConfirm());
              }
            })
      ]);

  UserModel _passUserInfoToConfirm() {
    return UserModel(
        uid: 'testuid',
        fullName: FullName(
            nickName: _formKey.currentState?.value[StringConstants.nickName],
            firstName: _formKey.currentState?.value[StringConstants.firstName],
            lastName: _formKey.currentState?.value[StringConstants.lastName]),
        kanaFullName: KanaFullName(
            firstNameKana:
                checkValueNotNull(StringConstants.kanaFirstName).toString(),
            lastNameKana:
                checkValueNotNull(StringConstants.kanaLastName).toString()),
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

  String checkValueNotNull(String? value) {
    return _formKey.currentState != null
        ? _formKey.currentState?.value[value]
        : '';
  }
}
