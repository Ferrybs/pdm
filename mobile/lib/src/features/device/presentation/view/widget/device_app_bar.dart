import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeviceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DeviceAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _createTitle(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
