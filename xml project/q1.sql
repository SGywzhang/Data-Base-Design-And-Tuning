copy(
SELECT xmlelement(
 name warehouses,
 xmlagg(
  xmlelement(name warehouse,
       xmlforest(
        warehouse.w_id AS id,
        warehouse.w_name AS name,
        xmlforest(
         warehouse.w_street AS street,
         warehouse.w_city AS city,
         warehouse.w_country AS country
        ) AS address,
        (SELECT xmlagg(
         xmlelement(name item, 
          xmlforest(
           item.i_id AS id,
           item.i_im_id AS im_id,
           item.i_name AS name,
           item.i_price AS price
          )
         ) ORDER BY item.i_id
        )
        FROM stock, item
        WHERE stock.w_id = warehouse.w_id
        AND item.i_id = stock.i_id) AS items
       )
      ) ORDER BY warehouse.w_id
 )
)
FROM warehouse
) to '/home/cs4221/Desktop/q1.xml'
