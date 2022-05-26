import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeviceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DeviceAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return AppBar(
      leading: _createLeading(themeData.brightness),
      title: _createTitle(),
      actions: [],
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
}
