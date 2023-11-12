import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:url_launcher/url_launcher.dart';

class GameBar extends StatelessWidget {
  const GameBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Image(
            image: AssetImage(
              Assets.gamePage.logoImg.path,
            ),
            height: 38,
            fit: BoxFit.fitHeight,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            String url = UserManagerCache.shared.getNewOnlineUrl();
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image(
              image: AssetImage(
                Assets.rootPage.images.navKf.path,
              ),
              width: 30,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }
}
