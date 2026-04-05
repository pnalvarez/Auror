/// Revision hub (today's pending revisions).
const revisionHubTitle = 'Revisões de hoje';

String revisionHubPendingBadge(int count) => '$count pendentes';

String revisionHubEstimatedTime(int totalMinutes) =>
    'Tempo estimado: $totalMinutes min';

String revisionHubStartCta(int count) => 'Iniciar revisões ($count)';

const revisionHubLoadError =
    'Não foi possível carregar suas revisões. Tente de novo.';
