import 'package:auror/layers/domain/models/idea_domain.dart';
import 'package:auror/layers/domain/models/knowledge_card_domain.dart';
import 'package:injectable/injectable.dart';

const _vBee =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
const _vButterfly =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
const _vExoBunnySmall =
    'https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4';

abstract class IGetDailyIdea {
  Future<IdeaDomain> call();
}

@Injectable(as: IGetDailyIdea)
class GetDailyIdea implements IGetDailyIdea {
  @override
  Future<IdeaDomain> call() async {
    // Simulate fetching daily idea with a delay.
    await Future.delayed(const Duration(seconds: 1));
    return const IdeaDomain(
      completedCards: [
        KnowledgeCardDomain(
          id: '1',
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
      ],
      incompleteCards: [
        KnowledgeCardDomain(
          id: '2',

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
          id: '3',

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
      ],
      totalTime: 7,
    );
  }
}
