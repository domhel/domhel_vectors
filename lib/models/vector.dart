class Vec2 {
  final num x;
  final num y;

  Vec2(this.x, this.y);
}

class Vec {
  final List<num> _v;

  operator [](int index) => _v[index];

  Vec(this._v);
}
