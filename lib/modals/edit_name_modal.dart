import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/models/user.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/services/navigation_service.dart';

class EditNameModal extends StatefulWidget {
  const EditNameModal({Key? key}) : super(key: key);

  @override
  State<EditNameModal> createState() => _EditNameModalState();
}

class _EditNameModalState extends State<EditNameModal> {
  TextEditingController nameTextEditingController = TextEditingController();

  handleChangeProfileStatus(BuildContext context, User? user) {
    if (nameTextEditingController.text.isNotEmpty) {
      context.read<UserBloc>().add(
          UserNameChanged(name: nameTextEditingController.text, user: user!));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => UserBloc()..add(const FetchUserData()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state.actionFetchStatus is ApiFetchSucceededStatus) {
            locator<NavigationService>().pop();
          }
        },
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            constraints: const BoxConstraints(minHeight: 120),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    S.current.add_new_name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                nameTextField(),
                Row(
                  children: [
                    const Spacer(),
                    saveBtn(),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          locator<NavigationService>().pop();
                        },
                        child: Text(S.current.cancel)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saveBtn() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return ElevatedButton(
          onPressed: () {
            handleChangeProfileStatus(context, state.user);
          },
          child: Text(S.current.save));
    });
  }

  Widget nameTextField() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return TextField(
        controller: nameTextEditingController,
        autofocus: true,
        // initialValue: state.user?.profileStatus ?? S.current.not_specified,
        decoration: InputDecoration(
            hintText: state.user?.fullName, border: InputBorder.none),
        onEditingComplete: () {
          handleChangeProfileStatus(context, state.user);
        },
      );
    });
  }
}
