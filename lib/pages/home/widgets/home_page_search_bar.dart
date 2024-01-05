import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocapp/providers/state/app_state_provider.dart';
import 'package:hippocapp/providers/posts_management/storage/posts_provider.dart';
import 'package:hippocapp/providers/ui/ui_state_provider.dart';
import 'package:hippocapp/widgets/forms/primary_text_form.dart';

class HomePageSearchBar extends ConsumerStatefulWidget {
  const HomePageSearchBar({super.key});

  @override
  ConsumerState<HomePageSearchBar> createState() => _HomePageSearchBarState();
}

class _HomePageSearchBarState extends ConsumerState<HomePageSearchBar> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  Timer? _timerForSearching;

  late AppStateNotifier _appStateNotifier;
  late UIStateNotifier _uiNotifier;
  late PostListNotifier _postListNotifier;

  @override
  void initState() {
    _appStateNotifier = ref.read(appStateProvider.notifier);
    _uiNotifier = ref.read(uiStateProvider.notifier);
    _postListNotifier = ref.read(postListProvider.notifier);
    _focusNode = FocusNode()..requestFocus();
    _textEditingController = TextEditingController();
    super.initState();
  }

  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> searchTextInPosts() async {
    if (_timerForSearching != null) {
      _timerForSearching!.cancel();
      _timerForSearching = null;
    }

    _timerForSearching = Timer.periodic(
      Duration(milliseconds: 500),
      (timer) async {
        await _postListNotifier.searchPosts(_textEditingController.text);
        _timerForSearching = null;
        timer.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _appStateNotifier.setIsSearchingPosts(false);
              _uiNotifier.setShowSearchFieldForPosts(false);
              _textEditingController.clear();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: PrimaryTextFormField(
              controller: _textEditingController,
              hintText: "Cerca",
              focusNode: _focusNode,
              backgroundColor: Colors.white,
              action: TextInputAction.search,
              onChange: (_) async {
                print('change');
                if (_textEditingController.text.isNotEmpty) {
                  print('search');
                  await searchTextInPosts();
                  _appStateNotifier.setIsSearchingPosts(true);
                } else {
                  _appStateNotifier.setIsSearchingPosts(false);
                }
              },
              suffixIcon: InkWell(
                onTap: () {
                  if (_textEditingController.text.isNotEmpty) {
                    _textEditingController.clear();
                  }
                },
                child: _textEditingController.text.isNotEmpty
                    ? Icon(Icons.clear)
                    : Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
