import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/navigation/navigation_bloc.dart';
import 'package:galss/blocs/navigation/navigation_event.dart';
import 'package:galss/blocs/navigation/navigation_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/pages/seeker/home_seeker_catalog.dart';
import 'package:galss/pages/seeker/home_seeker_close_me.dart';
import 'package:galss/pages/seeker/home_seeker_connections.dart';
import 'package:galss/pages/seeker/home_seeker_dashboard.dart';
import 'package:galss/pages/seeker/home_seeker_favorites.dart';
import 'package:galss/pages/seeker/home_seeker_likes.dart';
import 'package:galss/pages/seeker/home_seeker_profile.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/drawer_list_item.dart';
import 'package:galss/shared/images.dart';
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
    return HomeSeekerDashboard(
      drawerBloc: context.read<NavigationBloc>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double imgRadius = 64;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(
            create: (context) => UserBloc()..add(const FetchUserData()))
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
                onDrawerChanged: (isOpened) {
                  if (isOpened) {
                    context.read<UserBloc>().add(const FetchUserData());
                  }
                },
                drawer: Drawer(
                  child: BlocBuilder<NavigationBloc, NavigationState>(
                    builder: (context, state) {
                      return ListView(
                        children: [
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              return UserAccountsDrawerHeader(
                                accountEmail: null,
                                accountName: Text(state.user?.fullName ??
                                    S.current.not_specified),
                                currentAccountPicture: CachedNetworkImage(
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundImage: imageProvider,
                                    radius: imgRadius,
                                  ),
                                  imageUrl:
                                      "${HttpService.apiBaseUrl}/${state.user?.profilePhoto?.urlPath}",
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    backgroundImage: profilePlaceholderImage,
                                    radius: imgRadius,
                                  ),
                                ),
                              );
                            },
                          ),
                          DrawerListItem(
                            label: S.current.home,
                            onPressed: () {
                              context.read<NavigationBloc>().add(
                                  DrawerWidgetChangedEvent(
                                      newIndex: 0,
                                      newWidget:
                                          handleHomeSeekerDashboard(context)));
                            },
                            selected: state.navigationIndex == 0,
                          ),
                          DrawerListItem(
                            label: S.current.my_profile,
                            onPressed: () {
                              context.read<NavigationBloc>().add(
                                  const DrawerWidgetChangedEvent(
                                      newIndex: 1,
                                      newWidget: HomeSeekerProfile()));
                            },
                            selected: state.navigationIndex == 1,
                          ),
                          DrawerListItem(
                            label: S.current.close_to_me,
                            onPressed: () {
                              context.read<NavigationBloc>().add(
                                  const DrawerWidgetChangedEvent(
                                      newIndex: 2,
                                      newWidget: HomeSeekerCloseMe()));
                            },
                            selected: state.navigationIndex == 2,
                          ),
                          DrawerListItem(
                            label: S.current.model_catalog,
                            onPressed: () {
                              context.read<NavigationBloc>().add(
                                  const DrawerWidgetChangedEvent(
                                      newIndex: 3,
                                      newWidget: HomeSeekerCatalog()));
                            },
                            selected: state.navigationIndex == 3,
                          ),
                          DrawerListItem(
                            label: S.current.my_connections,
                            onPressed: () {
                              context.read<NavigationBloc>().add(
                                  const DrawerWidgetChangedEvent(
                                      newIndex: 4,
                                      newWidget: HomeSeekerMyConnections()));
                            },
                            selected: state.navigationIndex == 4,
                          ),
                          DrawerListItem(
                            label: S.current.exit,
                            onPressed: () {
                              locator<AuthService>().signOut().then((value) {
                                if (value) {
                                  return locator<NavigationService>()
                                      .pushRemoveUntil('/');
                                }
                              });
                            },
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
                bottomNavigationBar:
                    BlocBuilder<NavigationBloc, NavigationState>(
                        builder: (context, state) {
                  int currentIndex() {
                    if (state.navigationIndex == 5) {
                      return 3;
                    } else if (state.navigationIndex == 6) {
                      return 4;
                    } else if (state.navigationIndex == 3) {
                      return 2;
                    } else if (state.navigationIndex == 2) {
                      return 1;
                    }

                    return 0;
                  }

                  return Theme(
                    data: ThemeData.light(),
                    child: BottomNavigationBar(
                      unselectedFontSize: 0,
                      selectedFontSize: 0,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: currentIndex(),
                      iconSize: 28,
                      onTap: (item) {
                        if (item == 3) {
                          context.read<NavigationBloc>().add(
                              const DrawerWidgetChangedEvent(
                                  newIndex: 5, newWidget: HomeSeekerLikes()));
                        } else if (item == 4) {
                          context.read<NavigationBloc>().add(
                              const DrawerWidgetChangedEvent(
                                  newIndex: 6,
                                  newWidget: HomeSeekerFavorites()));
                        } else if (item == 2) {
                          context.read<NavigationBloc>().add(
                              const DrawerWidgetChangedEvent(
                                  newIndex: 3, newWidget: HomeSeekerCatalog()));
                        } else if (item == 1) {
                          context.read<NavigationBloc>().add(
                              const DrawerWidgetChangedEvent(
                                  newIndex: 2, newWidget: HomeSeekerCloseMe()));
                        } else {
                          context.read<NavigationBloc>().add(
                              DrawerWidgetChangedEvent(
                                  newIndex: 0,
                                  newWidget: HomeSeekerDashboard(
                                      drawerBloc:
                                          context.read<NavigationBloc>())));
                        }
                      },
                      unselectedIconTheme:
                          IconThemeData(color: Colors.grey.shade500),
                      selectedIconTheme:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: 'null'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.location_on), label: 'null'),
                        BottomNavigationBarItem(
                            icon: Icon(FontAwesomeIcons.bookOpen),
                            label: 'null'),
                        BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.heart),
                            label: 'null'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.star), label: 'null')
                      ],
                    ),
                  );
                }),
                body: BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) {
                    if (state.navigationWidget == null) {
                      context.read<NavigationBloc>().add(
                          DrawerWidgetChangedEvent(
                              newIndex: 0,
                              newWidget: handleHomeSeekerDashboard(context)));
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return state.navigationWidget!;
                  },
                )),
          );
        },
      ),
    );
  }
}
