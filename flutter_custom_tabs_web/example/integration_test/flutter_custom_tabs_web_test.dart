import 'dart:html';

import 'package:flutter_custom_tabs_platform_interface/flutter_custom_tabs_platform_interface.dart';
import 'package:flutter_custom_tabs_web/flutter_custom_tabs_web.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mock_url_launcher_plugin.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockUrlLauncherPlugin mock;
  late CustomTabsPlugin plugin;
  setUp(() {
    mock = MockUrlLauncherPlugin();
    UrlLauncherPlatform.instance = mock;

    plugin = CustomTabsPlugin();
  });

  testWidgets('launch: delegate to url_launcher_web', (WidgetTester _) async {
    when(mock.launch(
      any,
      useSafariVC: anyNamed('useSafariVC'),
      useWebView: anyNamed('useWebView'),
      enableJavaScript: anyNamed('enableJavaScript'),
      enableDomStorage: anyNamed('enableDomStorage'),
      universalLinksOnly: anyNamed('universalLinksOnly'),
      headers: anyNamed('headers'),
      webOnlyWindowName: anyNamed('webOnlyWindowName'),
    )).thenAnswer((_) async => true);

    final url = 'https://example.com';
    await plugin.launch(
      url,
      customTabsOption: const CustomTabsOption(),
      safariVCOption: const SafariViewControllerOption(),
    );

    verify(mock.launch(url));
  });
}
