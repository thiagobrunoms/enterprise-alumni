import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/common/router/router.dart';
import 'package:flutter_test_template/profile/domain/cm_get_profile.dart';
import 'package:flutter_test_template/profile/presentation/profile_navigation.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

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

          if (_cmGetProfile.error != null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Text('An error occurred while retrieving profile data, please try again later'),
              ),
            );
          }

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
                        if (_cmGetProfile.result?.image != null)
                          CircleAvatar(
                            backgroundImage: NetworkImage(_cmGetProfile.result!.image!),
                            radius: 42,
                          ),
                        const SizedBox(height: 18),
                        Text(
                          '${_cmGetProfile.result?.firstName} ${_cmGetProfile.result?.lastName}',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 18),
                        OutlinedButton(
                          onPressed: ProfileNavigation().goToProducts,
                          child: const Text('Back'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
