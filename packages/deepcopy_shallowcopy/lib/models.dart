class Item {
  int value;
  Item(this.value);
}

class Container {
  List<Item> items;
  Container(this.items);

  // シャローコピー
  Container shallowCopy() {
    return this;
  }

  // ディープコピー
  Container deepCopy() {
    return Container(items.map((item) => Item(item.value)).toList());
  }
}
