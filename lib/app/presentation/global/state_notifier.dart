import 'package:flutter/foundation.dart';

abstract class StateNotifier<T> extends ChangeNotifier {
  T _state, _prevState;
  bool _isMounted = true;

  StateNotifier(this._state): _prevState = _state;

  T get state => _state;
  T get prevState => _prevState;
  bool get isMounted => _isMounted;

  set state(T newState) {
    _update(newState);
  }

  void onlyUpdate(T newState) {
    _update(newState, notify: false);
  }

  void _update(T newState, { bool notify = true }) {
    if (_state != newState) {
      _prevState = _state;
      _state = newState;
      if (notify) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }
}