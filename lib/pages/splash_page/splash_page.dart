import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/user_provider.dart';
import 'package:hippocamp/providers/wallets_provider.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    var startTime = DateTime.now();
    await Future.wait([
      _getAllPosts(),
      _getAllDomainsAndPrecacheImages(),
      //_getAllCategoriesAndPrecacheImages(),
      _getAllPartnersAndPrecacheImages(),
      _getAllWallets(),
      _setUserProfile(),
      _getAttachmentTypesAndPrecacheImages()
    ]).whenComplete(() {
      var endTime = DateTime.now();
      var duration = endTime.difference(startTime);
      print('initialization finished in $duration milliseconds ✅');
      context.goNamed(routeMap[routeNames.home]);
    });
  }

  Future<void> _getAllPosts() async {
    var startTime = DateTime.now();
    var posts = ref.read(postListProvider.notifier);
    await posts.getPosts(past: true);
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    //print('posts loaded in $duration milliseconds ✅');
  }

  Future<void> _getAllDomainsAndPrecacheImages() async {
    var startTime = DateTime.now();
    var appStateProviderNotifier = ref.read(appStateProvider.notifier);
    List<Domains> domains = await appStateProviderNotifier.getDomains();
    await _precacheImages(elements: domains);
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    //print('domains loaded in $duration milliseconds ✅');
  }

  Future<void> _getAllCategoriesAndPrecacheImages() async {
    var startTime = DateTime.now();
    var appStateProviderNotifier = ref.read(appStateProvider.notifier);
    List<Categories> categories =
        await appStateProviderNotifier.getCategories();
    await _precacheImages(elements: categories);
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    //print('categories loaded in $duration milliseconds ✅');
  }

  Future<void> _getAllPartnersAndPrecacheImages() async {
    var startTime = DateTime.now();
    var appStateProviderNotifier = ref.read(appStateProvider.notifier);
    List<PartnerModel> businessPartners =
        await appStateProviderNotifier.getBusinessPartners();
    await _precacheImages(elements: businessPartners);

    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    print('partners loaded in $duration milliseconds ✅');
  }

  Future<void> _getAllWallets() async {
    var startTime = DateTime.now();
    var walletsProviderNotifier = ref.read(walletsProvider.notifier);
    await walletsProviderNotifier.getWallets();
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    //print('wallets loaded in $duration milliseconds ✅');
  }

  Future<void> _setUserProfile() async {
    var startTime = DateTime.now();
    var userProvider = ref.read(userNotifierProvider.notifier);
    await userProvider.setUserProfile();

    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    //print('user profile loaded in $duration milliseconds ✅');
  }

  Future<void> _getAttachmentTypesAndPrecacheImages() async {
    //loads all attachment types in appState repository and precaches all icons
    var startTime = DateTime.now();

    var appState = ref.read(appStateProvider.notifier);
    List<AttachmentType> attachments = await appState.getAttachmentTypes();

    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    //print('attachment types loaded in $duration milliseconds ✅');
  }

  Future<void> _precacheImages({
    required List<dynamic> elements,
  }) async {
    for (dynamic element in elements) {
      if ((element.iconUrl as String).isNotEmpty) {
        final SvgNetworkLoader loader = SvgNetworkLoader(element?.iconUrl);
        //print('precaching image ${element.iconUrl}');
        try {
          svg.cache
              .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
        } catch (e) {
          print('error while precaching image ${element.iconUrl}');
          continue;
        }
      } else {
        //print('no iconUrl found for element of type ${element.runtimeType}');
        continue;
      }
    }

    print(
        'precached images for ${elements.length} elements ✅ of type ${elements.first.runtimeType}');
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
