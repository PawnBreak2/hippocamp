import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hippocapp/models/posts-creation/attachment_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocapp/models/posts-creation/hashed_file.dart';
import 'package:hippocapp/models/posts-creation/hashed_image.dart';
import 'package:hippocapp/models/posts-creation/partner_model.dart';
import 'package:hippocapp/models/responses/categories_response_model.dart';
import 'package:hippocapp/models/responses/domains_response_model.dart';
import 'package:hippocapp/pages/post_creation_and_update/utilities/description_icon_enum.dart';
import 'package:image_picker/image_picker.dart';
part 'attachments_repository.freezed.dart';

@freezed
class AttachmentsState with _$AttachmentsState {
  const factory AttachmentsState({
    @Default([]) List<HashedImage> images,
    @Default([]) List<String> links,
    @Default([]) List<HashedFile> files,
  }) = _AttachmentsState;
}
