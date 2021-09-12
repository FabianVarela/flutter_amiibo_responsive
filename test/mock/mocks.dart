import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

/// Client

class MockClient extends Mock implements Client {}

class MyUriFake extends Fake implements Uri {}

/// Models

class MyAmiiboFake extends Fake implements AmiiboModel {}
