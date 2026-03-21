# Динамика обработанной площади по операциям

```sql operations_list
SELECT DISTINCT column05 AS operation
FROM dumpDB.dumpDB
WHERE column05 IS NOT NULL AND TRY_CAST(column10 AS DOUBLE) > 0
ORDER BY operation
```

<Dropdown data={operations_list} name=selected_operation value=operation>
    <DropdownOption value="%" valueLabel="Все операции"/>
</Dropdown>

```sql daily_ha_by_operation
SELECT
    column00 AS date,
    SUM(TRY_CAST(column10 AS DOUBLE)) AS ha
FROM dumpDB.dumpDB
WHERE TRY_CAST(column10 AS DOUBLE) > 0
  AND ('${inputs.selected_operation.value}' = '%'
       OR column05 = '${inputs.selected_operation.value}')
GROUP BY date
ORDER BY date
```

<AreaChart 
    data={daily_ha_by_operation}
    x=date
    y=ha
    title="Обработанные гектары по дням: {inputs.selected_operation.label}"
/>

# Динамика по операциям

```sql operations_list
SELECT DISTINCT column05 AS operation
FROM dumpDB.dumpDB
WHERE column05 IS NOT NULL AND TRY_CAST(column10 AS DOUBLE) > 0
ORDER BY operation
```

<Dropdown data={operations_list} name=selected_operation value=operation> <DropdownOption value="%" valueLabel="Все операции"/> </Dropdown>

```sql daily_ha
SELECT
    column00 AS date,
    SUM(TRY_CAST(column10 AS DOUBLE)) AS ha
FROM dumpDB.dumpDB
WHERE TRY_CAST(column10 AS DOUBLE) > 0
    AND ('${inputs.selected_operation.value}' = '%'
       OR column05 = '${inputs.selected_operation.value}')
GROUP BY date
ORDER BY date
```

<AreaChart data={daily_ha} x=date y=ha title="Га по дням: {inputs.selected_operation.label}"/> ```

## Вспашка

```sql daily_ha_plowing
SELECT
    column00 AS date,
    SUM(TRY_CAST(column10 AS DOUBLE)) AS ha
FROM dumpDB.dumpDB
WHERE TRY_CAST(column10 AS DOUBLE) > 0
  AND column05 = 'боронование'
GROUP BY date
ORDER BY date
```

<AreaChart data={daily_ha_plowing} x=date y=ha title="Вспашка" />

```python
names = ["Alice", "Bob", "Charlie"]
for name in names:
    print("Hello, " + name)
```
