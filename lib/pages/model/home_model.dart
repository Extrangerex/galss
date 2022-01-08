import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/home_model/home_model_bloc.dart';
import 'package:galss/blocs/home_model/home_model_event.dart';
import 'package:galss/blocs/home_model/home_model_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/pages/model/home_model_conections.dart';
import 'package:galss/pages/model/home_model_landing.dart';
import 'package:galss/pages/model/home_model_profile.dart';
import 'package:galss/shared/drawer_list_item.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/variables.dart';

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
          create: (context) => HomeModelBloc(),
        )
      ],
      child: BlocBuilder<HomeModelBloc, HomeModelState>(
        builder: (context, state) {
          return Scaffold(
            drawer: _drawer(context),
            body: state.drawerWidget,
            appBar: AppBar(
              backgroundColor: toolbarColor,
              centerTitle: true,
              title: const Image(
                image: logo,
                width: 50,
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.chat))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    var index = context.read<HomeModelBloc>().state.drawerIndex;

    return Drawer(
      child: ListView(
        children: [
          DrawerListItem(
            label: S.current.home,
            selected: index == 0,
            onPressed: () {
              context.read<HomeModelBloc>().add(
                  const HomeModelDrawerWidgetChangedEvent(
                      newIndex: 0, newWidget: HomeModelLanding()));
            },
          ),
          DrawerListItem(
            label: S.current.my_profile,
            onPressed: () {
              context.read<HomeModelBloc>().add(
                  const HomeModelDrawerWidgetChangedEvent(
                      newIndex: 1, newWidget: HomeModelProfile()));
            },
            selected: index == 1,
          ),
          DrawerListItem(
            label: S.current.my_connections,
            onPressed: () {
              context.read<HomeModelBloc>().add(
                  const HomeModelDrawerWidgetChangedEvent(
                      newIndex: 1, newWidget: HomeModelConections()));
            },
            selected: index == 2,
          ),
          DrawerListItem(
            label: S.current.exit,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}