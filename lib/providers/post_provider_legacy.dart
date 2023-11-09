/*
import 'package:hippocamp/clients/posts_client.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsNotifier extends Notifier<Map> {
  @override
  Map build() {
    // TODO: implement build
    return {
      'posts': [],
      'selectedPosts': [],
      'filteredPosts': [],
    };
  }

// ignore: avoid_public_notifier_properties
  /// POSTS REGION

  // All posts

  // Posts showed per date
  final PostsClient _postsClient = PostsClient();

  late DateTime datePagination =
      DateTime(DateTime.now().year, DateTime.now().month);
  late DateTime futureDatePagination =
      DateTime(DateTime.now().year, DateTime.now().month);
  // Used in timeline for getting new posts when scrolling down
  bool endList = false;
  bool endFutureList = false;
  int valueToScrollToBeToday = 0;

  // Used in timeline when user is selecting multiple posts
  bool _isSelectingPosts = false;
  bool get isSelectingPosts => _isSelectingPosts;
  set isSelectingPosts(bool v) {
    _isSelectingPosts = v;
  }

  Future<void> getPosts({bool past = true}) async {
    datePagination = DateTime(DateTime.now().year, DateTime.now().month);
    final resp = await _postsClient.getPosts(
      dateTime: datePagination,
      past: past,
    );

    if (past) {
      final month = datePagination.month - 1;
      DateTime newDate = DateTime(datePagination.year, month);

      if (month == 0) newDate = DateTime(datePagination.year - 1, 12);

      datePagination = newDate;
    }

    resp.fold(
      (l) => null,
      (r) async {
        state['posts'].clear();
        state['filteredPosts'].clear();

        state['posts'].addAll(r.posts);
        state['posts'].sort((a, b) => b.date.compareTo(a.date));

        endList = r.end;

        bool getTodayScrollValue = false;
        valueToScrollToBeToday = 0;

        for (var i in posts) {
          final postsPerDate = postsFiltered[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          postsFiltered[i.date] = postsPerDate;

          getTodayScrollValue = calculateIndexOfTodayInPosts(
            i,
            getTodayScrollValue,
          );
        }

        // Get the future true posts
        await addNewPosts(past: false);

        if (!endList && r.posts.length < 7) await addNewPosts();

        notifyListeners();
      },
    );
  }

  Future<void> addNewPosts({bool past = true}) async {
    final resp = await _postsClient.getPosts(
      dateTime: past ? datePagination : futureDatePagination,
      past: past,
    );

    if (past) {
      final month = datePagination.month - 1;
      DateTime newDate = DateTime(datePagination.year, month);

      if (month == 0) newDate = DateTime(datePagination.year - 1, 12);

      datePagination = newDate;
    } else {
      final month = futureDatePagination.month + 1;
      DateTime newDate = DateTime(futureDatePagination.year, month);

      if (month == 13) newDate = DateTime(futureDatePagination.year + 1, 1);

      futureDatePagination = newDate;
    }

    resp.fold(
      (l) => null,
      (r) {
        final newPosts = r.posts
            .where((e) => !posts.map((p) => p.key).contains(e.key))
            .toList();

        posts.addAll(newPosts);
        posts.sort((a, b) => b.date.compareTo(a.date));
        postsFiltered.clear();

        if (past)
          endList = r.end;
        else
          endFutureList = r.end;

        bool getTodayScrollValue = false;
        valueToScrollToBeToday = 0;

        for (var i in posts) {
          final postsPerDate = postsFiltered[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          postsFiltered[i.date] = postsPerDate;

          getTodayScrollValue = calculateIndexOfTodayInPosts(
            i,
            getTodayScrollValue,
          );
        }

        notifyListeners();
      },
    );
  }

  bool calculateIndexOfTodayInPosts(Post p, bool continueSearching) {
    final datePost = DateUtils.dateOnly(DateTime.parse(p.date));
    final today = DateUtils.dateOnly(DateTime.now());
    final isTodayOrLess =
        datePost.compareTo(today) == 0 || datePost.compareTo(today) == -1;

    if (isTodayOrLess && !continueSearching)
      return true;
    else if (!continueSearching) valueToScrollToBeToday += 1;
    return false;
  }

  Future<void> searchPosts(String text) async {
    final resp = await _postsClient.searchPosts(
      text: text,
    );

    resp.fold(
      (l) => false,
      (r) {
        posts.clear();
        postsFiltered.clear();
        notifyListeners();

        posts.addAll(r.posts);
        endList = r.end;

        for (var i in posts) {
          final postsPerDate = postsFiltered[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          postsFiltered[i.date] = postsPerDate;
        }

        notifyListeners();
      },
    );
  }

  Future<bool> saveTemplate(String categoryKey, CreatePost post) async {
    final resp = await _postsClient.saveTemplatePost(
      key: categoryKey,
      body: post.toJson(),
    );

    return resp.fold(
      (l) => false,
      (r) => true,
    );
  }

  Future<bool> createPost({required CreatePost postBody}) async {
    final resp = await _postsClient.createPost(
      createPost: postBody,
    );

    return resp.fold(
      (l) => false,
      (r) {
        getPosts();
        return true;
      },
    );
  }

  Future<bool> updatePost(
      {required String key, required CreatePost postBody}) async {
    final resp = await _postsClient.updatePost(
      key: key,
      createPost: postBody,
    );

    return resp.fold(
      (l) => false,
      (r) {
        getPosts();
        return true;
      },
    );
  }

  Future<bool> duplicatePosts({
    required List<String> postKeys,
    bool defaultDate = true,
  }) async {
    for (var i in postKeys) await _postsClient.duplicatePosts(postKey: i);

    _isSelectingPosts = false;
    postsSelected.clear();
    await getPosts();

    return true;
  }

  Future<bool> deletePosts({required List<String> postsKey}) async {
    final resp = await _postsClient.deletePosts(
      postsKey: postsKey,
    );

    return resp.fold(
      (l) => false,
      (r) async {
        _isSelectingPosts = false;
        postsSelected.clear();

        await getPosts();
        return true;
      },
    );
  }

  /// CALENDAR REGION
  Future<List<Post>?> getCalendarPosts({String date = "2023-07"}) async {
    final resp = await _postsClient.getCalendarPosts(date: date);

    return resp.fold((l) => null, (r) => r.posts);
  }

  /// DOMAINS REGION
  final List<Domains> domains = [];
  Future<void> getDomains({bool forceCall = false}) async {
    if (domains.isNotEmpty && !forceCall) return;

    final resp = await _postsClient.getDomains();

    resp.fold(
      (l) => null,
      (r) {
        domains.clear();
        domains.addAll(r);
        domains.sort(
          (a, b) => a.position.compareTo(b.position),
        );

        notifyListeners();
      },
    );
  }

  final List<Domains> domainsInCategories = [];
  final List<Domains> domainsInCategoriesInactive = [];
  Future<void> getDomainsInCategories({
    bool forceCall = false,
    bool active = true,
  }) async {
    if (domainsInCategories.isNotEmpty && !forceCall) return;

    final resp = await _postsClient.getDomains(
      active: active,
      fromDomains: true,
    );

    resp.fold(
      (l) => null,
      (r) {
        if (active) {
          domainsInCategories.clear();
          domainsInCategories.addAll(r);
          domainsInCategories.sort(
            (a, b) => a.position.compareTo(b.position),
          );
        } else {
          domainsInCategoriesInactive.clear();
          domainsInCategoriesInactive.addAll(r);
          domainsInCategoriesInactive.sort(
            (a, b) => a.localizedName.compareTo(b.localizedName),
          );
        }

        notifyListeners();
      },
    );
  }

  final List<Categories> categoriesInDomains = [];
  final List<Categories> categoriesInDomainsInactive = [];
  Future<void> getCategoriesInDomains({
    required String domainKey,
    bool forceCall = false,
    bool active = true,
  }) async {
    if (categoriesInDomains.isNotEmpty && !forceCall) return;

    final resp = await _postsClient.getCategories(
      key: domainKey,
      active: active,
    );

    resp.fold(
      (l) => null,
      (r) {
        if (active) {
          categoriesInDomains.clear();
          categoriesInDomains.addAll(r);
          categoriesInDomains.sort(
            (a, b) => a.position.compareTo(b.position),
          );
        } else {
          categoriesInDomainsInactive.clear();
          categoriesInDomainsInactive.addAll(r);
          categoriesInDomainsInactive.sort(
            (a, b) => a.position.compareTo(b.position),
          );
        }

        notifyListeners();
      },
    );
  }

  Future<Map<String, List<Post>>> getPostsFromCategory({
    required String categoryKey,
    bool withFinance = false,
    bool withAttachments = false,
  }) async {
    final resp = await _postsClient.getPostsFromCategory(
      categoryKey: categoryKey,
      attachments: withAttachments,
      transactions: withFinance,
    );

    return resp.fold(
      (l) => {},
      (r) {
        final newPostsPerCategory = r.posts;
        Map<String, List<Post>> newPostsFilteredPerCategory = {};

        newPostsPerCategory.sort((a, b) => b.date.compareTo(a.date));

        for (var i in newPostsPerCategory) {
          final postsPerDate = newPostsFilteredPerCategory[i.date] ?? [];
          postsPerDate.add(i);
          postsPerDate.sort((a, b) => b.timePost.compareTo(a.timePost));
          newPostsFilteredPerCategory[i.date] = postsPerDate;
        }

        return newPostsFilteredPerCategory;
      },
    );
  }

  Future<bool> updateIndexCategory(
    String domainKey,
    String categoryKey,
    int i,
  ) async {
    return await _postsClient.updateIndexCategoryList(
      domainKey: domainKey,
      categoryKey: categoryKey,
      newPosition: i,
    );
  }

  Future<bool> updateIndexDomain(String domainKey, int i) async {
    return await _postsClient.updateIndexDomainList(
      domainKey: domainKey,
      newPosition: i,
    );
  }

  Future<bool> uninstallDomainSelected(String domainKey) async {
    return await _postsClient.uninstallDomain(domainKey: domainKey);
  }

  Future<bool> addRemoveDomainSelected(
    String domainKey, {
    bool addOrRemove = true,
  }) async {
    return await _postsClient.addRemoveDomain(
      domainKey: domainKey,
      addOrRemove: addOrRemove,
    );
  }

  /// CATEGORIES REGION
  final List<Categories> categories = [];
  Future<void> getCategories({bool forceCall = false, String? key}) async {
    if (categories.isNotEmpty && !forceCall) return;

    final resp = await _postsClient.getCategories(key: key);

    resp.fold(
      (l) => null,
      (r) {
        categories.clear();
        categories.addAll(r);

        notifyListeners();
      },
    );
  }

  /// PARTNERS REGION
  final List<PartnerModel> partners = [];
  Future<void> getPartner({bool forceCall = false}) async {
    if (partners.isNotEmpty && !forceCall) return;
    final resp = await _postsClient.getPartners();

    resp.fold(
      (l) => null,
      (r) {
        partners.clear();
        partners.addAll(r);

        notifyListeners();
      },
    );
  }

  final List<AttachmentType> attachments = [];

  /// ATTACHMENTS REGION
  Future<void> getAttachmentTypes() async {
    final resp = await _postsClient.getAttachmentTypes();

    resp.fold(
      (l) => null,
      (r) {
        attachments.clear();
        attachments.addAll(r);

        notifyListeners();
      },
    );
  }

  void clearAllData() {
    datePagination = DateTime.now();
    endList = false;
    valueToScrollToBeToday = 0;
    posts.clear();
    postsFiltered.clear();
    postsSelected.clear();
    categories.clear();
    domains.clear();
    attachments.clear();
    notifyListeners();
  }
}
*/
