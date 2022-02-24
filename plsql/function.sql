/* Cree una función que reciba como parámetro el nombre del territorio y 
retorne el mismo acompañado del nombre del producto más vendido */

CREATE OR REPLACE FUNCTION bestsellerbyterritory(INOUT territoryname VARCHAR, OUT productname VARCHAR)
LANGUAGE plpgsql
AS $$
	DECLARE
		t_id INTEGER;
		p_id INTEGER;
	BEGIN
		-- Getting territory id
		SELECT
			territoryid
		INTO t_id
		FROM sales.salesterritory
		WHERE name = territoryname;
		
		-- Getting the product id for the best seller product
		SELECT
			d.productid,
			SUM(d.orderqty) AS total_qtys
		INTO p_id
		FROM sales.salesorderheader h
		INNER JOIN sales.salesorderdetail d
			ON h.salesorderid = d.salesorderid
		WHERE territoryid = t_id
		GROUP BY d.productid
		ORDER BY total_qtys DESC
		LIMIT 1;
		
		-- Getting product name
		SELECT
			name
		INTO productname
		FROM production.product
		WHERE productid = p_id;
	END;
$$;

SELECT bestsellerbyterritory('Northwest');