class User {
  const User({
    required this.id,
    required this.createdAt,
    required this.avatar,
    required this.name,
  });

  const User.empty()
      : this(
            id: 1,
            createdAt: '_empty.createdAt',
            name: '_empty.name',
            avatar: '_empty.avatar');
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        other is User &&
            other.runtimeType == runtimeType &&
            other.id == id &&
            other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
