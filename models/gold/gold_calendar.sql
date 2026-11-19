{{config( alias = 'dim_calendar')}}
with select_min_max as 
    (
        select min(id_dim_calendar) as min_dt, max(id_dim_calendar) as max_dt
        from {{ref('fact_sale')}}
    )
    select c.id_dim_calendar , c.dt_calendar, c.nb_jour, c.lb_jour, c.nb_mois, c.lb_mois, c.nb_semestre, c.lb_semestre, c.nb_trimestre, c.lb_trimestre 
    from {{ref('dim_calendar')}} c
         INNER JOIN select_min_max min_max
          on c.id_dim_calendar BETWEEN min_dt and max_dt