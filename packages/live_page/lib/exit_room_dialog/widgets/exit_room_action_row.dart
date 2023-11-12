import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class ExitRoomActionRow extends StatelessWidget {
  const ExitRoomActionRow({
    Key? key,
    required this.exit,
    required this.followThenExit,
  }) : super(key: key);

  final VoidCallback exit;
  final VoidCallback? followThenExit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: exit,
          child: Container(
            width: 120,
            constraints: const BoxConstraints(minHeight: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                '狠心离开',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        if (followThenExit != null) ...[
          const SizedBox(width: 18),
          InkWell(
            onTap: followThenExit,
            child: Container(
              width: 120,
              constraints: const BoxConstraints(minHeight: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    Assets.livePage.anchorUnfollowBg.path,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  '关注并退出',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
