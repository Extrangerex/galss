import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/navigation/navigation_bloc.dart';
import 'package:galss/blocs/navigation/navigation_event.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/shared/icons_img.dart';
import 'package:galss/shared/image_btn.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/recently_added_models.dart';

import 'home_seeker_catalog.dart';
import 'home_seeker_close_me.dart';
import 'home_seeker_connections.dart';
import 'home_seeker_profile.dart';

class HomeSeekerDashboard extends StatefulWidget {
  final NavigationBloc drawerBloc;

  const HomeSeekerDashboard({Key? key, required this.drawerBloc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSeekerDashboardState();
}

class _HomeSeekerDashboardState extends State<HomeSeekerDashboard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (create) => HomeSeekerCatalogBloc()
              ..add(const HomeSeekerGetRecentlyAddedModelsEvent())),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ImagedBackgroundContainer(
            child: Column(
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _btnIconLabel(
                      child: ImageBtn(
                        image: iconImg(customIconImg: CustomIconImg.icMiPerfil),
                        onPressed: () {
                          widget.drawerBloc.add(const DrawerWidgetChangedEvent(
                              newIndex: 1, newWidget: HomeSeekerProfile()));
                        },
                      ),
                      label: Text(S.current.my_profile)),
                  _btnIconLabel(
                      child: ImageBtn(
                        image:
                            iconImg(customIconImg: CustomIconImg.icCercaDeMi),
                        onPressed: () {
                          widget.drawerBloc.add(const DrawerWidgetChangedEvent(
                              newIndex: 2, newWidget: HomeSeekerCloseMe()));
                        },
                      ),
                      label: Text(S.current.close_to_me))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _btnIconLabel(
                      child: ImageBtn(
                        image: iconImg(customIconImg: CustomIconImg.icCatalogo),
                        onPressed: () {
                          widget.drawerBloc.add(const DrawerWidgetChangedEvent(
                              newIndex: 3, newWidget: HomeSeekerCatalog()));
                        },
                      ),
                      label: Text(S.current.model_catalog)),
                  _btnIconLabel(
                      child: ImageBtn(
                        image:
                            iconImg(customIconImg: CustomIconImg.icConexiones),
                        onPressed: () {
                          widget.drawerBloc.add(const DrawerWidgetChangedEvent(
                              newIndex: 4,
                              newWidget: HomeSeekerMyConnections()));
                        },
                      ),
                      label: Text(S.current.my_connections))
                ],
              ),
            ),
            const Spacer(),
            const RecentlyAddedModels()
            // Flexible(flex: 1, child: SizedBox(height: 100,child: RecentlyAddedModels()))
          ],
        )),
      ),
    );
  }

  Widget _btnIconLabel({required Widget child, Widget? label}) {
    return Column(
      children: [child, label ?? const SizedBox.shrink()],
    );
  }
}
