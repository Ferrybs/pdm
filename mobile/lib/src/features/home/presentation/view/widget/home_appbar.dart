import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return AppBar(
      leading: _createLeading(themeData.brightness),
      title: _createTitle(),
      actions: [_createAction(themeData.brightness)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  _createLeading(Brightness brightness) {
    return IconButton(
      icon: brightness == Brightness.light
          ? SvgPicture.asset('lib/assets/images/align_right_light.svg')
          : SvgPicture.asset('lib/assets/images/align_right_dark.svg'),
      onPressed: () => {},
    );
  }

  _createTitle() {
    return Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: SvgPicture.asset('lib/assets/images/v968-10-ps.svg'),
      ),
    );
  }

  _createAction(Brightness brightness) {
    return IconButton(
      icon: brightness == Brightness.light
          ? SvgPicture.asset('lib/assets/images/cloud_thunder_light.svg')
          : SvgPicture.asset('lib/assets/images/cloud_thunder_dark.svg'),
      onPressed: () => {},
    );
  }
}
