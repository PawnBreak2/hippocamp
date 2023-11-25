import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hippocamp/providers/app_state_provider.dart';
import 'package:hippocamp/providers/posts_provider.dart';
import 'package:hippocamp/styles/colors.dart';

class PostSelectionBottomBar extends StatelessWidget {
  /// Bottom bar that appears when the user is selecting posts.
  /// It contains the number of selected posts and the buttons to duplicate and delete them

  const PostSelectionBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = CustomColors.white243;
    const Color textColor = CustomColors.grey121;
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(
        left: 16,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: Consumer(
                  builder: (context, ref, child) {
                    final appStateProviderNotifier =
                        ref.read(appStateProvider.notifier);
                    final postsProviderNotifier =
                        ref.read(postListProvider.notifier);

                    return InkWell(
                      onTap: () {
                        appStateProviderNotifier.setIsSelectingPosts(false);
                        postsProviderNotifier.addOrRemoveSelectedPost();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: textColor,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Consumer(
                builder: (context, ref, child) {
                  final selectedPostsLength = ref.watch(postListProvider
                      .select((state) => state.selectedPosts.length));

                  return Text(
                    selectedPostsLength.toString(),
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),

          // Buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: Consumer(
                  builder: (context, ref, child) {
                    final postsProviderNotifier =
                        ref.read(postListProvider.notifier);
                    final postsProviderState = ref.read(postListProvider);

                    return InkWell(
                      onTap: () async {
                        await postsProviderNotifier.duplicatePosts(
                          postKeys: postsProviderState.selectedPosts
                              .map((e) => e.key)
                              .toList(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Consumer(
                          builder: (context, ref, child) {
                            bool isThereOnlyOnePostSelected = (ref.watch(
                                    postListProvider.select((state) =>
                                        state.selectedPosts.length)) ==
                                1);

                            if (isThereOnlyOnePostSelected) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.copy,
                                    color: textColor,
                                    size: 20,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Duplica\npost",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: Consumer(
                  builder: (context, ref, child) {
                    final postsProviderNotifier =
                        ref.read(postListProvider.notifier);
                    final postsProviderState = ref.read(postListProvider);

                    return InkWell(
                      onTap: () async {
                        await postsProviderNotifier.deletePosts(
                          postsKey: postsProviderState.selectedPosts
                              .map((e) => e.key)
                              .toList(),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: textColor,
                              size: 20,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Elimina\npost",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}