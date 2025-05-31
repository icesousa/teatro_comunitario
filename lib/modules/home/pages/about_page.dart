import 'package:flutter/material.dart';
import 'package:faculdadeextensao/core/constants.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  double _responsiveFontSize(BuildContext context, {double baseDesktop = 48, double baseMobile = 32}) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return baseDesktop;
    if (width > 600) return (baseDesktop + baseMobile) / 2;
    return baseMobile;
  }

  EdgeInsets _responsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double horizontalPadding = 16.0;
    if (width > 1200)
      horizontalPadding = (width - 1100) / 2;
    else if (width > 768) horizontalPadding = 32.0;
    return EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 0);
  }

  Widget _buildSectionPadding(BuildContext context, {required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _responsivePadding(context).horizontal,
        vertical: 64,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gray900, gray800],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            _buildHeroSection(context),
            _buildAboutSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeroSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Container(
        height: screenHeight * 0.5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, st) => Container(color: gray800),
            ),
            Container(color: Colors.black.withOpacity(0.5)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sobre o Teatro Comunitário\nBela Vista",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _responsiveFontSize(context, baseDesktop: 48, baseMobile: 32),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        "Conheça nossa história, missão e valores.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _responsiveFontSize(context, baseDesktop: 22, baseMobile: 16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAboutSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: _buildSectionPadding(
        context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nossa História",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "O Teatro Comunitário Bela Vista nasceu do desejo de levar arte, cultura e experiências ao vivo para toda a comunidade. Desde 2020, promovemos espetáculos semanais, oficinas e eventos que aproximam pessoas e celebram a diversidade cultural do nosso bairro.",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            Text(
              "Missão",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Promover o acesso à cultura, incentivar novos talentos e fortalecer os laços comunitários por meio do teatro e das artes.",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            Text(
              "Valores",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Inclusão, diversidade, respeito, criatividade e compromisso social.",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildFooter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        padding: EdgeInsets.symmetric(
          horizontal: _responsivePadding(context).horizontal,
          vertical: 32,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          bool isSmall = constraints.maxWidth < 768;
          return Flex(
            direction: isSmall ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: isSmall ? 16.0 : 0),
                child: Text(
                  "© 2025 Teatro Comunitário Bela Vista. Todos os direitos reservados.",
                  style: TextStyle(color: gray400),
                ),
              ),
              Wrap(
                spacing: 24,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _footerLink("Home", () {
                    Navigator.of(context).pop();
                  }),
                  // _footerLink("Contato", () {}),
                  // _footerLink("Política de Privacidade", () {}),
                  // _footerLink("Termos de Serviço", () {}),
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _footerLink(String text, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: gray400,
          decoration: TextDecoration.underline,
          decorationColor: gray400.withOpacity(0),
        ),
      ),
    );
  }
}
