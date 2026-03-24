-- Primary Test
select OrderID
From {{ ref('orders_fact') }}
Where Revenue < 0