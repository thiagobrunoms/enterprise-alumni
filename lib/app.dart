import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test_template/auth/vw_login.dart';
import 'package:flutter_test_template/products/vw_products.dart';
import 'package:flutter_test_template/utils/ut_dummy_json_api/ut_dummy_json_api.dart';

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var _reload = useState(0);

    useEffect(() {
      var cancelOnLoggedInSub =
          utJsonDummyApi.subscribe(UtDummyJsonApiEvents.LOGGED_IN, () {
        _reload.value++;
      });
      var cancelOnLoggedOutSub =
          utJsonDummyApi.subscribe(UtDummyJsonApiEvents.LOGGED_OUT, () {
        _reload.value++;
      });
      return () {
        cancelOnLoggedInSub();
        cancelOnLoggedOutSub();
      };
    }, []);

    return MaterialApp(
      title: 'Flutter Alumni Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: utJsonDummyApi.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return const VwProducts();
            }

            return const VwLogin();
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
