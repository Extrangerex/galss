// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_email {
    return Intl.message(
      '',
      name: 'prompt_email',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_password {
    return Intl.message(
      '',
      name: 'prompt_password',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get action_sign_in {
    return Intl.message(
      '',
      name: 'action_sign_in',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get action_sign_in_short {
    return Intl.message(
      '',
      name: 'action_sign_in_short',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get error_invalid_email {
    return Intl.message(
      '',
      name: 'error_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get error_invalid_password {
    return Intl.message(
      '',
      name: 'error_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get error_field_required {
    return Intl.message(
      '',
      name: 'error_field_required',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get sign_up {
    return Intl.message(
      '',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get signin_form {
    return Intl.message(
      '',
      name: 'signin_form',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get editar_mi_perfil {
    return Intl.message(
      '',
      name: 'editar_mi_perfil',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_all_fields_requeried {
    return Intl.message(
      '',
      name: 'prompt_all_fields_requeried',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get poner_perfil_anonimo {
    return Intl.message(
      '',
      name: 'poner_perfil_anonimo',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get model {
    return Intl.message(
      '',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get home {
    return Intl.message(
      '',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get my_profile {
    return Intl.message(
      '',
      name: 'my_profile',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get close_to_me {
    return Intl.message(
      '',
      name: 'close_to_me',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get model_catalog {
    return Intl.message(
      '',
      name: 'model_catalog',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get my_connections {
    return Intl.message(
      '',
      name: 'my_connections',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get recently_added {
    return Intl.message(
      '',
      name: 'recently_added',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get exit {
    return Intl.message(
      '',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get finder {
    return Intl.message(
      '',
      name: 'finder',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get country {
    return Intl.message(
      '',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_select_country {
    return Intl.message(
      '',
      name: 'prompt_select_country',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get repeat_password {
    return Intl.message(
      '',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_accept_terms_conditions {
    return Intl.message(
      '',
      name: 'prompt_accept_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_must_accept_terms_conditions {
    return Intl.message(
      '',
      name: 'prompt_must_accept_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_passwords_must_match {
    return Intl.message(
      '',
      name: 'prompt_passwords_must_match',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_terms_conditions {
    return Intl.message(
      '',
      name: 'prompt_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_buy_suscription {
    return Intl.message(
      '',
      name: 'prompt_buy_suscription',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get name {
    return Intl.message(
      '',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get lastname {
    return Intl.message(
      '',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get monthly {
    return Intl.message(
      '',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get search {
    return Intl.message(
      '',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get choose_your_subscription {
    return Intl.message(
      '',
      name: 'choose_your_subscription',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get yearly {
    return Intl.message(
      '',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get birthdate {
    return Intl.message(
      '',
      name: 'birthdate',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get congrats {
    return Intl.message(
      '',
      name: 'congrats',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get oops {
    return Intl.message(
      '',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get seeker {
    return Intl.message(
      '',
      name: 'seeker',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_next {
    return Intl.message(
      '',
      name: 'prompt_next',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_are_u_model_or_finder {
    return Intl.message(
      '',
      name: 'prompt_are_u_model_or_finder',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get your_request_was_received_see_you_in_48hr {
    return Intl.message(
      '',
      name: 'your_request_was_received_see_you_in_48hr',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get sign_up_form_for_galss_models {
    return Intl.message(
      '',
      name: 'sign_up_form_for_galss_models',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get fonts_with_asterisk_are_mandatory {
    return Intl.message(
      '',
      name: 'fonts_with_asterisk_are_mandatory',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get current_location {
    return Intl.message(
      '',
      name: 'current_location',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get nationality {
    return Intl.message(
      '',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get annual {
    return Intl.message(
      '',
      name: 'annual',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get montly {
    return Intl.message(
      '',
      name: 'montly',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get add_photo {
    return Intl.message(
      '',
      name: 'add_photo',
      desc: '',
      args: [],
    );
  }

  /// `You have {roomsLength} connections`
  String you_have_n_connections(int roomsLength) {
    return Intl.message(
      'You have $roomsLength connections',
      name: 'you_have_n_connections',
      desc: 'Specify the room quantity',
      args: [roomsLength],
    );
  }

  /// `{targetName}`
  String you_talking_with_n(String targetName) {
    return Intl.message(
      '$targetName',
      name: 'you_talking_with_n',
      desc: 'Specify the name of your chat target',
      args: [targetName],
    );
  }

  /// `Aa`
  String get type_a_message_placeholder {
    return Intl.message(
      'Aa',
      name: 'type_a_message_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `{likesCount} people liked it`
  String liked_by_n_people(int likesCount) {
    return Intl.message(
      '$likesCount people liked it',
      name: 'liked_by_n_people',
      desc: 'Show likes count of a model',
      args: [likesCount],
    );
  }

  /// `{likesCount} people liked you`
  String n_people_liked_you(int likesCount) {
    return Intl.message(
      '$likesCount people liked you',
      name: 'n_people_liked_you',
      desc: 'Show likes count of a model',
      args: [likesCount],
    );
  }

  /// `Unknown city`
  String get unknown_city {
    return Intl.message(
      'Unknown city',
      name: 'unknown_city',
      desc: '',
      args: [],
    );
  }

  /// `Not specified`
  String get not_specified {
    return Intl.message(
      'Not specified',
      name: 'not_specified',
      desc: '',
      args: [],
    );
  }

  /// `Edit your profile`
  String get edit_profile {
    return Intl.message(
      'Edit your profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Switch anonymous mode`
  String get switch_anonymous_mode {
    return Intl.message(
      'Switch anonymous mode',
      name: 'switch_anonymous_mode',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get profile_status {
    return Intl.message(
      'Status',
      name: 'profile_status',
      desc: '',
      args: [],
    );
  }

  /// `Add a new profile status`
  String get add_your_new_state {
    return Intl.message(
      'Add a new profile status',
      name: 'add_your_new_state',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Change current location`
  String get change_current_location {
    return Intl.message(
      'Change current location',
      name: 'change_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Pick city`
  String get pick_a_city {
    return Intl.message(
      'Pick city',
      name: 'pick_a_city',
      desc: '',
      args: [],
    );
  }

  /// `Add a new name`
  String get add_new_name {
    return Intl.message(
      'Add a new name',
      name: 'add_new_name',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get your_likes {
    return Intl.message(
      'Likes',
      name: 'your_likes',
      desc: '',
      args: [],
    );
  }

  /// `Your favorites`
  String get your_favorites {
    return Intl.message(
      'Your favorites',
      name: 'your_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Hey`
  String get greeting {
    return Intl.message(
      'Hey',
      name: 'greeting',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we can't find an account with this email address. Please try again or create a new one`
  String get not_valid_username_password {
    return Intl.message(
      'Sorry, we can\'t find an account with this email address. Please try again or create a new one',
      name: 'not_valid_username_password',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get you_must_specify_country {
    return Intl.message(
      '',
      name: 'you_must_specify_country',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get email_in_use {
    return Intl.message(
      '',
      name: 'email_in_use',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get technically_there_is_nothing_wrong_but {
    return Intl.message(
      '',
      name: 'technically_there_is_nothing_wrong_but',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get error_inactive_account {
    return Intl.message(
      '',
      name: 'error_inactive_account',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get terms_conditions_accept_disclaimer {
    return Intl.message(
      '',
      name: 'terms_conditions_accept_disclaimer',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get prompt_delete_photo {
    return Intl.message(
      '',
      name: 'prompt_delete_photo',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get delete_photo {
    return Intl.message(
      '',
      name: 'delete_photo',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get photo_deleted {
    return Intl.message(
      '',
      name: 'photo_deleted',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get retype_password {
    return Intl.message(
      '',
      name: 'retype_password',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get passwords_must_match {
    return Intl.message(
      '',
      name: 'passwords_must_match',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get invalid_user_password {
    return Intl.message(
      '',
      name: 'invalid_user_password',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
