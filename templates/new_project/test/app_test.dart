@TestOn('browser')
import 'package:ngtest/ngtest.dart';
import 'package:test/test.dart';
import 'package:__projectName__/app_component.dart';
import 'package:__projectName__/app_component.template.dart' as ng;

// Testing info: https://angulardart.xyz/guide/testing

void main() {
  final testBed = NgTestBed<AppComponent>(ng.AppComponentNgFactory);
  NgTestFixture<AppComponent> fixture;

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('heading', () {
    expect(fixture.text, contains('My First AngularDart App'));
  });
}
