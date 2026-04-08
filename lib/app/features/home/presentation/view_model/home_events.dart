sealed class HomeEvents {}

class ChangeTabEvent extends HomeEvents {
  final int index;

  ChangeTabEvent(this.index);
}

class HomeEvent extends HomeEvents{}