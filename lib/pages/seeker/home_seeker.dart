import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/drawer/drawer_bloc.dart';
import 'package:galss/blocs/drawer/drawer_event.dart';
import 'package:galss/blocs/drawer/drawer_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/pages/seeker/home_seeker_catalog.dart';
import 'package:galss/pages/seeker/home_seeker_close_me.dart';
import 'package:galss/pages/seeker/home_seeker_connections.dart';
import 'package:galss/pages/seeker/home_seeker_dashboard.dart';
import 'package:galss/pages/seeker/home_seeker_profile.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/drawer_list_item.dart';
import 'package:galss/shared/logo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';

class HomeSeeker extends StatefulWidget {
  const HomeSeeker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSeekerState();
}

class _HomeSeekerState extends State<HomeSeeker> {
  Widget handleHomeSeekerDashboard(BuildContext context) {
    return HomeSeekerDashboard(onMyProfileClicked: () {
      context.read<DrawerBloc>().add(const DrawerWidgetChangedEvent(
          newIndex: 1, newWidget: HomeSeekerProfile()));
    }, onMyCatalogClicked: () {
      context.read<DrawerBloc>().add(const DrawerWidgetChangedEvent(
          newIndex: 3, newWidget: HomeSeekerCatalog()));
    }, onMyConnectionsClicked: () {
      context.read<DrawerBloc>().add(const DrawerWidgetChangedEvent(
          newIndex: 4, newWidget: HomeSeekerMyConnections()));
    }, onCloseMeClicked: () {
      context.read<DrawerBloc>().add(const DrawerWidgetChangedEvent(
          newIndex: 2, newWidget: HomeSeekerCloseMe()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => DrawerBloc()
              ..add( DrawerWidgetChangedEvent(
                  newIndex: 0, newWidget: handleHomeSeekerDashboard(context))))
      ],
      child: Scaffold(
          drawer: Drawer(
            child: BlocBuilder<DrawerBloc, DrawerState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    DrawerListItem(
                      label: S.current.home,
                      onPressed: () {
                        context.read<DrawerBloc>().add(
                             DrawerWidgetChangedEvent(
                                newIndex: 0, newWidget: handleHomeSeekerDashboard(
                                 context)));
                      },
                      selected: state.drawerIndex == 0,
                    ),
                    DrawerListItem(
                      label: S.current.my_profile,
                      onPressed: () {
                        context.read<DrawerBloc>().add(
                            const DrawerWidgetChangedEvent(
                                newIndex: 1, newWidget: HomeSeekerProfile()));
                      },
                      selected: state.drawerIndex == 1,
                    ),
                    DrawerListItem(
                      label: S.current.close_to_me,
                      onPressed: () {
                        context.read<DrawerBloc>().add(
                            const DrawerWidgetChangedEvent(
                                newIndex: 2, newWidget: HomeSeekerCloseMe()));
                      },
                      selected: state.drawerIndex == 2,
                    ),
                    DrawerListItem(
                      label: S.current.model_catalog,
                      onPressed: () {
                        context.read<DrawerBloc>().add(
                            const DrawerWidgetChangedEvent(
                                newIndex: 3, newWidget: HomeSeekerCatalog()));
                      },
                      selected: state.drawerIndex == 3,
                    ),
                    DrawerListItem(
                      label: S.current.my_connections,
                      onPressed: () {
                        context.read<DrawerBloc>().add(
                            const DrawerWidgetChangedEvent(
                                newIndex: 4,
                                newWidget: HomeSeekerMyConnections()));
                      },
                      selected: state.drawerIndex == 4,
                    ),
                    DrawerListItem(
                      label: S.current.exit,
                      onPressed: () {},
                    ),
                  ],
                );
              },
            ),
          ),
          appBar: AppBar(
            title: const Image(
              image: logo,
              width: 50,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 1,
            actions: [
              IconButton(
                  onPressed: () {
                    locator<NavigationService>()
                        .navigatorKey
                        .currentState
                        ?.push(MaterialPageRoute(
                            builder: (builder) =>
                                const HomeSeekerMyConnections()));
                  },
                  icon: const Icon(Icons.chat))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedFontSize: 0,
            selectedFontSize: 0,
            iconSize: 28,
            unselectedIconTheme:
                IconThemeData(color: Theme.of(context).primaryColor),
            selectedIconTheme: IconThemeData(color: Colors.grey.shade500),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'null'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.heart), label: 'null'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'null')
            ],
            backgroundColor: Colors.white,
          ),
          body: BlocBuilder<DrawerBloc, DrawerState>(
            builder: (context, state) {
              if (state.drawerWidget == null) {
                return const CircularProgressIndicator();
              }

              return state.drawerWidget!;
            },
          )),
    );
  }
}
