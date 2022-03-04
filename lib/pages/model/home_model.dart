import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/home_model/home_model_bloc.dart';
import 'package:galss/blocs/navigation/navigation_bloc.dart';
import 'package:galss/blocs/navigation/navigation_event.dart';
import 'package:galss/blocs/navigation/navigation_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/pages/model/home_model_connections.dart';
import 'package:galss/pages/model/home_model_landing.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/cached_circle_avatar.dart';
import 'package:galss/shared/drawer_list_item.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/variables.dart';

import '../../main.dart';

class HomeModel extends StatefulWidget {
  const HomeModel({Key? key}) : super(key: key);

  @override
  _HomeModelState createState() => _HomeModelState();
}

class _HomeModelState extends State<HomeModel> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NavigationBloc()
              ..add(const DrawerWidgetChangedEvent(
                  newIndex: 2, newWidget: HomeModelConnections()))),
        BlocProvider(create: (context) => HomeModelBloc()),
        BlocProvider(
          create: (context) => UserBloc()..add(const FetchUserData()),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async => false,
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          return Scaffold(
            drawer: _drawer(),
            body: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                if (state.navigationWidget == null) {
                  return const CircularProgressIndicator();
                }

                return state.navigationWidget!;
              },
            ),
            onDrawerChanged: (isOpened) {
              if (isOpened) {
                context.read<UserBloc>().add(const FetchUserData());
              }
            },
            appBar: AppBar(
              backgroundColor: toolbarColor,
              centerTitle: true,
              title: const Image(
                image: logo,
                width: 50,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      locator<NavigationService>()
                          .navigatorKey
                          .currentState
                          ?.push(MaterialPageRoute(
                              builder: (builder) =>
                                  const HomeModelConnections()));
                    },
                    icon: const Icon(Icons.chat))
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget header() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return UserAccountsDrawerHeader(
          accountName: Text(state.user?.fullName ?? S.current.not_specified),
          accountEmail: null,
          currentAccountPicture: CachedCircleAvatar(
            url:
                "${HttpService.apiBaseUrl}/${state.user?.profilePhoto?.urlPath}",
          ),
        );
      },
    );
  }

  Widget _drawer() {
    return Drawer(
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          var index = state.navigationIndex;

          return ListView(
            children: [
              header(),
              DrawerListItem(
                label: S.current.home,
                selected: index == 0,
                onPressed: () {
                  context.read<NavigationBloc>().add(
                      const DrawerWidgetChangedEvent(
                          newIndex: 0, newWidget: HomeModelLanding()));
                },
              ),
              // DrawerListItem(
              //   label: S.current.my_profile,
              //   onPressed: () {
              //     context.read<NavigationBloc>().add(
              //         const DrawerWidgetChangedEvent(
              //             newIndex: 1, newWidget: HomeModelProfile()));
              //   },
              //   selected: index == 1,
              // ),
              DrawerListItem(
                label: S.current.my_connections,
                onPressed: () {
                  context.read<NavigationBloc>().add(
                      const DrawerWidgetChangedEvent(
                          newIndex: 2, newWidget: HomeModelConnections()));
                },
                selected: index == 2,
              ),
              DrawerListItem(
                label: S.current.exit,
                onPressed: () {
                  locator<AuthService>().signOut().then((value) {
                    if (value) {
                      return locator<NavigationService>().pushRemoveUntil('/');
                    }
                  });
                },
              )
            ],
          );
        },
      ),
    );
  }
}
