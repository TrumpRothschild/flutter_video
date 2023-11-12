

/// dart自带的map和foreach默认不回传当前元素index 所以自己实现了一个
/// 在想使用的地方引入common.dart 即可
/// List.mapIndexed<String>(cb);

extension ExtendedIterable<E> on Iterable<E> {

  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

