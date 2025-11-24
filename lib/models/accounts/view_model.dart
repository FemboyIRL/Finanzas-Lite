enum AccountType { zero, cash, credit, debit, savings }

extension AccountTypeExtension on AccountType {
  String get dbValue {
    switch (this) {
      case AccountType.cash:
        return "cash";
      case AccountType.credit:
        return "credit";
      case AccountType.debit:
        return "debit";
      case AccountType.savings:
        return "savings";
      case AccountType.zero:
        return "zero";
    }
  }

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
  final String id;
  final String name;
  final String userId;
  final String owner;
  final String expirationDate;
  final String lastFourNumbers;
  final AccountType type;
  final double currentAmount;

  const AccountViewModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.currentAmount,
    required this.expirationDate,
    required this.lastFourNumbers,
    required this.type,
    required this.owner,
  });

  factory AccountViewModel.fromJson(Map<String, dynamic> json) {
    return AccountViewModel(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      owner: json['owner'],
      expirationDate: json['expiration_date'].toString(),
      lastFourNumbers: json['last_four_numbers'],
      type: _mapType(json['type']),
      currentAmount: double.parse(json['current_amount'].toString()),
    );
  }

  static AccountType _mapType(String? value) {
    switch (value) {
      case 'debit':
        return AccountType.debit;
      case 'credit':
        return AccountType.credit;
      case 'savings':
        return AccountType.savings;
      case 'cash':
        return AccountType.cash;
      default:
        return AccountType.debit;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'owner': owner,
      'expiration_date': expirationDate,
      'last_four_numbers': lastFourNumbers,
      'type': type.dbValue,
      'current_amount': currentAmount,
    };
  }
}
