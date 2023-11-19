import 'package:flutter_bull/src/views/new/notifiers/app/app_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ConsumerFunctions<T extends ConsumerStatefulWidget> on ConsumerState<T> {

  AppNotifier get appNotifier => ref.read(appNotifierProvider.notifier);

  void hideAuthBar() {
    appNotifier.setAuthBarState(AuthBarState.hide);
  }

  void showAuthBar() {
    appNotifier.setAuthBarState(AuthBarState.show);
  }

}