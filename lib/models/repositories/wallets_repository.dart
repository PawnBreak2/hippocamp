import 'package:hippocapp/models/responses/posts/post_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hippocapp/models/wallets/wallet_model.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'wallets_repository.freezed.dart';

@freezed
class WalletsRepository with _$WalletsRepository {
  const factory WalletsRepository({
    @Default([]) List<Wallet> wallets,
  }) = _WalletsRepository;
}
