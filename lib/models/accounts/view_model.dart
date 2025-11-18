class AccountViewModel {
  final String name;
  final String owner;
  final String expirationDate;
  final String lastFourNumbers;
  final double currentAmount;

  const AccountViewModel({
    required this.name,
    required this.currentAmount,
    required this.expirationDate,
    required this.lastFourNumbers,
    required this.owner,
  });
}
