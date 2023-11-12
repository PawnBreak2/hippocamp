import 'package:flutter/material.dart';
import 'package:hippocamp/clients/appstate_client.dart';
import 'package:hippocamp/models/posts-creation/attachment_types.dart';
import 'package:hippocamp/models/posts-creation/partner_model.dart';
import 'package:hippocamp/models/repositories/app_state_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/models/responses/categories_response_model.dart';
import 'package:hippocamp/models/responses/domains_response_model.dart';
import 'package:hippocamp/models/responses/posts_response_model.dart';

class AppStateNotifier extends Notifier<AppState> {
  @override
  build() {
    return AppState();
  }

  final _appStateClient = AppStateClient();

  //POSTS

  ///TODO: ottimizzare

  bool calculateIndexOfTodayInPosts(Post p, bool continueSearching) {
    final datePost = DateUtils.dateOnly(DateTime.parse(p.date));
    final today = DateUtils.dateOnly(DateTime.now());
    final bool isTodayOrBefore =
        datePost.compareTo(today) == 0 || datePost.compareTo(today) == -1;

    if (isTodayOrBefore) {
      return false;
    } else {
      print(p.date + " " + p.key);
      state =
          state.copyWith(valueToScrollToToday: state.valueToScrollToToday + 1);
      return true;
    }
  }

  // reset the property valueToScrollToToday to 0

  void resetValueToScrollToday() {
    state = state.copyWith(valueToScrollToToday: 0);
  }

  // ATTACHMENTS

  Future<List<AttachmentType>> getAttachmentTypes() async {
    final resp = await _appStateClient.getAttachmentTypes();

    resp.fold(
      (l) => null,
      (r) {
        state = state.copyWith(attachmentTypes: [...r]);
      },
    );
    return state.attachmentTypes;
  }

  //DOMAINS

  Future<List<Domains>> getDomains({bool forceCall = false}) async {
    if (state.domains.isNotEmpty && !forceCall) return state.domains;

    final resp = await _appStateClient.getDomains();

    resp.fold(
      (l) => null,
      (r) {
        r.sort(
          (a, b) => a.position.compareTo(b.position),
        );
        state = state.copyWith(domains: []);
        state = state.copyWith(domains: [...state.domains, ...r]);
      },
    );

    return state.domains;
  }

  Future<bool> updateIndexDomain(String domainKey, int i) async {
    return await _appStateClient.updateIndexDomainList(
      domainKey: domainKey,
      newPosition: i,
    );
  }

  Future<bool> uninstallDomainSelected(String domainKey) async {
    return await _appStateClient.uninstallDomain(domainKey: domainKey);
  }

  Future<bool> addRemoveDomainSelected(
    String domainKey, {
    bool addOrRemove = true,
  }) async {
    return await _appStateClient.addRemoveDomain(
      domainKey: domainKey,
      addOrRemove: addOrRemove,
    );
  }

  // CATEGORIES

  Future<List<Categories>> getCategories(
      {bool forceCall = false, String? key}) async {
    if (state.categories.isNotEmpty && !forceCall) return state.categories;

    final resp = await _appStateClient.getCategories(key: key);

    resp.fold(
      (l) => null,
      (r) {
        state = state.copyWith(categories: []);
        state = state.copyWith(categories: [...state.categories, ...r]);
      },
    );
    return state.categories;
  }

  Future<bool> updateIndexCategory(
    String domainKey,
    String categoryKey,
    int i,
  ) async {
    return await _appStateClient.updateIndexCategoryList(
      domainKey: domainKey,
      categoryKey: categoryKey,
      newPosition: i,
    );
  }

  // PARTNERS

  Future<List<PartnerModel>> getBusinessPartners(
      {bool forceCall = false}) async {
    if (state.businessPartners.isNotEmpty && !forceCall)
      return state.businessPartners;
    final resp = await _appStateClient.getPartners();

    resp.fold(
      (l) => null,
      (r) {
        state = state.copyWith(businessPartners: []);
        state =
            state.copyWith(businessPartners: [...state.businessPartners, ...r]);
      },
    );
    return state.businessPartners;
  }

  void clearAllData() {
    //goes back to initializing an empty repository

    state = AppState();
  }
}

final appStateProvider =
    NotifierProvider<AppStateNotifier, AppState>(() => AppStateNotifier());
