import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/utils/navigation.dart';
import 'package:whatsapp_status_saver/views/screens/image_viewer.dart';

import '../../providers/whatsapp_status_provider.dart';
import '../../utils/constants.dart';
import '../widgets/status_image.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var whatsappStatusProvider = Provider.of<WhatsappStatusProvider>(context);
    List<String> imagePaths = whatsappStatusProvider.whatsappStatusesPaths
        .where((element) => element.endsWith('.jpg'))
        .toList();
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                navigateTo(context, ImageViewer(index: index, paths: imagePaths));
              },
              child: StatusImage(imagePath: imagePaths[index]),
            ),
            Positioned(
              bottom: 3,
              right: 3,
              child: InkWell(
                onTap: () {
                  whatsappStatusProvider.saveStatus(
                    context,
                    imagePaths[index],
                    true,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppConstants.appColor,
                      shape: BoxShape.circle,
                    ),
                    width: 35,
                    height: 35,
                    child: const Icon(
                      Icons.download,
                      size: 23,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
