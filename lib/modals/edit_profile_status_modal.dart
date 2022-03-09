import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/services/navigation_service.dart';

class EditProfileStatusModal extends StatefulWidget {
  const EditProfileStatusModal({Key? key}) : super(key: key);

  @override
  State<EditProfileStatusModal> createState() => _EditProfileStatusModalState();
}

class _EditProfileStatusModalState extends State<EditProfileStatusModal> {
  TextEditingController profileStatusTextEditingController =
      TextEditingController();

  handleChangeProfileStatus(BuildContext context) {
    if (profileStatusTextEditingController.text.isNotEmpty) {
      context.read<UserBloc>().add(UserProfileStatusChanged(
          profileStatus: profileStatusTextEditingController.text));
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
                    S.current.add_your_new_state,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                profileStatusTextField(),
                Row(
                  children: [
                    const Spacer(),
                    BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                      return TextButton(
                          onPressed: () {
                            handleChangeProfileStatus(context);
                          },
                          child: Text(S.current.save));
                    }),
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

  Widget profileStatusTextField() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return TextField(
        controller: profileStatusTextEditingController,
        autofocus: true,
        // initialValue: state.user?.profileStatus ?? S.current.not_specified,
        decoration: InputDecoration(
            hintText: state.user?.profileStatus, border: InputBorder.none),
        onEditingComplete: () {
          handleChangeProfileStatus(context);
        },
      );
    });
  }
}
