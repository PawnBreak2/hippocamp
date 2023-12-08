import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/common.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/models/repositories/ui_state_repository.dart';
import 'package:hippocamp/pages/change_password/change_password.dart';
import 'package:hippocamp/providers/auth_provider.dart';
import 'package:hippocamp/providers/ui_state_provider.dart';

class HomePageAppBarActionButtons extends ConsumerWidget {
  HomePageAppBarActionButtons({
    super.key,
  });

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UIStateNotifier uiNotifier = ref.read(uiStateProvider.notifier);
    AuthNotifier authNotifier = ref.read(authProvider.notifier);
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            '${Constants.iconAssetsPath}top-nav-bar-post-spot.svg',
            height: 36,
            width: 36,
          ),
          splashRadius: 26,
          iconSize: 26,
        ),
        Consumer(
          builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                uiNotifier.setShowSearchFieldForPosts(true);
                _focusNode.requestFocus();
              },
              icon: SvgPicture.network(
                "https://hippocapp-assets.s3.eu-central-1.amazonaws.com/icons/icone-sistema/home/top-nav-bar/lente-search.svg",
                height: 28,
                width: 28,
              ),
              splashRadius: 26,
              iconSize: 26,
            );
          },
        ),
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          onSelected: (c) {
            switch (c) {
              case "0":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangePasswordPage(),
                  ),
                );
                break;
              case "1":
                authNotifier.logout().whenComplete(
                    () => context.goNamed(routeMap[routeNames.login]));
                break;
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: "0",
              child: Text("Cambia password"),
            ),
            PopupMenuItem(
              value: "1",
              child: Text("Logout"),
            ),
          ],
        ),
      ],
    );
  }
}
