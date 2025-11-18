enum AccountType { zero, cash, credit, debit, savings }

extension AccountTypeExtension on AccountType {
  String get icon {
    switch (this) {
      case AccountType.zero:
        return "";
      case AccountType.cash:
        return "assets/svgs/accounts/cash.svg";
      case AccountType.credit:
        return "assets/svgs/accounts/credit.svg";
      case AccountType.debit:
        return "assets/svgs/accounts/debit.svg";
      case AccountType.savings:
        return "assets/svgs/accounts/savings.svg";
    }
  }
}

class AccountViewModel {
  final String name;
  final String owner;
  final String expirationDate;
  final String lastFourNumbers;
  final AccountType type;
  final double currentAmount;

  const AccountViewModel({
    required this.name,
    required this.currentAmount,
    required this.expirationDate,
    required this.lastFourNumbers,
    required this.type,
    required this.owner,
  });
}
