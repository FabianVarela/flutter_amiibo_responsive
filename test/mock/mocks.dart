import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

/// Http Client

final class MockClient extends Mock implements Client {}

final class MyUriFake extends Fake implements Uri {}

/// Client

final class MockAmiiboClient extends Mock implements AmiiboClient {}

/// Repository

final class MockAmiiboRepository extends Mock implements AmiiboRepository {}

/// Models

final class MyAmiiboFake extends Fake implements AmiiboModel {}
