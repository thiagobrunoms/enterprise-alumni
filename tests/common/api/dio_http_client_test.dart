import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_template/common/api/dio_http_client.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements DioHttpClient {}

class MockResponse extends Mock implements ApiResponse {}

void main() {
  late MockHttpClient mockHttp;
  late MockResponse mockDioResponse;

  setUp(() {
    mockHttp = MockHttpClient();
    mockDioResponse = MockResponse();
  });

  test('GET request success with Dio', () async {
    when(() => mockHttp.get(any())).thenAnswer((_) async => mockDioResponse);

    final response = await mockHttp.get('example.com');

    expect(response, isA<ApiResponse>());
  });

  test('POST request success', () async {
    when(() => mockHttp.post(any(), {})).thenAnswer((_) async => mockDioResponse);

    final response = await mockHttp.post('example.com', {});

    expect(response, isA<ApiResponse>());
  });

  test('PUT request success', () async {
    when(() => mockHttp.put(any(), {})).thenAnswer((_) async => mockDioResponse);

    final response = await mockHttp.put('example.com', {});

    expect(response, isA<ApiResponse>());
  });

  test('DELETE request success', () async {
    when(() => mockHttp.delete(any(), data: {})).thenAnswer((_) async => mockDioResponse);

    final response = await mockHttp.delete('example.com', data: {});

    expect(response, isA<ApiResponse>());
  });
}

const String mockBasicResponse = r'''{'key': 'value'}''';

const String mockResponseJson = r'''{
  "products": [
    {
      "id": 1,
      "title": "iPhone 9",
      "description": "An apple mobile which is nothing like apple",
      "price": 549,
      "discountPercentage": 12.96,
      "rating": 4.69,
      "stock": 94,
      "brand": "Apple",
      "category": "smartphones",
      "thumbnail": "...",
      "images": ["...", "...", "..."]
    },
  ],
  "total": 100,
  "skip": 0,
  "limit": 30
}''';
