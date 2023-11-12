import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/user/user_detail_model.dart';

class FocusedUserItem extends StatelessWidget {
  const FocusedUserItem({
    Key? key,
    required this.customTheme,
    this.onUnfocusUser,
    this.isFansPage = false,
    required this.user,
  }) : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback? onUnfocusUser;
  final bool isFansPage;
  final UserDetailModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 23, 10, 18),
      child: Row(
        children: [
          ClipOval(
            child: OLImage(
              imageUrl: user.avatar ?? '',
              width: 53,
              height: 53,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        user.nickName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: customTheme.colors0x000000,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (!isFansPage)
                      InkWell(
                        onTap: onUnfocusUser,
                        child: Text(
                          '取消关注',
                          style: TextStyle(
                            color: customTheme.colors0xB4B4B4,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20 / 14 + 1),
                Row(
                  children: [
                    Builder(
                      builder: (context) {
                        switch (user.sex) {
                          case 1:
                            return Assets.basePage.icSexMan.image(
                              width: 20,
                              height: 13,
                            );
                          case 2:
                            return Assets.basePage.icSexWoman.image(
                              width: 20,
                              height: 13,
                            );
                          default:
                            return Assets.basePage.icSexSecrecy.image(
                              width: 20,
                              height: 13,
                            );
                        }
                      },
                    ),
                    const SizedBox(width: 4),
                    if ((user.userLevel ?? 0) > 0)
                      SizedBox(
                        width: 40,
                        height: 13,
                        child: Stack(
                          children: [
                            Assets.basePage.icVip1.image(
                              width: 40,
                              height: 13,
                            ),
                            Positioned(
                              left: 13,
                              child: Center(
                                child: Text(
                                  'VIP ${user.userLevel ?? 0}',
                                  style: TextStyle(
                                    color: customTheme.colors0xFFFFFF,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                if (user.personalSignature?.isNotEmpty == true) ...[
                  const SizedBox(height: 16 / 12 + 3),
                  Text(
                    user.personalSignature ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: customTheme.colors0x000000_30,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
