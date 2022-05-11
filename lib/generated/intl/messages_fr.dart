// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(likesCount) => "Aimé par ${likesCount} personne(s)";

  static String m1(likesCount) =>
      "Vous avez été aimé par ${likesCount} personnes";

  static String m2(roomsLength) => "Vous avez ${roomsLength} connexion(s)";

  static String m3(targetName) => "${targetName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "action_sign_in":
            MessageLookupByLibrary.simpleMessage("Commencer la session"),
        "action_sign_in_short":
            MessageLookupByLibrary.simpleMessage("Entrer dans"),
        "add_new_name":
            MessageLookupByLibrary.simpleMessage("Ajouter un nouveau nom"),
        "add_photo": MessageLookupByLibrary.simpleMessage("Ajouter une photo"),
        "add_your_new_state":
            MessageLookupByLibrary.simpleMessage("Ajoutez votre état"),
        "birthdate": MessageLookupByLibrary.simpleMessage("Date de naissance"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "change_current_location": MessageLookupByLibrary.simpleMessage(
            "Modifier votre emplacement actuel"),
        "choose_your_subscription":
            MessageLookupByLibrary.simpleMessage("choisissez votre forfait"),
        "close_to_me": MessageLookupByLibrary.simpleMessage("Près de moi"),
        "congrats":
            MessageLookupByLibrary.simpleMessage("Toutes nos félicitations"),
        "country": MessageLookupByLibrary.simpleMessage("Pays"),
        "current_location":
            MessageLookupByLibrary.simpleMessage("Situation actuelle"),
        "delete_photo":
            MessageLookupByLibrary.simpleMessage("Supprimer l\'image"),
        "edit_profile":
            MessageLookupByLibrary.simpleMessage("Modifier votre profil"),
        "editar_mi_perfil":
            MessageLookupByLibrary.simpleMessage("Modifier mon profil"),
        "email_in_use":
            MessageLookupByLibrary.simpleMessage("Cet e-mail est déjà utilisé"),
        "error_field_required":
            MessageLookupByLibrary.simpleMessage("Ce champ est obligatoire"),
        "error_inactive_account": MessageLookupByLibrary.simpleMessage(
            "Votre compte est toujours inactif. Si vous avez une préoccupation, un doute, une plainte ou une suggestion, vous pouvez nous contacter galssapp@gmail.com"),
        "error_invalid_email": MessageLookupByLibrary.simpleMessage(
            "Cette adresse e-mail n\'est pas valide"),
        "error_invalid_password": MessageLookupByLibrary.simpleMessage(
            "Ce mot de passe est trop court"),
        "exit": MessageLookupByLibrary.simpleMessage("sortir"),
        "finder": MessageLookupByLibrary.simpleMessage("Chercheur"),
        "fonts_with_asterisk_are_mandatory":
            MessageLookupByLibrary.simpleMessage(
                "Les polices qui ont (*) sont obligatoires"),
        "greeting": MessageLookupByLibrary.simpleMessage("Salut"),
        "home": MessageLookupByLibrary.simpleMessage("Début"),
        "invalid_user_password": MessageLookupByLibrary.simpleMessage(
            "Nom d\'utilisateur ou mot de passe invalide"),
        "language": MessageLookupByLibrary.simpleMessage("Espagnol"),
        "lastname": MessageLookupByLibrary.simpleMessage("Le nom"),
        "liked_by_n_people": m0,
        "model": MessageLookupByLibrary.simpleMessage("Modèle"),
        "model_catalog":
            MessageLookupByLibrary.simpleMessage("Catalogues de modèles"),
        "monthly": MessageLookupByLibrary.simpleMessage("Mensuel"),
        "my_connections": MessageLookupByLibrary.simpleMessage("mes relations"),
        "my_profile": MessageLookupByLibrary.simpleMessage("Mon profil"),
        "n_people_liked_you": m1,
        "name": MessageLookupByLibrary.simpleMessage("nom"),
        "nationality": MessageLookupByLibrary.simpleMessage("Nationalité"),
        "not_specified": MessageLookupByLibrary.simpleMessage("Indéterminé"),
        "not_valid_username_password": MessageLookupByLibrary.simpleMessage(
            "Désolé, nous ne trouvons pas de compte avec cette adresse e-mail. Veuillez réessayer ou créer un nouveau"),
        "oops": MessageLookupByLibrary.simpleMessage("Oups"),
        "passwords_must_match": MessageLookupByLibrary.simpleMessage(
            "Les mots de passe doivent correspondre"),
        "photo_deleted":
            MessageLookupByLibrary.simpleMessage("tu as supprimé cette photo"),
        "pick_a_city":
            MessageLookupByLibrary.simpleMessage("sélectionner une ville"),
        "poner_perfil_anonimo":
            MessageLookupByLibrary.simpleMessage("Mettre un profil anonyme"),
        "profile_status": MessageLookupByLibrary.simpleMessage("État"),
        "prompt_accept_terms_conditions": MessageLookupByLibrary.simpleMessage(
            "J\'accepte les termes et conditions"),
        "prompt_all_fields_requeried":
            MessageLookupByLibrary.simpleMessage("Tous les champs sont requis"),
        "prompt_annual": MessageLookupByLibrary.simpleMessage("Annuel"),
        "prompt_are_u_model_or_finder": MessageLookupByLibrary.simpleMessage(
            "Êtes-vous un modèle ou\n un chercheur de modèle?"),
        "prompt_buy_suscription":
            MessageLookupByLibrary.simpleMessage("Acheter un abonnement"),
        "prompt_delete_photo": MessageLookupByLibrary.simpleMessage(
            "Etes-vous sûr de vouloir supprimer cette photo?"),
        "prompt_email":
            MessageLookupByLibrary.simpleMessage("Courrier électronique"),
        "prompt_monthly": MessageLookupByLibrary.simpleMessage("Mensuel"),
        "prompt_must_accept_terms_conditions":
            MessageLookupByLibrary.simpleMessage(
                "Vous devez accepter les termes et conditions"),
        "prompt_next": MessageLookupByLibrary.simpleMessage("continuer"),
        "prompt_password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "prompt_passwords_must_match": MessageLookupByLibrary.simpleMessage(
            "Les mots de passe doivent correspondre"),
        "prompt_select_country":
            MessageLookupByLibrary.simpleMessage("Choisissez un pays"),
        "prompt_terms_conditions":
            MessageLookupByLibrary.simpleMessage("Termes et conditions"),
        "recently_added":
            MessageLookupByLibrary.simpleMessage("Récemment ajouté"),
        "repeat_password":
            MessageLookupByLibrary.simpleMessage("Répéter le mot de passe"),
        "retype_password":
            MessageLookupByLibrary.simpleMessage("Répéter le mot de passe"),
        "save": MessageLookupByLibrary.simpleMessage("sauvegarder"),
        "search": MessageLookupByLibrary.simpleMessage("Chercher"),
        "seeker": MessageLookupByLibrary.simpleMessage("Chercheur"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Enregistrement"),
        "sign_up_form_for_galss_models": MessageLookupByLibrary.simpleMessage(
            "Formulaire de demande pour les modèles Galss"),
        "signin_form":
            MessageLookupByLibrary.simpleMessage("Formulaire de connexion"),
        "something_went_wrong": MessageLookupByLibrary.simpleMessage(
            "Quelque chose s\'est mal passé"),
        "switch_anonymous_mode":
            MessageLookupByLibrary.simpleMessage("mettre un profil anonyme"),
        "technically_there_is_nothing_wrong_but":
            MessageLookupByLibrary.simpleMessage(
                "Techniquement, il n\'y a rien de mal, mais quelque chose ne colle pas"),
        "terms_conditions_accept_disclaimer": MessageLookupByLibrary.simpleMessage(
            "En cochant cette case, je confirme avoir lu et accepté d\'être lié par la politique des termes et conditions."),
        "type_a_message_placeholder":
            MessageLookupByLibrary.simpleMessage("oh"),
        "unknown_city": MessageLookupByLibrary.simpleMessage("ville inconnue"),
        "user_seeker_registered": MessageLookupByLibrary.simpleMessage(
            "Vous avez créé un compte avec succès."),
        "yearly": MessageLookupByLibrary.simpleMessage("Annuelles"),
        "yes": MessageLookupByLibrary.simpleMessage("Oui"),
        "you_have_n_connections": m2,
        "you_must_specify_country": MessageLookupByLibrary.simpleMessage(
            "Vous devez entrer votre pays d\'origine"),
        "you_talking_with_n": m3,
        "your_favorites": MessageLookupByLibrary.simpleMessage("vos favoris"),
        "your_likes": MessageLookupByLibrary.simpleMessage("vos goûts"),
        "your_request_was_received_see_you_in_48hr":
            MessageLookupByLibrary.simpleMessage(
                "Votre demande a bien été reçue.\n Avant 48 heures nous serons\n confirmant.")
      };
}
