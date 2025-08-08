import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  bool _isInitialized = false;

  // Getter para o usuário atual
  UserModel? get currentUser => _currentUser;

  // Getter para verificar se está autenticado
  bool get isAuthenticated => _currentUser?.isAuthenticated ?? false;

  // Getter para verificar se foi inicializado
  bool get isInitialized => _isInitialized;

  // Inicializar o serviço (simula carregamento do usuário)
  Future<void> initialize() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simula carregamento
    
    // Por enquanto, vamos usar um usuário de exemplo
    // Futuramente isso será substituído pela autenticação real
    _currentUser = UserModel.sampleUser;
    _isInitialized = true;
  }

  // Login do usuário
  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 1000)); // Simula requisição
    
    // Simulação de login - aceita qualquer email/senha por enquanto
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _extractNameFromEmail(email),
        email: email,
        planType: PlanType.free,
        isAuthenticated: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      return true;
    }
    return false;
  }

  // Logout do usuário
  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 300));
    _currentUser = null;
  }

  // Atualizar perfil do usuário
  Future<bool> updateProfile({
    String? name,
    String? profileImagePath,
  }) async {
    if (_currentUser == null) return false;
    
    await Future.delayed(Duration(milliseconds: 500));
    
    _currentUser = _currentUser!.copyWith(
      name: name,
      profileImagePath: profileImagePath,
      updatedAt: DateTime.now(),
    );
    
    return true;
  }

  // Atualizar plano do usuário
  Future<bool> upgradeToPremium() async {
    if (_currentUser == null) return false;
    
    await Future.delayed(Duration(milliseconds: 1000)); // Simula processamento de pagamento
    
    _currentUser = _currentUser!.copyWith(
      planType: PlanType.premium,
      updatedAt: DateTime.now(),
    );
    
    return true;
  }

  // Downgrade para plano gratuito
  Future<bool> downgradeToFree() async {
    if (_currentUser == null) return false;
    
    await Future.delayed(Duration(milliseconds: 500));
    
    _currentUser = _currentUser!.copyWith(
      planType: PlanType.free,
      updatedAt: DateTime.now(),
    );
    
    return true;
  }

  // Verificar se o usuário pode acessar recursos premium
  bool canAccessPremiumFeatures() {
    return _currentUser?.isPremium ?? false;
  }

  // Método auxiliar para extrair nome do email
  String _extractNameFromEmail(String email) {
    String username = email.split('@').first;
    // Capitalizar primeira letra
    return username.isNotEmpty 
        ? username[0].toUpperCase() + username.substring(1)
        : 'Usuário';
  }

  // Simular registro de novo usuário
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(Duration(milliseconds: 1200)); // Simula requisição
    
    // Simulação de registro - aceita qualquer dados por enquanto
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      _currentUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        planType: PlanType.free,
        isAuthenticated: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      return true;
    }
    return false;
  }

  // Verificar se email já existe (simulação)
  Future<bool> emailExists(String email) async {
    await Future.delayed(Duration(milliseconds: 300));
    // Por enquanto sempre retorna false (email disponível)
    return false;
  }

  // Reset de senha (simulação)
  Future<bool> resetPassword(String email) async {
    await Future.delayed(Duration(milliseconds: 800));
    // Simula envio de email de reset
    return email.isNotEmpty && email.contains('@');
  }
}