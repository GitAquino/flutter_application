import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';
import '../../../models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    this.animationController,
    this.animation,
    this.user,
    this.onImageTap,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;
  final UserModel? user;
  final VoidCallback? onImageTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Foto do perfil e informações básicas
                      Row(
                        children: [
                          // Foto do perfil
                          GestureDetector(
                            onTap: onImageTap,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: FitnessAppTheme.nearlyBlue.withOpacity(0.1),
                                border: Border.all(
                                  color: FitnessAppTheme.nearlyBlue,
                                  width: 2,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Imagem do usuário ou ícone padrão
                                  Center(
                                    child: user?.profileImagePath != null
                                        ? ClipOval(
                                            child: Image.asset(
                                              user!.profileImagePath!,
                                              width: 76,
                                              height: 76,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color: FitnessAppTheme.nearlyBlue,
                                                );
                                              },
                                            ),
                                          )
                                        : Icon(
                                            Icons.person,
                                            size: 40,
                                            color: FitnessAppTheme.nearlyBlue,
                                          ),
                                  ),
                                  // Ícone de edição
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: FitnessAppTheme.nearlyBlue,
                                        border: Border.all(
                                          color: FitnessAppTheme.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 12,
                                        color: FitnessAppTheme.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Informações do usuário
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nome
                                Text(
                                  user?.name ?? 'Nome do Usuário',
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Email
                                Text(
                                  user?.email ?? 'email@exemplo.com',
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: FitnessAppTheme.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Badge do plano
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: user?.isPremium == true
                                        ? FitnessAppTheme.nearlyBlue
                                        : FitnessAppTheme.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        user?.isPremium == true
                                            ? Icons.star
                                            : Icons.person_outline,
                                        size: 14,
                                        color: user?.isPremium == true
                                            ? FitnessAppTheme.white
                                            : FitnessAppTheme.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        user?.planName ?? 'Free',
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: user?.isPremium == true
                                              ? FitnessAppTheme.white
                                              : FitnessAppTheme.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Estatísticas do usuário (opcional)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                'Dias Ativos',
                                '${DateTime.now().difference(user?.createdAt ?? DateTime.now()).inDays}',
                                Icons.calendar_today,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: FitnessAppTheme.grey.withOpacity(0.3),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Plano',
                                user?.planName ?? 'Free',
                                user?.isPremium == true ? Icons.star : Icons.person,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: FitnessAppTheme.grey.withOpacity(0.3),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Status',
                                user?.isAuthenticated == true ? 'Ativo' : 'Inativo',
                                user?.isAuthenticated == true 
                                    ? Icons.check_circle 
                                    : Icons.error_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: FitnessAppTheme.nearlyBlue,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: FitnessAppTheme.fontName,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: FitnessAppTheme.darkerText,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: FitnessAppTheme.fontName,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: FitnessAppTheme.grey,
          ),
        ),
      ],
    );
  }
}