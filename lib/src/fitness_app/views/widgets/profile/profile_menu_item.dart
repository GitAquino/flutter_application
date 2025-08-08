import 'package:flutter/material.dart';
import '../../../config/fitness_app_theme.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key? key,
    this.animationController,
    this.animation,
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.showArrow = true,
    this.isDestructive = false,
    this.trailing,
  }) : super(key: key);

  final AnimationController? animationController;
  final Animation<double>? animation;
  final String title;
  final IconData icon;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showArrow;
  final bool isDestructive;
  final Widget? trailing;

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
                  left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FitnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Ícone
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDestructive
                                  ? Colors.red.withOpacity(0.1)
                                  : FitnessAppTheme.nearlyBlue.withOpacity(0.1),
                            ),
                            child: Icon(
                              icon,
                              size: 24,
                              color: isDestructive
                                  ? Colors.red
                                  : FitnessAppTheme.nearlyBlue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Título e subtítulo
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: isDestructive
                                        ? Colors.red
                                        : FitnessAppTheme.darkerText,
                                  ),
                                ),
                                if (subtitle != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    subtitle!,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: FitnessAppTheme.grey,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Trailing widget ou seta
                          if (trailing != null)
                            trailing!
                          else if (showArrow)
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: FitnessAppTheme.grey,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widget para switch/toggle
class ProfileMenuSwitch extends StatelessWidget {
  const ProfileMenuSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: FitnessAppTheme.nearlyBlue,
      activeTrackColor: FitnessAppTheme.nearlyBlue.withOpacity(0.3),
      inactiveThumbColor: FitnessAppTheme.grey,
      inactiveTrackColor: FitnessAppTheme.grey.withOpacity(0.3),
    );
  }
}

// Widget para badge de notificação
class ProfileMenuBadge extends StatelessWidget {
  const ProfileMenuBadge({
    Key? key,
    required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: TextStyle(
          fontFamily: FitnessAppTheme.fontName,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: FitnessAppTheme.white,
        ),
      ),
    );
  }
}