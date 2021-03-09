import 'package:movas/provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/movas/observable/theme/theme_observable.dart';

class ThemeStoree {
  BehaviorSubject<ThemeO> themeO$;

  ThemeO selectedTheme;

  ThemeStoree(this.selectedTheme) {
    themeO$ = BehaviorSubject<ThemeO>.seeded(selectedTheme);
  }

  void updateObservable() => themeO$.add(selectedTheme);

  void changeTheme(ThemeO theme) {
    selectedTheme = theme;
    updateObservable();
  }

  void dispose() {
    themeO$.close();
  }
}

class ThemeStore extends Store<ThemeO> {
  ThemeStore(ThemeO theme) {
    add(theme);
  }

  Future<void> changeTheme(ThemeO theme) {
    add(theme);
  }
}
