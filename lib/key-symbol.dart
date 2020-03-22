enum KeyType { CLEAR, FUNCTION, INTEGER, DECIMAL }

class KeySymbol {
  KeySymbol(this.value, {this.keyType = KeyType.INTEGER, this.altText});
  final String value;
  final KeyType keyType;
  String altText;

  @override
  String toString() => value;
}
