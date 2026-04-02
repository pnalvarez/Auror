import 'package:auror/layers/domain/models/guided_route_intro_domain.dart';
import 'package:injectable/injectable.dart';

abstract class IGetGuidedRouteIntros {
  Future<List<GuidedRouteIntroDomain>> call();
}

@Injectable(as: IGetGuidedRouteIntros)
class GetGuidedRouteIntros implements IGetGuidedRouteIntros {
  @override
  Future<List<GuidedRouteIntroDomain>> call() async {
    return const [
      GuidedRouteIntroDomain(
        topic: 'Desenvolvimento Pessoal',
        isPremiumMode: true,
        title: 'Autoliderança',
        description:
            'Desenvolva a capacidade de gerenciar a si mesmo, suas emoções '
            'e seu tempo para alcançar metas pessoais e profissionais.',
      ),
      GuidedRouteIntroDomain(
        topic: 'Produtividade',
        isPremiumMode: false,
        title: 'Foco profundo',
        description:
            'Técnicas para reduzir distrações e manter concentração em tarefas '
            'que importam.',
      ),
      GuidedRouteIntroDomain(
        topic: 'Comunicação',
        isPremiumMode: true,
        title: 'Feedback construtivo',
        description:
            'Aprenda a dar e receber feedback de forma clara, respeitosa e '
            'orientada a resultados.',
      ),
    ];
  }
}
