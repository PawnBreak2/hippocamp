import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/user_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    setUserProfile();
    getAllPosts();
    getAttachmentTypesAndPrecache();
    super.initState();
  }

  void getAllPosts() async {
    var posts = ref.read(postListProvider.notifier);
    await posts.getPosts(past: true);
  }

  void setUserProfile() async {
    var userProvider = ref.read(userNotifierProvider.notifier);
    await userProvider.setUserProfile();
  }

  void getAttachmentTypesAndPrecache() async {
    //loads all attachment types in appState repository and precaches all icons

    var appState = ref.read(appStateProvider.notifier);
    List<AttachmentType> attachments = await appState.getAttachmentTypes();

    for (AttachmentType element in attachments) {
      final SvgNetworkLoader loader = SvgNetworkLoader(element.iconUrl);
      await svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
            color: CustomColors.primaryRed, size: 80),
      ),
    );
  }
}
