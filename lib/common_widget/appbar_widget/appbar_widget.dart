import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppBarWidget extends AppBar {
  final BuildContext context;
  final String appTitle;
  final VoidCallback  onBackClick;
  AppBarWidget(
      {super.key,
      required this.appTitle,
      required this.context,
      required this.onBackClick
      })
      : super(
          backgroundColor: Colors.transparent,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appTitle.tr,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
              onPressed: onBackClick,
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,)),
        );
}
