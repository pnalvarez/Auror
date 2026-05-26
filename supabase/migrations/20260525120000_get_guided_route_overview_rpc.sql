-- Aggregated guided route overview for the authenticated user (one RPC call from the app).

create or replace function public.get_guided_route_overview(p_guided_route_id uuid)
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

  select jsonb_build_object(
    'id', gr.id,
    'name', gr.name,
    'modules', coalesce((
      select jsonb_agg(
        jsonb_build_object(
          'id', m.id,
          'name', m.name,
          'submodules', (
            select coalesce(jsonb_agg(
              jsonb_build_object(
                'id', s.id,
                'name', s.name,
                'has_finished', coalesce(usp.has_finished, false),
                'is_available', coalesce(usp.is_available, false)
              )
              order by s."order"
            ), '[]'::jsonb)
            from public.submodules s
            left join public.user_submodule_progress usp
              on usp.submodule_id = s.id and usp.user_id = v_user_id
            where s.module_id = m.id
          )
        )
        order by m."order"
      )
      from public.modules m
      where m.route_id = gr.id
    ), '[]'::jsonb)
  )
  into v_result
  from public.guided_routes gr
  where gr.id = p_guided_route_id;

  if v_result is null then
    raise exception 'guided_route_not_found';
  end if;

  return v_result;
end;
$$;

grant execute on function public.get_guided_route_overview(uuid) to authenticated;
