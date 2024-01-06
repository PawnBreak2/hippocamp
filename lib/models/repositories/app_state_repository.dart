import 'package:hippocapp/models/posts-creation/attachment_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocapp/models/posts-creation/partner_model.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/models/responses/domains_response_model.dart';
part 'app_state_repository.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default([]) List<AttachmentType> attachmentTypes,
    @Default([]) List<PostCategory> categories,
    @Default([]) List<Domain> domains,
    @Default([]) List<BusinessPartner> businessPartners,
    @Default(0) int valueToScrollToToday,
    @Default([]) List<Domain> domainsInCategories,
    @Default([]) List<Domain> domainsInCategoriesInactive,
    @Default([]) List<PostCategory> categoriesInDomains,
    @Default([]) List<PostCategory> categoriesInDomainsInactive,
    DateTime? lastDateTimeForRequestingPosts,
    @Default(false) bool isSelectingPosts,
    @Default(false) bool isSearchingPosts,
    @Default(false) bool isSearchingCategories,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      lastDateTimeForRequestingPosts: DateTime.now(),
    );
  }
}
