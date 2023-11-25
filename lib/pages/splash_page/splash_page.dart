import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hippocamp/constants/navigation/routeNames.dart';
import 'package:hippocamp/constants/storage_keys.dart';
import 'package:hippocamp/helpers/providers/post_provider_helpers.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/providers/user_provider.dart';
import 'package:hippocamp/providers/wallets_provider.dart';
import 'package:hippocamp/storage/local_storage.dart';
import 'package:hippocamp/styles/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:async';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  final cacheManager = DefaultCacheManager();
  late AppStateNotifier appStateNotifier;

  @override
  void initState() {
    appStateNotifier = ref.read(appStateProvider.notifier);

    _init();
    super.initState();
  }

  void _init() async {
    var startTime = DateTime.now();
    print(LocalStorage.readString(StorageKeys.token));
    await Future.wait([
      _getAllPosts(),
      _getAllDomainsAndPrecacheImages(),
      _getAllPartnersAndPrecacheImages(),
      _getAllWallets(),
      _setUserProfile(),
      _getAttachmentTypesAndPrecacheImages(),
    ]).whenComplete(() {
      var endTime = DateTime.now();
      var duration = endTime.difference(startTime);
      setValueToScrollToToday();
      print('initialization finished in $duration milliseconds ✅');
      context.goNamed(routeMap[routeNames.mainScaffold]);
    });
  }

  List<DateTime> getListOfMonths(Map<int, Map<int, List<Post>>> postsByDate) {
    List<DateTime> listOfMonths = [];

    for (var year in postsByDate.keys) {
      postsByDate[year]!.forEach((month, _) {
        listOfMonths.add(DateTime(year, month));
      });
    }

    // Sorting in reversed chronological order
    listOfMonths.sort((a, b) => b.compareTo(a));

    return listOfMonths;
  }

  int findIndexOfMonth(
      List<DateTime> listOfMonths, DateTime currentYearAndMonth) {
    // Finding the index of the month that matches currentYearAndMonth
    return listOfMonths.indexWhere((date) =>
        date.year == currentYearAndMonth.year &&
        date.month == currentYearAndMonth.month);
  }

  void setValueToScrollToToday() {
    DateTime currentDate = DateTime.now();
    Map<int, Map<int, List<Post>>> postsMappedByDateAndMonth =
        ref.read(postListProvider).postsMappedByYearAndMonth;
    List<DateTime> listOfMonths = getListOfMonths(postsMappedByDateAndMonth);
    int valueToScrollTo = findIndexOfMonth(listOfMonths, currentDate);
    appStateNotifier.setValueToScrollToday(valueToScrollTo);
  }

  Future<void> _getAllPosts() async {
    var startTime = DateTime.now();

    var posts = ref.read(postListProvider.notifier);
    // gets the posts for the previous two months
    await posts.getPosts(past: true, monthsToGoBack: 2);
    await posts.getPosts(past: false, yearsToGoForward: 2);
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);

    print('posts loaded in $duration milliseconds ✅');
  }

  Future<void> _getAllDomainsAndPrecacheImages() async {
    var startTime = DateTime.now();
    List<Domain> domains = await appStateNotifier.getDomains();
    await _precacheImages(elements: domains);
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    print('domains loaded in $duration milliseconds ✅');
  }

  Future<void> _getAllCategoriesAndPrecacheImages() async {
    var startTime = DateTime.now();
    List<PostCategory> categories = await appStateNotifier.getCategories();
    await _precacheImages(elements: categories);
    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    print('categories loaded in $duration milliseconds ✅');
  }

  Future<void> _getAllPartnersAndPrecacheImages() async {
    var startTime = DateTime.now();
    List<PartnerModel> businessPartners =
        await appStateNotifier.getBusinessPartners();
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

    List<AttachmentType> attachments =
        await appStateNotifier.getAttachmentTypes();

    var endTime = DateTime.now();
    var duration = endTime.difference(startTime);
    //print('attachment types loaded in $duration milliseconds ✅');
  }

  Future<void> _precacheImages({
    required List<dynamic> elements,
  }) async {
    for (dynamic element in elements) {
      if ((element.iconUrl as String).isNotEmpty) {
        await cacheManager.getSingleFile(element.iconUrl);
        //print('precaching image ${element.iconUrl}');
        try {} catch (e) {
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
