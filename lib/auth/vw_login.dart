import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/auth/cm_do_login.dart';
import 'package:flutter_test_template/utils/ut_custom_hooks.dart';

class VwLogin extends HookWidget {
  const VwLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var _userNameTextController = useTextEditingController();
    var _passwordTextController = useTextEditingController();

    var _cmDoLogin = useCallAsync(cmDoLogin);
    _userNameTextController.text = 'kminchelle';
    _passwordTextController.text = '0lelplR';

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Login',
                          style: Theme.of(context).textTheme.headlineLarge),
                      TextField(
                        controller: _userNameTextController,
                        decoration:
                            const InputDecoration(label: Text('Username')),
                      ),
                      TextField(
                        controller: _passwordTextController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text('Password'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (_cmDoLogin.error != null)
                        Text(
                            (_cmDoLogin.error is DioException)
                                ? (_cmDoLogin.error as DioException)
                                    .response
                                    ?.data['message']
                                : 'An error occurred while logging in, please try later',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.error)),
                      Builder(builder: (context) {
                        if (_cmDoLogin.running) {
                          return const CircularProgressIndicator();
                        }

                        return OutlinedButton(
                            onPressed: () {
                              _cmDoLogin.call(CmDoLoginParams(
                                  userName: _userNameTextController.text,
                                  password: _passwordTextController.text));
                            },
                            child: const Text('Login'));
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
