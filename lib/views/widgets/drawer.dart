import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/utils/extensions.dart';

import '../../utils/constants.dart';
import '../../utils/spacings.dart';
import '../../utils/textstyle.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.screenWidth * .85,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppConstants.appColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AppConstants.appIcon,
                    width: context.screenWidth * .25,
                  ),
                ),
                addSpacing(20),
                Text(
                  "Version 1.0",
                  style: kTextStyle(15, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.info_rounded),
            title: Text("About us"),
          ),
          const ListTile(
            leading: Icon(Icons.star),
            title: Text("Rate us"),
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Text("Share with friends"),
          ),
        ],
      ),
    );
  }
}
