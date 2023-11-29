import 'package:flutter/material.dart';
import 'package:shopy/modules/shop_login/login.dart';
import 'package:shopy/network/local/cache_helper.dart';
import 'package:shopy/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Layout'),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then((value) {
            if (value) {
              navigateAndFinish(context, ShopLogInScreen());
          }});
        },
        child: const Text('Sign Out'),
      ),
    );
  }
}
