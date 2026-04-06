import 'package:auror/layers/domain/models/knowledge_card_domain.dart';

// HTTPS samples that work with AVPlayer / ExoPlayer in dev (aligned with revision mocks).
const _vBee =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
const _vButterfly =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
const _vExoBunnySmall =
    'https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4';

/// Mock knowledge cards for development and previews.
const List<KnowledgeCardDomain> kMockKnowledgeCardDomains = [
  KnowledgeCardDomain(
    category: 'Inteligência emocional',
    title: 'Regular emoções sob pressão',
    quote:
        'A liderança não é ausência de emoção, é escolher a resposta certa.',
    description:
        'Reconhecer o gatilho, nomear o sentimento e decidir com intenção '
        'reduz reações impulsivas e fortalece a confiança da equipe.',
    videoUrl: _vBee,
    practicalExample:
        'Antes de responder um e-mail irritante, pause 60 segundos, respire '
        'e reescreva focando no problema, não na pessoa.',
    commonError:
        'Confundir transparência emocional com desabafo descontrolado em '
        'reuniões.',
  ),
  KnowledgeCardDomain(
    category: 'Investimentos',
    title: 'Horizonte e disciplina',
    quote: 'Tempo no mercado costuma vencer timing de mercado.',
    description:
        'Definir objetivo, prazo e tolerância a perdas alinha expectativas e '
        'evita decisões guiadas só por notícias do dia.',
    videoUrl: _vButterfly,
    practicalExample:
        'Automatizar aportes mensais na mesma data reduz o viés de tentar '
        '"acertar" o melhor dia.',
    commonError:
        'Vender tudo em queda por pânico ou comprar por FOMO sem encaixar no '
        'plano.',
  ),
  KnowledgeCardDomain(
    category: 'Comunicação',
    title: 'Feedback observável',
    quote: 'Fale do comportamento, não do caráter.',
    description:
        'Descrever o que foi visto, o impacto no trabalho e uma sugestão '
        'clara torna o feedback acionável e menos defensivo.',
    videoUrl: _vExoBunnySmall,
    practicalExample:
        'Em vez de "você é desorganizado", use "os três últimos prazos '
        'sliparam; como podemos ajustar prioridades?".',
    commonError:
        'Dar feedback genérico ("precisa melhorar") sem exemplo nem próximo '
        'passo.',
  ),
];
