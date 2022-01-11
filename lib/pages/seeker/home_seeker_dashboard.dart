import 'package:flutter/material.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/shared/icons_img.dart';
import 'package:galss/shared/image_btn.dart';
import 'package:galss/shared/imaged_background_container.dart';

class HomeSeekerDashboard extends StatefulWidget {
  const HomeSeekerDashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSeekerDashboardState();
}

class _HomeSeekerDashboardState extends State<HomeSeekerDashboard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ImagedBackgroundContainer(
          child: Column(
        children: [
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
                        image:
                            iconImg(customIconImg: CustomIconImg.icCercaDeMi)),
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
                        image:
                            iconImg(customIconImg: CustomIconImg.icConexiones)),
                    label: Text(S.current.my_connections))
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget _btnIconLabel({required Widget child, Widget? label}) {
    return Column(
      children: [child, label ?? const SizedBox.shrink()],
    );
  }
}
