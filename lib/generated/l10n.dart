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

  /// `Log in`
  String get action_sign_in {
    return Intl.message(
      'Log in',
      name: 'action_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Get into`
  String get action_sign_in_short {
    return Intl.message(
      'Get into',
      name: 'action_sign_in_short',
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

  /// `Add a photo`
  String get add_photo {
    return Intl.message(
      'Add a photo',
      name: 'add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Add your state`
  String get add_your_new_state {
    return Intl.message(
      'Add your state',
      name: 'add_your_new_state',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get birthdate {
    return Intl.message(
      'Date of birth',
      name: 'birthdate',
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

  /// `Change your current location`
  String get change_current_location {
    return Intl.message(
      'Change your current location',
      name: 'change_current_location',
      desc: '',
      args: [],
    );
  }

  /// `choose your plan`
  String get choose_your_subscription {
    return Intl.message(
      'choose your plan',
      name: 'choose_your_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Close to me`
  String get close_to_me {
    return Intl.message(
      'Close to me',
      name: 'close_to_me',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations`
  String get congrats {
    return Intl.message(
      'Congratulations',
      name: 'congrats',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Current location`
  String get current_location {
    return Intl.message(
      'Current location',
      name: 'current_location',
      desc: '',
      args: [],
    );
  }

  /// `Delete picture`
  String get delete_photo {
    return Intl.message(
      'Delete picture',
      name: 'delete_photo',
      desc: '',
      args: [],
    );
  }

  /// `Edit my Profile`
  String get editar_mi_perfil {
    return Intl.message(
      'Edit my Profile',
      name: 'editar_mi_perfil',
      desc: '',
      args: [],
    );
  }

  /// `edit your profile`
  String get edit_profile {
    return Intl.message(
      'edit your profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `This email already in use`
  String get email_in_use {
    return Intl.message(
      'This email already in use',
      name: 'email_in_use',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get error_field_required {
    return Intl.message(
      'This field is required',
      name: 'error_field_required',
      desc: '',
      args: [],
    );
  }

  /// `Your account is still inactive. If you have a concern, doubt, complaint or suggestion, you can contact us galssapp@gmail.com`
  String get error_inactive_account {
    return Intl.message(
      'Your account is still inactive. If you have a concern, doubt, complaint or suggestion, you can contact us galssapp@gmail.com',
      name: 'error_inactive_account',
      desc: '',
      args: [],
    );
  }

  /// `This email address is not valid`
  String get error_invalid_email {
    return Intl.message(
      'This email address is not valid',
      name: 'error_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `This password is too short`
  String get error_invalid_password {
    return Intl.message(
      'This password is too short',
      name: 'error_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Go out`
  String get exit {
    return Intl.message(
      'Go out',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Seeker`
  String get finder {
    return Intl.message(
      'Seeker',
      name: 'finder',
      desc: '',
      args: [],
    );
  }

  /// `Fonts that have (*) are required`
  String get fonts_with_asterisk_are_mandatory {
    return Intl.message(
      'Fonts that have (*) are required',
      name: 'fonts_with_asterisk_are_mandatory',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get greeting {
    return Intl.message(
      'Hello',
      name: 'greeting',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get home {
    return Intl.message(
      'Start',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password`
  String get invalid_user_password {
    return Intl.message(
      'Invalid username or password',
      name: 'invalid_user_password',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get language {
    return Intl.message(
      'Spanish',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get lastname {
    return Intl.message(
      'Surname',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `Liked by {likesCount} person(s)`
  String liked_by_n_people(int likesCount) {
    return Intl.message(
      'Liked by $likesCount person(s)',
      name: 'liked_by_n_people',
      desc: 'Muestra la cantidad de likes de una modelo',
      args: [likesCount],
    );
  }

  /// `Model`
  String get model {
    return Intl.message(
      'Model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `Model Catalogs`
  String get model_catalog {
    return Intl.message(
      'Model Catalogs',
      name: 'model_catalog',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `my connections`
  String get my_connections {
    return Intl.message(
      'my connections',
      name: 'my_connections',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get my_profile {
    return Intl.message(
      'My profile',
      name: 'my_profile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
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

  /// `Sorry, we can't find an account with this email address. Please try again or create a new`
  String get not_valid_username_password {
    return Intl.message(
      'Sorry, we can\'t find an account with this email address. Please try again or create a new',
      name: 'not_valid_username_password',
      desc: '',
      args: [],
    );
  }

  /// `You have been liked by {likesCount} people`
  String n_people_liked_you(int likesCount) {
    return Intl.message(
      'You have been liked by $likesCount people',
      name: 'n_people_liked_you',
      desc: 'Muestra la cantidad de likes a una modelo',
      args: [likesCount],
    );
  }

  /// `oops`
  String get oops {
    return Intl.message(
      'oops',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must match`
  String get passwords_must_match {
    return Intl.message(
      'Passwords must match',
      name: 'passwords_must_match',
      desc: '',
      args: [],
    );
  }

  /// `you deleted this photo`
  String get photo_deleted {
    return Intl.message(
      'you deleted this photo',
      name: 'photo_deleted',
      desc: '',
      args: [],
    );
  }

  /// `select a city`
  String get pick_a_city {
    return Intl.message(
      'select a city',
      name: 'pick_a_city',
      desc: '',
      args: [],
    );
  }

  /// `Put Anonymous Profile`
  String get poner_perfil_anonimo {
    return Intl.message(
      'Put Anonymous Profile',
      name: 'poner_perfil_anonimo',
      desc: '',
      args: [],
    );
  }

  /// `Condition`
  String get profile_status {
    return Intl.message(
      'Condition',
      name: 'profile_status',
      desc: '',
      args: [],
    );
  }

  /// `I accept the terms and conditions`
  String get prompt_accept_terms_conditions {
    return Intl.message(
      'I accept the terms and conditions',
      name: 'prompt_accept_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required`
  String get prompt_all_fields_requeried {
    return Intl.message(
      'All fields are required',
      name: 'prompt_all_fields_requeried',
      desc: '',
      args: [],
    );
  }

  /// `Annual`
  String get prompt_annual {
    return Intl.message(
      'Annual',
      name: 'prompt_annual',
      desc: '',
      args: [],
    );
  }

  /// `Are you a model or\n a model finder?`
  String get prompt_are_u_model_or_finder {
    return Intl.message(
      'Are you a model or\n a model finder?',
      name: 'prompt_are_u_model_or_finder',
      desc: '',
      args: [],
    );
  }

  /// `Buy subscription`
  String get prompt_buy_suscription {
    return Intl.message(
      'Buy subscription',
      name: 'prompt_buy_suscription',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this photo?`
  String get prompt_delete_photo {
    return Intl.message(
      'Are you sure you want to delete this photo?',
      name: 'prompt_delete_photo',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get prompt_email {
    return Intl.message(
      'Email',
      name: 'prompt_email',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get prompt_monthly {
    return Intl.message(
      'Monthly',
      name: 'prompt_monthly',
      desc: '',
      args: [],
    );
  }

  /// `You must agree to terms and conditions`
  String get prompt_must_accept_terms_conditions {
    return Intl.message(
      'You must agree to terms and conditions',
      name: 'prompt_must_accept_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get prompt_next {
    return Intl.message(
      'Continue',
      name: 'prompt_next',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get prompt_password {
    return Intl.message(
      'Password',
      name: 'prompt_password',
      desc: '',
      args: [],
    );
  }

  /// `passwords must match`
  String get prompt_passwords_must_match {
    return Intl.message(
      'passwords must match',
      name: 'prompt_passwords_must_match',
      desc: '',
      args: [],
    );
  }

  /// `Select a country`
  String get prompt_select_country {
    return Intl.message(
      'Select a country',
      name: 'prompt_select_country',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get prompt_terms_conditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'prompt_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Recently Added`
  String get recently_added {
    return Intl.message(
      'Recently Added',
      name: 'recently_added',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get repeat_password {
    return Intl.message(
      'Repeat password',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get retype_password {
    return Intl.message(
      'Repeat password',
      name: 'retype_password',
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

  /// `Seek`
  String get search {
    return Intl.message(
      'Seek',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Seeker`
  String get seeker {
    return Intl.message(
      'Seeker',
      name: 'seeker',
      desc: '',
      args: [],
    );
  }

  /// `Login Form`
  String get signin_form {
    return Intl.message(
      'Login Form',
      name: 'signin_form',
      desc: '',
      args: [],
    );
  }

  /// `Check in`
  String get sign_up {
    return Intl.message(
      'Check in',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Application Form for Galss Models`
  String get sign_up_form_for_galss_models {
    return Intl.message(
      'Application Form for Galss Models',
      name: 'sign_up_form_for_galss_models',
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

  /// `put anonymous profile`
  String get switch_anonymous_mode {
    return Intl.message(
      'put anonymous profile',
      name: 'switch_anonymous_mode',
      desc: '',
      args: [],
    );
  }

  /// `Technically there is nothing wrong, but something does not add up`
  String get technically_there_is_nothing_wrong_but {
    return Intl.message(
      'Technically there is nothing wrong, but something does not add up',
      name: 'technically_there_is_nothing_wrong_but',
      desc: '',
      args: [],
    );
  }

  /// `By checking this box, I confirm that I have read and agree to be bound by the terms and conditions policy.`
  String get terms_conditions_accept_disclaimer {
    return Intl.message(
      'By checking this box, I confirm that I have read and agree to be bound by the terms and conditions policy.',
      name: 'terms_conditions_accept_disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `oh`
  String get type_a_message_placeholder {
    return Intl.message(
      'oh',
      name: 'type_a_message_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `unknown city`
  String get unknown_city {
    return Intl.message(
      'unknown city',
      name: 'unknown_city',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully created an account.`
  String get user_seeker_registered {
    return Intl.message(
      'You have successfully created an account.',
      name: 'user_seeker_registered',
      desc: '',
      args: [],
    );
  }

  /// `Annuals`
  String get yearly {
    return Intl.message(
      'Annuals',
      name: 'yearly',
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

  /// `You have {roomsLength} connection(s)`
  String you_have_n_connections(int roomsLength) {
    return Intl.message(
      'You have $roomsLength connection(s)',
      name: 'you_have_n_connections',
      desc: 'Especificar la cantidad de chats',
      args: [roomsLength],
    );
  }

  /// `You must enter your country of origin`
  String get you_must_specify_country {
    return Intl.message(
      'You must enter your country of origin',
      name: 'you_must_specify_country',
      desc: '',
      args: [],
    );
  }

  /// `your favorites`
  String get your_favorites {
    return Intl.message(
      'your favorites',
      name: 'your_favorites',
      desc: '',
      args: [],
    );
  }

  /// `your likes`
  String get your_likes {
    return Intl.message(
      'your likes',
      name: 'your_likes',
      desc: '',
      args: [],
    );
  }

  /// `Your request was received correctly.\n Before 48 hours we will be\n confirming.`
  String get your_request_was_received_see_you_in_48hr {
    return Intl.message(
      'Your request was received correctly.\n Before 48 hours we will be\n confirming.',
      name: 'your_request_was_received_see_you_in_48hr',
      desc: '',
      args: [],
    );
  }

  /// `{targetName}`
  String you_talking_with_n(String targetName) {
    return Intl.message(
      '$targetName',
      name: 'you_talking_with_n',
      desc: 'Especificar el nombre del usuario con quien hablas',
      args: [targetName],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'pt'),
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
