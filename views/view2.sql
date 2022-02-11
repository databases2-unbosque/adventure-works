/*
 * Obtener la serie de tiempo mensual del total de ventas por región solo para las regiones de Estados Unidos
 */

CREATE MATERIALIZED VIEW monthlysalesbyterritory AS
SELECT
  t.name territory,
  EXTRACT(YEAR FROM s.orderdate) "year",
  EXTRACT(MONTH FROM s.orderdate) "month",
  SUM(s.totaldue) "totalsales"
FROM sales.salesorderheader s
JOIN sales.salesterritory t
  ON s.territoryid = t.territoryid
WHERE
  t.countryregioncode = 'US'
GROUP BY territory, "year", "month"
ORDER BY territory, "year", "month" ASC;