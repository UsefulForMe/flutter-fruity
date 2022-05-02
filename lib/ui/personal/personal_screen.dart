import 'package:flutter/material.dart';
import 'package:fruity/constants/app_color.dart';
import 'package:fruity/routes.dart';
import 'package:fruity/stores/user/auth_store.dart';
import 'package:fruity/stores/version/version_store.dart';
import 'package:fruity/ui/personal/widgets/personal_header.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PersonalScreen extends StatelessWidget {
  PersonalScreen({Key? key}) : super(key: key);

  String SUPPORT_PHONE_NUMBER = '0338613062';

  @override
  Widget build(BuildContext context) {
    final AuthStore _store = context.read<AuthStore>();
    final VersionStore _versionStore = context.read<VersionStore>();

    return Scaffold(
      appBar: PersonalAppBar(),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.list_user_addressres,
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Địa chỉ nhận hàng',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.setting,
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Cài đặt',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Expanded(
                            child: Text(
                              'Hotline',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                String url = 'tel:$SUPPORT_PHONE_NUMBER';
                                launchUrlString(url);
                              },
                              child: Text(SUPPORT_PHONE_NUMBER))
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.app_shortcut_rounded,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Expanded(
                            child: Text(
                              'Phiên bản ứng dụng',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            _versionStore.version,
                            style: TextStyle(color: AppColors.palette.shade500),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
