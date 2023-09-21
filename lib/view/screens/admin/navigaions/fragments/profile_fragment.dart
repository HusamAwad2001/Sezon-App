import 'package:flutter/material.dart';
import 'package:sezon_app/core/constants/empty_padding.dart';
import 'package:sezon_app/core/storage/global.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(Global.user['userName']),
            ),
            10.ph,
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(Global.user['phone']),
            ),
          ],
        ),
      ),
    );
  }
}
