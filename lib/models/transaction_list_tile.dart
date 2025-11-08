class TransactionListTile {
  final String name;
  final String type;
  final String ammount;
  final String date;
  final bool isActive;
  void Function(void) onDelete;
  TransactionListTile({
    required this.name,
    required this.type,
    required this.ammount,
    required this.date,
    required this.isActive,
    required this.onDelete,
  });
}
