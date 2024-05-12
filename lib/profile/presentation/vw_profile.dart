import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/profile/domain/cm_get_profile.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

import '../../common/api/http_client.dart';

class VwProfile extends HookWidget {
  const VwProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var _cmGetProfile = useAsync(() async => await cmGetProfile(), []);

    return Scaffold(
      body: Builder(
        builder: (context) {
          if (_cmGetProfile.running) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_cmGetProfile.error != null || _cmGetProfile.result!.$1 != null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text('An error occurred while retrieving profile data, please try again later'),
              ),
            );
          }

          if (_cmGetProfile.result case final result) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (result!.$2?.image != null)
                            CircleAvatar(
                              backgroundImage: NetworkImage(result.$2!.image!),
                              radius: 42,
                            ),
                          const SizedBox(height: 18),
                          Text(
                            '${result.$2!.firstName} ${result.$2!.lastName}',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 18),
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Back'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
