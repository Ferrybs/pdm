import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _createLeading(),
      title: _createTitle(),
      actions: [_createAction()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  _createLeading() {
    return IconButton(
      icon: const Icon(Icons.format_align_left),
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

  _createAction() {
    return IconButton(
      icon: const Icon(Icons.cloud),
      onPressed: () => {},
    );
  }
}
