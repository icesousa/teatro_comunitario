// lib/services/show_service.dart

import 'dart:async';
import 'package:faculdadeextensao/modules/home/model/show.dart';

/// Simulates a backend service that returns a list of upcoming shows.
/// In a real app, you’d fetch this list via HTTP (e.g., using `http` or `dio`).
class ShowService {
  /// Simulate network delay and return a fixed list of shows.
  Future<List<Show>> fetchUpcomingShows() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Show(
        id: '1',
        title: 'Noite do Stand-Up: Rindo à Vontade',
        date: DateTime.now().add(const Duration(days: 7)),
        description:
            'Humoristas locais em apresentações divertidas e inéditas.',
        imageUrl: 'assets/images/1.jpg'
      ), // Imagem: Microfone de palco, fundo escuro, luzes em destaque, ambiente humorístico.

      Show(
        id: '2',
        title: 'Tributo a Tim Maia',
        date: DateTime.now().add(const Duration(days: 14)),
        description:
            'Uma noite musical com sucessos inesquecíveis de Tim Maia interpretados por artistas convidados.',
        imageUrl: 'assets/images/2.jpg'
      ), // Imagem: Silhueta do Tim Maia ou cantor segurando microfone com iluminação retrô, fundo colorido.

      Show(
        id: '3',
        title: 'Espetáculo Infantil: As Aventuras da Turma da Magia',
        date: DateTime.now().add(const Duration(days: 21)),
        description:
            'História lúdica e divertida ideal para crianças e famílias.',
        imageUrl: 'assets/images/3.jpg'
      ), // Imagem: Ilustração colorida com personagens mágicos, castelos, estrelas e cenário fantasioso.

      Show(
        id: '4',
        title: 'Noite de Teatro: O Santo e a Porca',
        date: DateTime.now().add(const Duration(days: 28)),
        description: 'Montagem divertida do clássico de Ariano Suassuna.',
        imageUrl: 'assets/images/4.jpg'
      ), // Imagem: Cena teatral tradicional brasileira, figurinos típicos nordestinos, com toque humorístico.

      Show(
        id: '5',
        title: 'Encontro de Corais Comunitários',
        date: DateTime.now().add(const Duration(days: 35)),
        description:
            'Apresentações emocionantes de grupos vocais da comunidade.',
        imageUrl: 'assets/images/5.jpg'
      ), // Imagem: Coro de pessoas cantando em grupo, sorrindo, com partituras, ambiente acolhedor.

      Show(
        id: '6',
        title: 'Sarau Poético - Vozes do Bairro',
        date: DateTime.now().add(const Duration(days: 42)),
        description:
            'Encontro cultural com leituras poéticas, música e intervenções artísticas.',
        imageUrl: 'assets/images/6.jpg'
      ), // Imagem: Ambiente intimista, livros, velas acesas e artistas recitando poemas.

      Show(
        id: '7',
        title: 'Festival de Curtas-Metragens Locais',
        date: DateTime.now().add(const Duration(days: 49)),
        description:
            'Exibição de curtas produzidos por jovens cineastas do bairro.',
        imageUrl: 'assets/images/7.jpg'
      ), // Imagem: Projetor de cinema em ação, rolo de filme ou plateia assistindo em auditório pequeno.

      Show(
        id: '8',
        title: 'Show Acústico - Tributo ao Rock Nacional',
        date: DateTime.now().add(const Duration(days: 56)),
        description:
            'Grandes sucessos do rock brasileiro apresentados em formato acústico.',
        imageUrl: 'assets/images/8.jpg'
      ), // Imagem: Violão acústico, ambiente intimista, iluminação quente, referências ao rock nacional.

      // Novas adições:
      Show(
        id: '9',
        title: 'Dança de Salão: Ritmos Brasileiros',
        date: DateTime.now().add(const Duration(days: 63)),
        description:
            'Apresentação de dança de salão, destacando samba, forró e bolero.',
        imageUrl: 'assets/images/9.jpg'
      ), // Imagem: Casal dançando em salão, roupas típicas brasileiras, fundo festivo e colorido.

      Show(
        id: '10',
        title: 'Noite Sertaneja Raiz',
        date: DateTime.now().add(const Duration(days: 70)),
        description:
            'Clássicos sertanejos interpretados por duplas locais com moda de viola.',
        imageUrl: 'assets/images/10.jpg'
      ), // Imagem: Viola caipira, chapéus típicos, ambiente rústico com referência ao sertanejo tradicional.

      Show(
        id: '11',
        title: 'Espetáculo Circense Comunitário',
        date: DateTime.now().add(const Duration(days: 77)),
        description:
            'Apresentação de artistas circenses locais, incluindo malabarismo, palhaços e acrobacias.',
        imageUrl: 'assets/images/11.jpg'
      ), // Imagem: Artistas circenses em ação, tendas coloridas, malabares e crianças na plateia.

      Show(
        id: '12',
        title: 'Concerto de Violão Clássico',
        date: DateTime.now().add(const Duration(days: 84)),
        description:
            'Recital com músicas clássicas brasileiras e internacionais interpretadas por violonistas locais.',
        imageUrl: 'assets/images/12.jpg'
      ), // Imagem: Close-up das mãos tocando violão clássico, ambiente elegante e sóbrio.
      // Histórico de eventos (maio):
  Show(
    id: '13',
    title: 'Noite de Samba e Pagode',
    date: DateTime(2025, 5, 6),
    description: 'Apresentação animada com grupos locais interpretando sucessos do samba e pagode.',
    imageUrl: 'assets/images/13.jpg'
  ), // Imagem: Pandeiro, cavaquinho e roda de samba em ambiente descontraído.

  Show(
    id: '14',
    title: 'Peça Teatral: Romeu e Julieta - Versão Brasileira',
    date: DateTime(2025, 5, 13),
    description: 'Uma adaptação divertida e moderna do clássico shakespeariano.',
    imageUrl: 'assets/images/14.jpg'
  ), // Imagem: Dois jovens atores caracterizados como Romeu e Julieta, cenário simples, mas expressivo.

  Show(
    id: '15',
    title: 'Recital de Violão Jovens Talentos',
    date: DateTime(2025, 5, 20),
    description: 'Concerto com jovens violonistas da região interpretando clássicos internacionais.',
    imageUrl: 'assets/images/15.jpg'
  ), // Imagem: Jovem violonista em recital, violão em destaque com iluminação suave e elegante.

  Show(
    id: '16',
    title: 'Mostra de Teatro Amador',
    date: DateTime(2025, 5, 27),
    description: 'Apresentação de peças curtas encenadas por companhias teatrais amadoras locais.',
    imageUrl: 'assets/images/16.jpg'
  ), // Imagem: Grupo de teatro amador em cena expressiva, figurino simples e cenário improvisado.
    
    ];
  }

  /// Simulates submitting interest (e-mail + name) for a given show ID.
  Future<bool> submitInterest({
    required String showId,
    required String name,
    required String email,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, you’d POST to your backend here.
    print('Interest submitted for show $showId: $name <$email>');
    return true; // Return `true` if the server responded with success.
  }
}
