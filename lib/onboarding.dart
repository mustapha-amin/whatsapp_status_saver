import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/services/onboarding_settings.dart';
import 'package:whatsapp_status_saver/utils/constants.dart';
import 'package:whatsapp_status_saver/utils/textstyle.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_status_saver/views/screens/home.dart';
import 'utils/spacings.dart';
import 'dart:developer';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> requestStatusDirPermission(BuildContext context) async {
    PermissionStatus status = await Permission.storage.request();
    log(status.isGranted.toString());
    if (status.isGranted) {
      PermissionStatus status2 =
          await Permission.manageExternalStorage.request();
      if (status2.isGranted) {
        OnboardingPreference.savePref(false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }

      // ignore: use_build_context_synchronously
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addSpacing(size.height * .45),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/status_icon.png',
                  height: size.height * .15,
                ),
              ),
              // const Text("Whatsapp Status Saver"),
              addSpacing(size.height * .10),
              Text(
                "Allow Whatsapp Status Saver to access your internal storage",
                style: kTextStyle(15),
                textAlign: TextAlign.center,
              ),
              addSpacing(20),
              SizedBox(
                width: size.width,
                height: size.height * .08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: AppConstants.appColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    requestStatusDirPermission(context);
                  },
                  child: Text(
                    "Continue",
                    style: kTextStyle(20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
