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

  /// ``
  String get cancel {
    return Intl.message(
      '',
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
