// lib/views/home_page.dart
import 'package:faculdadeextensao/core/constants.dart';
import 'package:faculdadeextensao/modules/home/model/show.dart';
import 'package:faculdadeextensao/modules/home/notifier/notifier.dart';
import 'package:faculdadeextensao/modules/home/pages/about_page.dart';
import 'package:faculdadeextensao/modules/home/widgets/interest_dialog.dart';
import 'package:faculdadeextensao/modules/home/widgets/show_card.widget.dart';
// Import the new ShowCardWidget
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ShowListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<ShowListViewModel>();
    // Ensure shows are loaded, potentially after layout if dimensions are needed
    // For this design, it's fine to load early.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_viewModel.shows.isEmpty) {
        // Load only if not already loaded
        _viewModel.loadShows();
      }
    });
  }

  // Helper for responsive font size
  double _responsiveFontSize(BuildContext context,
      {double baseDesktop = 60, double baseMobile = 40}) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return baseDesktop; // md breakpoint
    if (width > 600) return (baseDesktop + baseMobile) / 2;
    return baseMobile;
  }

  // Helper for responsive padding/margins
  EdgeInsets _responsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double horizontalPadding = 16.0;
    if (width > 1200)
      horizontalPadding = (width - 1100) / 2; // Max container width
    else if (width > 768) horizontalPadding = 32.0;
    return EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 0);
  }

  Widget _buildSectionPadding({required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _responsivePadding(context)
            .horizontal, // Use responsive horizontal padding
        vertical: 64, // py-16
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // The original code had a min-h-screen bg-gradient-to-b from-gray-900 to-gray-800 text-white
    // This is applied to the body. In Flutter, we'd wrap the Scaffold's body or the content.
    // For simplicity, main.dart sets scaffoldBackgroundColor: gray900.
    // The gradient can be applied to a Container wrapping the SingleChildScrollView.

    return Scaffold(
      // No AppBar to match the design
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gray900, gray800],
          ),
        ),
        child: Consumer<ShowListViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading && vm.shows.isEmpty) {
              // Show loading only on initial load
              return const Center(
                  child: CircularProgressIndicator(color: rose600));
            }
            if (vm.errorMessage != null && vm.shows.isEmpty) {
              return Center(
                  child: Text(vm.errorMessage!, style: bodyTextStyle));
            }
            // Data is ready (or loading in background), build the UI

            // We use a CustomScrollView to easily mix Slivers (for Grid) and regular widgets
            return CustomScrollView(
              slivers: [
                _buildHeroSection(context),
                _buildUpcomingShowsSection(context, vm),
                _buildFooter(context),
              ],
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeroSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: Container(
        height: screenHeight * 0.7, // h-[70vh]
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              heroPlaceholderImageUrl, // Replace with your actual hero image URL
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, st) => Container(color: gray800),
            ),
            Container(color: Colors.black.withOpacity(0.5)), // bg-black/50
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // px-4
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Teatro Comunitário\n Bela Vista",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _responsiveFontSize(context,
                            baseDesktop: 60,
                            baseMobile: 36), // text-4xl md:text-6xl
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16), // mb-4
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 600), // max-w-2xl
                      child: Text(
                        "Experiencias ao vivo para comunidade toda semana",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: _responsiveFontSize(context,
                              baseDesktop: 24,
                              baseMobile: 18), // text-xl md:text-2xl
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32), // mb-8
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverList _buildUpcomingShowsSection(
      BuildContext context, ShowListViewModel vm) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine number of columns for the grid
    int crossAxisCount = 1;
    if (screenWidth >= 1024) {
      // lg
      crossAxisCount = 4;
    } else if (screenWidth >= 768) {
      // md
      crossAxisCount = 2;
    }
    double childAspectRatio = screenWidth < 600
        ? 0.55
        : 0.65; // Adjust for better look on smaller screens

    // Month filter buttons
    final now = DateTime.now();
    final currentMonth = now.month;
    final List<int?> months = [
      null,
      ...List.generate(12 - currentMonth + 1, (i) => currentMonth + i)
    ];
    final monthLabels = ['Todos'] +
        [
          'Jan',
          'Fev',
          'Mar',
          'Abr',
          'Mai',
          'Jun',
          'Jul',
          'Ago',
          'Set',
          'Out',
          'Nov',
          'Dez'
        ].sublist(currentMonth - 1);

    return SliverList(
      delegate: SliverChildListDelegate([
        _buildSectionPadding(
          child: Column(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                bool isSmall = constraints.maxWidth < 768; // md breakpoint
                return Flex(
                  direction: isSmall ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: isSmall
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Próximos Espetáculos",
                            style: headline2Style.copyWith(fontSize: 32)),
                        const SizedBox(height: 8), // mb-2
                        const Text(
                            "Descubra nossa programação de apresentações",
                            style: bodyTextStyle),
                      ],
                    ),
                    SizedBox(height: isSmall ? 16 : 0), // mt-4 md:mt-0
                    const Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 20, color: rose400), // MapPin
                        SizedBox(width: 8), // mr-2
                        Text("224 , Rua Domingos, São Paulo, Bela Vista",
                            style: bodyTextStyle),
                      ],
                    ),
                  ],
                );
              }),
              const SizedBox(height: 24),
              // Month filter buttons
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(months.length, (i) {
                    final selected = vm.selectedMonth == months[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(monthLabels[i]),
                        selected: selected,
                        onSelected: (_) {
                          vm.setSelectedMonth(months[i]);
                        },
                        selectedColor: rose600,
                        backgroundColor: Colors.grey[800],
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.grey[300],
                          fontWeight:
                              selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              if (vm.shows.isEmpty && !vm.isLoading)
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(
                      child: Text('Nenhum espetáculo programado no momento.',
                          style: bodyTextStyle)),
                )
              else if (vm.isLoading && vm.shows.isEmpty)
                const Center(child: CircularProgressIndicator(color: rose600))
              else
                GridView.builder(
                  shrinkWrap:
                      true, // Important for GridView inside SingleChildScrollView/Column
                  physics:
                      const NeverScrollableScrollPhysics(), // GridView handles its own scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24, // gap-6
                    mainAxisSpacing: 24, // gap-6
                    childAspectRatio: childAspectRatio, // Adjust as needed
                  ),
                  itemCount: vm.shows.length,
                  itemBuilder: (context, index) {
                    final show = vm.shows[index];
                    return ShowCardWidget(
                      show: show,
                      onInterestedPressed: () => _openInterestDialog(show),
                    );
                  },
                ),
            ],
          ),
        ),
      ]),
    );
  }

  SliverToBoxAdapter _buildFooter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.black.withOpacity(0.4), // bg-black/40
        padding: EdgeInsets.symmetric(
          horizontal: _responsivePadding(context).horizontal,
          vertical: 32, // py-8
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          bool isSmall = constraints.maxWidth < 768; // md breakpoint
          return Flex(
            direction: isSmall ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment:
                isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(bottom: isSmall ? 16.0 : 0), // mb-4 md:mb-0
                child: const Text(
                    "© 2025 Teatro Comunitário Bela Vista. Todos os direitos reservados.",
                    style: TextStyle(color: gray400)),
              ),
              Wrap(
                // Use Wrap for links to allow them to wrap on smaller screens if needed
                spacing: 24, // gap-6 (horizontal)
                runSpacing: 8, // gap between lines if it wraps
                alignment: WrapAlignment.center,
                children: [
                  _footerLink("Sobre", () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutPage()));
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
            decorationColor: gray400.withOpacity(0)),
        // Simple hover effect might need MouseRegion for web if desired
      ),
    );
  }

  void _openInterestDialog(Show show) {
    // Changed to take Show object
    showDialog(
      context: context,
      builder: (dialogContext) {
        // Use a different context name
        return InterestDialog(
          showTitle: show.title, // Pass title
          showDate: show.date.toString(), // Pass date
          onConfirm: (name, email) async {
            // This part of your logic remains the same
            final success = await _viewModel.submitInterest(
              showId: show.id,
              name: name,
              email: email,
            );

            // Show feedback (SnackBar) after submission
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  success
                      ? 'Thank you! We have received your interest.'
                      : 'Submission failed. Please try again.',
                ),
                backgroundColor: success ? Colors.green : Colors.red,
              ),
            );
            // Navigator.of(dialogContext).pop(); // Dialog closes itself on success now
          },
        );
      },
    );
  }
}
