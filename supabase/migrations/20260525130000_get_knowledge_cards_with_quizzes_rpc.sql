-- Cards for a submodule with nested quiz (one RPC from the app).

create or replace function public.get_knowledge_cards_with_quizzes(
  p_submodule_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := auth.uid();
  v_result jsonb;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select coalesce(
    jsonb_agg(
      jsonb_build_object(
        'id', kc.id,
        'title', kc.title,
        'description', kc.description,
        'curiosity', kc.curiosity,
        'common_error', kc.common_error,
        'quiz', case
          when q.id is null then null
          else jsonb_build_object(
            'id', q.id,
            'question', q.question,
            'option_1', q.option_1,
            'option_2', q.option_2,
            'option_3', q.option_3,
            'option_4', q.option_4,
            'correct_answer', q.correct_answer
          )
        end
      )
      order by kc.created_at, kc.title
    ),
    '[]'::jsonb
  )
  into v_result
  from public.knowledge_cards kc
  left join public.quizzes q on q.knowledge_card_id = kc.id
  where kc.submodule_id = p_submodule_id;

  return v_result;
end;
$$;

grant execute on function public.get_knowledge_cards_with_quizzes(uuid) to authenticated;
