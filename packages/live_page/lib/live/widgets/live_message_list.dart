import 'package:flutter/material.dart';

import 'message_item.dart';

class LiveMessageList extends StatelessWidget {
  const LiveMessageList({
    Key? key,
    required this.messages,
    required this.scrollController,
  }) : super(key: key);

  final List<String> messages;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      controller: scrollController,
      padding: EdgeInsets.zero,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return MessageItem(
          nickname: 'nickname',
          msg: messages[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 15,
      ),
    );
  }
}
