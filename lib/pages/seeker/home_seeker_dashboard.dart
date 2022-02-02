import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/shared/icons_img.dart';
import 'package:galss/shared/image_btn.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/recently_added_models.dart';

class HomeSeekerDashboard extends StatefulWidget {
  const HomeSeekerDashboard({Key? key}) : super(key: key);

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
                          image:
                              iconImg(customIconImg: CustomIconImg.icMiPerfil)),
                      label: Text(S.current.my_profile)),
                  _btnIconLabel(
                      child: ImageBtn(
                          image: iconImg(
                              customIconImg: CustomIconImg.icCercaDeMi)),
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
                          image:
                              iconImg(customIconImg: CustomIconImg.icCatalogo)),
                      label: Text(S.current.model_catalog)),
                  _btnIconLabel(
                      child: ImageBtn(
                          image: iconImg(
                              customIconImg: CustomIconImg.icConexiones)),
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
