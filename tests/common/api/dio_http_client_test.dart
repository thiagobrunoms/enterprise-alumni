import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_template/common/api/dio_http_client.dart';
import 'package:flutter_test_template/common/api/http_client.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

class MockDioException extends Mock implements DioException {}

void main() {
  late DioHttpClient dioHttpClient;
  late MockDio mockDio;
  late MockResponse mockDioResponse;
  late MockDioException mockDioException;

  setUp(() {
    mockDio = MockDio();
    dioHttpClient = DioHttpClient(mockDio);
    mockDioResponse = MockResponse();
    mockDioException = MockDioException();
  });

  test('GET request success', () async {
    when(() => mockDio.get(any())).thenAnswer((_) async => mockDioResponse);

    final response = await dioHttpClient.get('example.com');

    expect(response, isA<(BasicApiFailure?, ApiResponse)>());
  });

  test('GET request failure', () async {
    when(() => mockDio.get(any())).thenThrow(mockDioException);

    final response = await dioHttpClient.get('example.com');

    expect(response, isA<(BasicApiFailure, ApiResponse?)>());
  });

  test('POST request success', () async {
    when(() => mockDio.post(any(), data: {})).thenAnswer((_) async => mockDioResponse);

    final response = await dioHttpClient.post('example.com', {});

    expect(response, isA<(BasicApiFailure?, ApiResponse)>());
  });

  test('POST request failure', () async {
    when(() => mockDio.post(any(), data: {})).thenThrow(mockDioException);

    final response = await dioHttpClient.post('example.com', {});

    expect(response, isA<(BasicApiFailure, ApiResponse?)>());
  });

  test('PUT request success', () async {
    when(() => mockDio.put(any(), data: {})).thenAnswer((_) async => mockDioResponse);

    final response = await dioHttpClient.put('example.com', {});

    expect(response, isA<(BasicApiFailure?, ApiResponse)>());
  });

  test('PUT request failure', () async {
    when(() => mockDio.put(any(), data: {})).thenThrow(mockDioException);

    final response = await dioHttpClient.put('example.com', {});

    expect(response, isA<(BasicApiFailure, ApiResponse?)>());
  });

  test('DELETE request success', () async {
    when(() => mockDio.delete(any(), data: {})).thenAnswer((_) async => mockDioResponse);

    final response = await dioHttpClient.delete('example.com', data: {});

    expect(response, isA<(BasicApiFailure?, ApiResponse)>());
  });

  test('DELETE request failure', () async {
    when(() => mockDio.delete(any(), data: {})).thenThrow(mockDioException);

    final response = await dioHttpClient.delete('example.com', data: {});

    expect(response, isA<(BasicApiFailure, ApiResponse?)>());
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
