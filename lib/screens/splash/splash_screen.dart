import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:splash_view/splash_view.dart';

import '../../common_widget/loading_widget.dart';
import '../../common_widget/text_labels/title_heading2_widget.dart';
import '../../utils/assets_path.dart';
import '../../utils/custom_color.dart';
import '../../utils/strings.dart';
import '../home/home_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: SplashView(
        backgroundImageDecoration: BackgroundImageDecoration(
          image: AssetImage(Assets.splashBg),
        ),
        title: Container(
          padding: const EdgeInsets.all(40),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          color: CustomColor.blackColor.withOpacity(.2),
          child: Column(
            children: [
              TitleHeading2Widget(
                text: Strings.appName,
                color: CustomColor.whiteColor,
              ),

              const SizedBox(height: 40,),

              const CustomLoadingWidget()
            ],
          ),
        ),
        // loadingIndicator: const CustomLoadingWidget(),
        done: Done(HomeScreen()),
      ),
    );
  }
}