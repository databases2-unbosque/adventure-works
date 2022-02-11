/*
 * Obtener una lista con los campos categoría, subcategoría, nombre y número de cada producto de la base de datos
 */

CREATE VIEW producthierarchy AS
SELECT
	c.name category,
	sc.name subcategory,
	p.name product,
	p.productnumber number
FROM production.product p
JOIN production.productsubcategory sc
	ON p.productsubcategoryid = sc.productsubcategoryid
JOIN production.productcategory c
	ON sc.productcategoryid = c.productcategoryid
WHERE
	p.productsubcategoryid IS NOT NULL
ORDER BY category, subcategory ASC;