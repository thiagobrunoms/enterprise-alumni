// This is a module of custom hooks to use together with the flutter_hooks library to manage the application state.
import 'package:async/async.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseAsyncResult<Result> {
  Result?   result;
  Object?   error;
  bool      running;
  
  UseAsyncResult({ 
    required this.running, 
    required this.result, 
    required this.error 
  });

  UseAsyncResult<Result> copyWith({
    Result? result,
    Object? error,
    bool?   running,
  }) => 
    UseAsyncResult<Result>(
      error   : error ?? this.error,
      result  : result ?? this.result,
      running : running ?? this.running
    );
}

class UseCallAsyncResult<Result, Params> {
  Result?                       result;
  Object?                       error;
  bool                          running;
  void Function(Params params)  call;
  
  UseCallAsyncResult({ 
    required this.running, 
    required this.result, 
    required this.error, 
    required this.call 
  }) ;
}

// This hook is useful when you need to call an async function when 
// your component is created or one of the specified values (passed as a key list parameter [keys]) change
// 
// It returns a [UseAsyncResult] that automatically rebuilds the component when any values changes
// 
// ...
// Widget build(BuildContext context) {
//   final result = useAsync(async () => myFunction(),[])
// 
//   // Function is Runing
//   if(result.running){ 
//     return const Center(child: CircularProgressIndicator());
//   }
// 
//   //Function execution was terminate with error, show error message to user
//   if(result.error != null){  
//        return const Center(child: Text("An error occurs in function"));
//   }
//   
//   //Function execution was terminated without error, show result to user
//   return const Center(child: Text(result.result.toString()));
//   ....
// }
//
UseAsyncResult<Result> useAsync<Result>(Future<Result> Function() fn, List<Object?>? keys, { bool? clearResult }) {
  final state  = useState<UseAsyncResult<Result>>(UseAsyncResult(
    running: false,
    result: null,
    error: null
  ));

  useEffect((){  
      state.value = clearResult == true 
        ? UseAsyncResult(running: true, result: null, error: null)
        : state.value.copyWith(
            running: true
          );
      var op = CancelableOperation.fromFuture(fn())
        .then(
          (res){
            state.value = state.value.copyWith(
              running: false,
              result: res
            );
          },
          onError: (err, stacktrace){
            state.value = state.value.copyWith(
              running: false,
              error: err
            );
          }
        );
      return () =>
        op.cancel();
  }, keys);

  return state.value;
}

// This hook is useful when you need to call an async function from 
// your component and want to rebuild the component while the function is running or retuned
// 
// It returns a [UseCallAsyncResult] that automatically rebuilds the component when any values changes
// 
// ...
// Widget build(BuildContext context) {
//   final _myFunction = useCallAssync(myFunction,[])
// 
//   // Function is Runing
//   if(_myFunction.running){ 
//     return const Center(child: CircularProgressIndicator());
//   }
// 
//   //Function execution was terminate with error, show error message to user
//   if(_myFunction.error != null){  
//        return const Center(child: Text("An error occurs in function"));
//   }
//   
//   return const Column(
//      children: [
//        Text(_myFunction.result.toString()),  //Function execution result
//        Button(
//          onPress = (){
//            _myFunction.call()                //Call function when button pressed
//          }
//        )
//      ]);
//   ....
// }
//
UseCallAsyncResult<Result, Params> useCallAsync<Result, Params>(Future<Result> Function(Params params) fn, {List<Object?>? keys}) {
  final state = useState<dynamic>({
    'running': false,
    'result' : null,
    'error'  : null
  });
  final call = useCallback((Params params) async {
      state.value = {
        'running': true,
        'result' : null,
        'error'  : null
      };
      try{
        var res         = await fn(params);
        state.value = {
          'running': false,
          'result' : res,
          'error'  : null
        };
      }
      catch(err){
        state.value = {
          'running': false,
          'result' : null,
          'error'  : err
        };
      }
    }, keys ?? []);

  return UseCallAsyncResult<Result, Params>(
    running: state.value['running'] as bool,
    result : state.value['result'] as Result?,
    error  : state.value['error'],
    call   : call
  );
}