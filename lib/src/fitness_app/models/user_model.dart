enum PlanType {
  free,
  premium,
}

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.planType,
    this.profileImagePath,
    this.isAuthenticated = false,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String email;
  final PlanType planType;
  final String? profileImagePath;
  final bool isAuthenticated;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Método para verificar se o usuário tem plano premium
  bool get isPremium => planType == PlanType.premium;

  // Método para obter o nome do plano
  String get planName {
    switch (planType) {
      case PlanType.free:
        return 'Free';
      case PlanType.premium:
        return 'Premium';
    }
  }

  // Método para criar uma cópia do usuário com novos valores
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    PlanType? planType,
    String? profileImagePath,
    bool? isAuthenticated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      planType: planType ?? this.planType,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Método para converter para Map (útil para Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'planType': planType.toString().split('.').last,
      'profileImagePath': profileImagePath,
      'isAuthenticated': isAuthenticated,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Método para criar UserModel a partir de Map (útil para Firebase)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      planType: PlanType.values.firstWhere(
        (e) => e.toString().split('.').last == map['planType'],
        orElse: () => PlanType.free,
      ),
      profileImagePath: map['profileImagePath'],
      isAuthenticated: map['isAuthenticated'] ?? false,
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      updatedAt: map['updatedAt'] != null 
          ? DateTime.parse(map['updatedAt']) 
          : null,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, planType: $planType, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.planType == planType &&
        other.profileImagePath == profileImagePath &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        planType.hashCode ^
        profileImagePath.hashCode ^
        isAuthenticated.hashCode;
  }

  // Dados de exemplo para desenvolvimento
  static final UserModel sampleUser = UserModel(
    id: '1',
    name: 'João Silva',
    email: 'joao.silva@email.com',
    planType: PlanType.free,
    profileImagePath: null,
    isAuthenticated: true,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now(),
  );

  static final UserModel premiumUser = UserModel(
    id: '2',
    name: 'Maria Santos',
    email: 'maria.santos@email.com',
    planType: PlanType.premium,
    profileImagePath: null,
    isAuthenticated: true,
    createdAt: DateTime.now().subtract(const Duration(days: 90)),
    updatedAt: DateTime.now(),
  );
}