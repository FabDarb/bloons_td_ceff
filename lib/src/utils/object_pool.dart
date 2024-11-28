class ObjectPool<T> {
  List<T> _availables = [];
  List<T> _inUses = [];

  T aquireObject(T Function() creationFunct, {Function(T object)? initFunct}) {
    if (_availables.isEmpty) {
      T object = creationFunct();
      _inUses = [..._inUses, object];
      if (initFunct != null) {
        initFunct(object);
      }
      return object;
    } else {
      T object = _availables.last;
      _availables =
          _availables.where((obj) => obj != _availables.last).toList();
      _inUses = [..._inUses, object];
      if (initFunct != null) {
        initFunct(object);
      }
      return object;
    }
  }

  void release(T object, {Function(T object)? destroyeFunct}) {
    _inUses = _inUses.where((obj) => obj != object).toList();
    _availables = [..._availables, object];
    if (destroyeFunct != null) {
      destroyeFunct(object);
    }
  }
}
