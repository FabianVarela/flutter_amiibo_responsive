import 'package:flutter/material.dart';
import 'package:flutter_amiibo_responsive/client/amiibo_client.dart';
import 'package:flutter_amiibo_responsive/model/amiibo_model.dart';
import 'package:flutter_amiibo_responsive/repository/amiibo_repository.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

/// Routes

class MockNavigator extends Mock implements NavigatorObserver {}

class MyRouteFake extends Fake implements Route<dynamic> {}

/// Http Client

class MockClient extends Mock implements Client {}

class MyUriFake extends Fake implements Uri {}

/// Client

class MockAmiiboClient extends Mock implements AmiiboClient {}

/// Repository

class MockAmiiboRepository extends Mock implements AmiiboRepository {}

/// Models

class MyAmiiboFake extends Fake implements AmiiboModel {}
