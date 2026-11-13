with cleaned_subcategory as (
select nullif(trim(cd_subcategory), '') as cd_subcategory,
    nullif(trim(initcap(lib_subcategory)),'') as lib_subcategory, 
    nullif(trim(cd_category),'') as cd_category,
    from {{source('bronze', 'SUB_CATEGORY')}}
) select*, row_number() over (partition by lib_subcategory order by cd_subcategory) as rn
  from cleaned_subcategory