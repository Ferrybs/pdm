import 'package:basearch/src/features/chatbot/presentation/viewmodel/chatbot_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class ChatbotAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _viewModel = Modular.get<ChatbotViewModel>();
  ChatbotAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return AppBar(
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
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
              splashRadius: 1,
              onPressed: _viewModel.navigateToHome,
              icon: const Icon(Icons.arrow_back)),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset('lib/assets/images/v968-10-ps.svg'),
          ),
        ),
        const Flexible(flex: 8, child: Text("Plantie")),
      ],
    );
  }
}
