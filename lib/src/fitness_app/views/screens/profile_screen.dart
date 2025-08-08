import 'package:flutter/material.dart';
import '../../config/fitness_app_theme.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/profile_menu_item.dart';
import '../widgets/ui_components/title_view.dart';

class ProfileMenuItemData {
  final String title;
  final IconData icon;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isDestructive;
  final Widget? trailing;

  ProfileMenuItemData({
    required this.title,
    required this.icon,
    this.subtitle,
    required this.onTap,
    this.isDestructive = false,
    this.trailing,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  final AuthService _authService = AuthService();
  UserModel? currentUser;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    
    _loadUserData();
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void _loadUserData() async {
    if (!_authService.isInitialized) {
      await _authService.initialize();
    }
    setState(() {
      currentUser = _authService.currentUser ?? UserModel.sampleUser;
    });
  }

  List<ProfileMenuItemData> _buildMenuItems() {
    return [
      ProfileMenuItemData(
        title: 'Dados Pessoais',
        icon: Icons.person_outline,
        subtitle: 'Editar informações do perfil',
        onTap: () => _navigateToPersonalData(),
      ),
      ProfileMenuItemData(
        title: 'Notificações',
        icon: Icons.notifications_outlined,
        subtitle: 'Configurar alertas e lembretes',
        onTap: () => _navigateToNotifications(),
      ),
      ProfileMenuItemData(
        title: 'Privacidade e Segurança',
        icon: Icons.security_outlined,
        subtitle: 'Gerenciar dados e privacidade',
        onTap: () => _navigateToPrivacy(),
      ),
      ProfileMenuItemData(
        title: 'Plano Premium',
        icon: Icons.star_outline,
        subtitle: currentUser?.isPremium == true 
            ? 'Gerenciar assinatura' 
            : 'Upgrade para Premium',
        onTap: () => _navigateToPremium(),
      ),
      ProfileMenuItemData(
        title: 'Ajuda e Suporte',
        icon: Icons.help_outline,
        subtitle: 'FAQ e contato',
        onTap: () => _navigateToHelp(),
      ),
      ProfileMenuItemData(
        title: 'Sobre o App',
        icon: Icons.info_outline,
        subtitle: 'Versão e informações',
        onTap: () => _navigateToAbout(),
      ),
      ProfileMenuItemData(
        title: 'Sair',
        icon: Icons.logout,
        subtitle: 'Fazer logout da conta',
        onTap: () => _handleLogout(),
        isDestructive: true,
      ),
    ];
  }

  void addAllListData() {
    const int count = 9;
    final menuItems = _buildMenuItems();

    // Header do perfil
    listViews.add(
      ProfileHeader(
        animationController: widget.animationController!,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        user: currentUser,
        onImageTap: _handleImageTap,
      ),
    );

    // Título das configurações
    listViews.add(
      TitleView(
        titleTxt: 'Configurações',
        subTxt: 'Personalize sua experiência',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    // Menu de configurações
    for (int i = 0; i < menuItems.length; i++) {
       final item = menuItems[i];
       listViews.add(
         ProfileMenuItem(
           animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
               parent: widget.animationController!,
               curve: Interval((1 / count) * (i + 2), 1.0, curve: Curves.fastOutSlowIn))),
           animationController: widget.animationController!,
           icon: item.icon,
           title: item.title,
           subtitle: item.subtitle,
           onTap: item.onTap,
           isDestructive: item.isDestructive,
         ),
       );
     }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Perfil',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: () => _handleSettings(),
                                child: Center(
                                  child: Icon(
                                    Icons.settings,
                                    color: FitnessAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  // Handlers para as ações
  void _handleImageTap() {
    // TODO: Implementar seleção de imagem
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Funcionalidade de alterar foto em desenvolvimento'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }

  void _navigateToPersonalData() {
    // TODO: Navegar para tela de dados pessoais
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tela de dados pessoais em desenvolvimento'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }

  void _navigateToNotifications() {
    // TODO: Navegar para tela de notificações
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Configurações de notificação em desenvolvimento'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }

  void _navigateToPrivacy() {
    // TODO: Navegar para tela de privacidade
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Configurações de privacidade em desenvolvimento'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }

  void _navigateToPremium() {
    if (currentUser?.isPremium == true) {
      // TODO: Navegar para gerenciamento de plano
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gerenciamento de plano em desenvolvimento'),
          backgroundColor: FitnessAppTheme.nearlyBlue,
        ),
      );
    } else {
      // TODO: Navegar para upgrade premium
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upgrade para Premium em desenvolvimento'),
          backgroundColor: FitnessAppTheme.nearlyBlue,
        ),
      );
    }
  }

  void _navigateToHelp() {
    // TODO: Navegar para tela de ajuda
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Central de ajuda em desenvolvimento'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }

  void _navigateToAbout() {
    // TODO: Navegar para tela sobre o app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Informações sobre o app em desenvolvimento'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }

  void _handleSettings() {
    // TODO: Navegar para configurações gerais
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Configurações gerais em desenvolvimento'),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar Logout',
            style: TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w600,
              color: FitnessAppTheme.darkerText,
            ),
          ),
          content: Text(
            'Tem certeza que deseja sair da sua conta?',
            style: TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              color: FitnessAppTheme.darkText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  color: FitnessAppTheme.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _authService.logout();
                // TODO: Navegar para tela de login
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logout realizado com sucesso'),
                    backgroundColor: FitnessAppTheme.nearlyBlue,
                  ),
                );
              },
              child: Text(
                'Sair',
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}