import 'package:auror/layers/domain/models/revision_domain.dart';

// HTTPS samples that return 200 and work with AVPlayer / ExoPlayer in dev.
// (The old gtv-videos-bucket/sample/* URLs often return 403 and never load.)
const _vBee =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
const _vButterfly =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
const _vExoBunnySmall =
    'https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4';
const _vExoAndroidScreens =
    'https://storage.googleapis.com/exoplayer-test-media-1/mp4/android-screens-10s.mp4';
const _vExoSample =
    'https://storage.googleapis.com/exoplayer-test-media-1/mp4/sample.mp4';
const _vVideoPlayerExampleButterfly =
    'https://raw.githubusercontent.com/flutter/packages/main/packages/video_player/video_player/example/assets/Butterfly-209.mp4';

/// Mock pending revisions: emotional intelligence, investments, intuition, and more.
const List<RevisionDomain> kMockRevisionDomains = [
  RevisionDomain(
    id: 'rev-ei-01',
    question:
        'Por que a inteligência emocional importa mais que o QI em liderança?',
    videoUrl: _vBee,
    category: 'Inteligência emocional',
    minutes: 5,
    correctAnswer:
        'Permite regular emoções, empatizar com a equipe e decidir sob pressão sem sabotar relacionamentos nem resultados.',
    cardId: 'card-ei-01',
  ),
  RevisionDomain(
    id: 'rev-inv-01',
    question: 'O que diferencia investir de especular no curto prazo?',
    videoUrl: _vButterfly,
    category: 'Investimentos',
    minutes: 6,
    correctAnswer:
        'Investir alinha horizonte, diversificação e perfil de risco; especular foca em timing e ganhos rápidos, com mais volatilidade emocional e de carteira.',
    cardId: 'card-inv-01',
  ),
  RevisionDomain(
    id: 'rev-int-01',
    question: 'Quando confiar na intuição em decisões financeiras?',
    videoUrl: _vExoBunnySmall,
    category: 'Intuição',
    minutes: 4,
    correctAnswer:
        'Quando há expertise acumulada (padrões reconhecíveis); combine com dados e revise se o contexto for novo ou de alto risco.',
    cardId: 'card-int-01',
  ),
  RevisionDomain(
    id: 'rev-com-01',
    question: 'Como feedback honesto fortalece times remotos?',
    videoUrl: _vExoAndroidScreens,
    category: 'Comunicação',
    minutes: 5,
    correctAnswer:
        'Usar observação específica, impacto no trabalho e próximos passos — sem julgar a pessoa — aumenta confiança e clareza.',
    cardId: 'card-com-01',
  ),
  RevisionDomain(
    id: 'rev-fin-01',
    question: 'Qual o papel da reserva de emergência antes de investir?',
    videoUrl: _vExoSample,
    category: 'Finanças pessoais',
    minutes: 3,
    correctAnswer:
        'Evita vender ativos em queda ou usar crédito caro quando surgem imprevistos, preservando disciplina e prazo dos investimentos.',
    cardId: 'card-fin-01',
  ),
  RevisionDomain(
    id: 'rev-mind-01',
    question: 'Como mindfulness ajuda na regulação emocional no trabalho?',
    videoUrl: _vVideoPlayerExampleButterfly,
    category: 'Bem-estar',
    minutes: 4,
    correctAnswer:
        'Treina atenção plena ao momento presente, reduzindo reações automáticas e melhorando foco antes de respostas difíceis.',
    cardId: 'card-mind-01',
  ),
];
