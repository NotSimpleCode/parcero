-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.category (
  id_category bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  name_category character varying NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT category_pkey PRIMARY KEY (id_category)
);
CREATE TABLE public.expenses (
  id_expense uuid NOT NULL DEFAULT gen_random_uuid(),
  amount_expense numeric NOT NULL,
  date_expense date NOT NULL DEFAULT now(),
  name_expense character varying DEFAULT ''::character varying,
  id_user bigint,
  id_category bigint DEFAULT '1'::bigint,
  id_payment_method bigint DEFAULT '4'::bigint,
  status_expense character varying DEFAULT 'P'::character varying,
  CONSTRAINT expenses_pkey PRIMARY KEY (id_expense),
  CONSTRAINT EXPENSES_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id_user),
  CONSTRAINT EXPENSES_id_category_fkey FOREIGN KEY (id_category) REFERENCES public.category(id_category),
  CONSTRAINT EXPENSES_id_payment_method_fkey FOREIGN KEY (id_payment_method) REFERENCES public.payment_methods(id_payment)
);
CREATE TABLE public.goals (
  id_goal bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  start_date_goal date NOT NULL DEFAULT now(),
  context_goal character varying NOT NULL,
  id_user bigint,
  status_goal character varying DEFAULT 'P'::character varying,
  value_goal numeric,
  frequency_goal numeric DEFAULT '1'::numeric,
  end_date_goal date,
  CONSTRAINT goals_pkey PRIMARY KEY (id_goal),
  CONSTRAINT GOALS_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id_user)
);
CREATE TABLE public.groups (
  id_user bigint NOT NULL UNIQUE,
  created_at date DEFAULT now(),
  id_couple bigint NOT NULL UNIQUE,
  total_saved numeric,
  total_income numeric,
  total_expense numeric,
  status_group character varying DEFAULT 'A'::character varying,
  CONSTRAINT groups_pkey PRIMARY KEY (id_user, id_couple),
  CONSTRAINT groups_id_couple_fkey FOREIGN KEY (id_couple) REFERENCES public.users(id_user),
  CONSTRAINT groups_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id_user)
);
CREATE TABLE public.groups_goals (
  id_user bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_couple bigint NOT NULL,
  goal_group_context character varying NOT NULL,
  status_group_goal character varying DEFAULT 'A'::character varying,
  date_group_goal date DEFAULT now(),
  id_group_goal bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  CONSTRAINT groups_goals_pkey PRIMARY KEY (id_group_goal),
  CONSTRAINT groups_goals_id_user_id_couple_fkey FOREIGN KEY (id_couple) REFERENCES public.groups(id_couple),
  CONSTRAINT groups_goals_id_user_id_couple_fkey FOREIGN KEY (id_user) REFERENCES public.groups(id_couple),
  CONSTRAINT groups_goals_id_user_id_couple_fkey FOREIGN KEY (id_couple) REFERENCES public.groups(id_user),
  CONSTRAINT groups_goals_id_user_id_couple_fkey FOREIGN KEY (id_user) REFERENCES public.groups(id_user)
);
CREATE TABLE public.incomes (
  id_income bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  date_income date NOT NULL DEFAULT now(),
  amount_income numeric NOT NULL,
  name_income character varying DEFAULT 'pago default'::character varying,
  id_user bigint NOT NULL,
  status_income character varying DEFAULT 'P'::character varying,
  CONSTRAINT incomes_pkey PRIMARY KEY (id_income),
  CONSTRAINT INCOMES_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id_user)
);
CREATE TABLE public.n8n_chat_histories (
  id integer NOT NULL DEFAULT nextval('n8n_chat_histories_id_seq'::regclass),
  session_id character varying NOT NULL,
  message jsonb NOT NULL,
  CONSTRAINT n8n_chat_histories_pkey PRIMARY KEY (id)
);
CREATE TABLE public.payment_methods (
  id_payment bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  name_payment character varying NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT payment_methods_pkey PRIMARY KEY (id_payment)
);
CREATE TABLE public.reminders (
  id_reminder bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  name_reminder character varying NOT NULL,
  CONSTRAINT reminders_pkey PRIMARY KEY (id_reminder)
);
CREATE TABLE public.users (
  id_user bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  phone_number character varying NOT NULL UNIQUE,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  total_expense_user numeric DEFAULT '0'::numeric,
  total_income_user numeric DEFAULT '0'::numeric,
  total_saved_user numeric DEFAULT '0'::numeric,
  CONSTRAINT users_pkey PRIMARY KEY (id_user)
);
CREATE TABLE public.users_reminders (
  id_user bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  id_reminder bigint NOT NULL,
  frequency_reminder numeric DEFAULT '1'::numeric,
  date_user_reminder timestamp without time zone DEFAULT now(),
  status_user_reminder character varying DEFAULT 'A'::character varying,
  CONSTRAINT users_reminders_pkey PRIMARY KEY (id_user, id_reminder),
  CONSTRAINT USERS_REMINDERS_id_reminder_fkey FOREIGN KEY (id_reminder) REFERENCES public.reminders(id_reminder),
  CONSTRAINT USERS_REMINDERS_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.users(id_user)
);