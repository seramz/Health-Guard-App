import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_button.dart';
import 'package:health_guard/components/custom_text.dart';
import 'package:health_guard/utils/app_colors.dart';
import 'package:health_guard/utils/util_functions.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xff3F0000),
              AppColors.primaryRed,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              "It seems you’re in a trouble at this moment",
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            const SizedBox(
              height: 44,
            ),
            Stack(
              children: [
                Container(
                  height: 394,
                  width: 394,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  top: 17,
                  left: 17,
                  child: Container(
                    height: 358,
                    width: 358,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 38,
                  left: 38,
                  child: Container(
                    height: 318,
                    width: 318,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 62,
                  child: Container(
                    height: 272,
                    width: 272,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CustomText(
                      "EMERGENCY!",
                      color: AppColors.primaryRed,
                      fontWeight: FontWeight.w500,
                      fontSize: 31,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 41,
            ),
            const CustomText(
              "EMERGENCY CONTACT WILL DIAL IN",
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomText(
              "03:00:99",
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 35,
            ),
            const SizedBox(
              height: 14,
            ),
            Stack(
              children: [
                Container(
                  height: 55,
                  width: 176,
                  decoration: BoxDecoration(
                    color: AppColors.primaryRed.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(39),
                  ),
                ),
                Positioned(
                  top: 6.5,
                  left: 9.5,
                  child: CustomButton(
                    text: "CANCEL",
                    onTap: () {
                      UtilFunctions.navigateToBackward(context);
                    },
                    width: 158,
                    height: 43,
                    radius: 39,
                    fontsize: 13,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
