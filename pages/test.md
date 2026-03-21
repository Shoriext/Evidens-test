```sql test
SELECT * FROM dumpDB.dumpDB LIMIT 10
```

```sql monthly_ha
SELECT
    DATE_TRUNC('month', TRY_CAST(column00 AS DATE)) AS month,
    SUM(TRY_CAST(column10 AS DOUBLE)) AS total_hectares
FROM dumpDB.dumpDB
WHERE TRY_CAST(column10 AS DOUBLE) IS NOT NULL
  AND TRY_CAST(column10 AS DOUBLE) > 0
  AND TRY_CAST(column00 AS DATE) IS NOT NULL
GROUP BY month
ORDER BY month
```

<BarChart 
    data={monthly_ha}
    x=month
    y=total_hectares
    title="Обработанная площадь по месяцам, га"
/>

```sql kpi_overall
SELECT
    SUM(TRY_CAST(column10 AS DOUBLE)) AS total_ha,
    SUM(TRY_CAST(column11 AS DOUBLE)) AS total_tons,
    SUM(TRY_CAST(column15 AS DOUBLE)) AS total_fuel_liters,
    AVG(TRY_CAST(column19 AS DOUBLE)) AS avg_fuel_per_ha,
    COUNT(DISTINCT column06) AS operators_count
FROM dumpDB.dumpDB
WHERE TRY_CAST(column10 AS DOUBLE) > 0
```

<Grid cols=4>
    <BigValue data={kpi_overall} value=total_ha title="Всего га"/>
    <BigValue data={kpi_overall} value=total_tons title="Всего тонн"/>
    <BigValue data={kpi_overall} value=total_fuel_liters title="Топливо, л"/>
    <BigValue data={kpi_overall} value=avg_fuel_per_ha title="Ср. расход, л/га"/>
</Grid>

```sql harvest_by_culture
SELECT
    column01 AS culture,
    SUM(TRY_CAST(column11 AS DOUBLE)) AS tons
FROM dumpDB.dumpDB
WHERE TRY_CAST(column11 AS DOUBLE) > 0
GROUP BY culture
ORDER BY tons DESC
```

<BarChart data={harvest_by_culture} x=culture y=tons title="Сбор по культурам, т"/>

```sql daily_ha_by_operation
SELECT
    column00 AS date,
    column05 AS operation,
    SUM(TRY_CAST(column10 AS DOUBLE)) AS ha
FROM dumpDB.dumpDB
WHERE TRY_CAST(column10 AS DOUBLE) > 0
GROUP BY date, operation
ORDER BY date
```

<AreaChart data={daily_ha_by_operation} x=date y=ha series=operation title="Га по дням и операциям"/>

```sql yield_by_field
SELECT
    column03 AS field,
    column01 AS crop,
    SUM(TRY_CAST(column11 AS DOUBLE)) AS tons,
    SUM(TRY_CAST(column10 AS DOUBLE)) AS ha,
    SUM(TRY_CAST(column11 AS DOUBLE)) / NULLIF(SUM(TRY_CAST(column10 AS DOUBLE)), 0) AS yield_t_per_ha
FROM dumpDB.dumpDB
WHERE TRY_CAST(column11 AS DOUBLE) > 0
  AND TRY_CAST(column10 AS DOUBLE) > 0
GROUP BY field, crop
ORDER BY yield_t_per_ha DESC

```

<DataTable data={yield_by_field}/>
