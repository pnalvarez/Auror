-- New auth users get a profile (and optional public.users row) with plan `standard`.
-- Requires a row `id = 'standard'` in `public.subscription_plans` (your FK target).
--
-- If you already have `public.handle_new_user`, merge this logic into that function
-- instead of creating a second trigger on `auth.users`.

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  -- Adjust column names to match your `public.profiles` table.
  -- Common Auror-style columns (see ProfileData): user_id, subscription_id, counters.
  insert into public.profiles (
    user_id,
    subscription_id,
    followed_days,
    learned_cards,
    revisions_done
  )
  values (
    new.id,
    'standard',
    0,
    0,
    0
  );

  -- If you maintain a separate `public.users` table, uncomment and match your schema:
  -- insert into public.users (id, subscription_id)
  -- values (new.id, 'standard')
  -- on conflict (id) do nothing;

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
  after insert on auth.users
  for each row
  execute procedure public.handle_new_user();
