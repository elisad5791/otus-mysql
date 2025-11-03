-- Базовый B-tree индекс
CREATE INDEX idx_products_supplier_id ON products(supplier_id);

EXPLAIN ANALYZE
SELECT id, title, description, supplier_id, producer_id
FROM products
WHERE supplier_id = 1;

--Bitmap Heap Scan on products  (cost=5.87..249.11 rows=205 width=115) (actual time=1.370..1.530 rows=205 loops=1)"
--  Recheck Cond: (supplier_id = 1)"
--  Heap Blocks: exact=134"
--  ->  Bitmap Index Scan on idx_products_supplier_id  (cost=0.00..5.82 rows=205 width=0) (actual time=1.346..1.346 rows=205 loops=1)"
--        Index Cond: (supplier_id = 1)"
--Planning Time: 0.480 ms"
--Execution Time: 1.594 ms"

-- Полнотекстовый поиск
CREATE INDEX idx_products_description_gin ON products USING gin(to_tsvector('english', description));

EXPLAIN ANALYZE
SELECT id, title 
FROM products 
WHERE to_tsvector('english', description) @@ to_tsquery('english', 'warranty & support');

--Bitmap Heap Scan on products  (cost=24.00..28.26 rows=1 width=16) (actual time=0.913..1.904 rows=3333 loops=1)"
--  Recheck Cond: (to_tsvector('english'::regconfig, description) @@ '''warranti'' & ''support'''::tsquery)"
--  Heap Blocks: exact=239"
--  ->  Bitmap Index Scan on idx_products_description_gin  (cost=0.00..24.00 rows=1 width=0) (actual time=0.855..0.855 rows=3333 loops=1)"
--        Index Cond: (to_tsvector('english'::regconfig, description) @@ '''warranti'' & ''support'''::tsquery)"
--Planning Time: 0.160 ms"
--Execution Time: 2.078 ms"

-- Частичный индекс с приведением типа
CREATE INDEX idx_products_available_simple ON products(((characteristics->>'is_available')::boolean))
    WHERE (characteristics->>'is_available')::boolean = true;

EXPLAIN ANALYZE
SELECT p.title, p.producer_id, pr.title as producer_name
FROM products p
JOIN producers pr ON p.producer_id = pr.id
WHERE (p.characteristics->>'is_available')::boolean = true
ORDER BY p.title;

--Sort  (cost=702.16..714.66 rows=5000 width=27) (actual time=45.224..45.482 rows=9000 loops=1)"
--  Sort Key: p.title"
--  Sort Method: quicksort  Memory: 1018kB"
--  ->  Hash Join  (cost=54.78..394.97 rows=5000 width=27) (actual time=0.256..3.319 rows=9000 loops=1)"
--        Hash Cond: (p.producer_id = pr.id)"
--        ->  Bitmap Heap Scan on products p  (cost=50.53..377.03 rows=5000 width=16) (actual time=0.222..1.447 rows=9000 loops=1)"
--              Recheck Cond: ((characteristics ->> 'is_available'::text))::boolean"
--              Heap Blocks: exact=239"
--              ->  Bitmap Index Scan on idx_products_available_simple  (cost=0.00..49.28 rows=5000 width=0) (actual time=0.197..0.198 rows=9000 loops=1)"
--        ->  Hash  (cost=3.00..3.00 rows=100 width=15) (actual time=0.029..0.031 rows=100 loops=1)"
--              Buckets: 1024  Batches: 1  Memory Usage: 13kB"
--              ->  Seq Scan on producers pr  (cost=0.00..3.00 rows=100 width=15) (actual time=0.007..0.016 rows=100 loops=1)"
--Planning Time: 0.250 ms"
--Execution Time: 45.902 ms"

-- Составной индекс
CREATE INDEX idx_products_search_sort ON products(producer_id, supplier_id, (characteristics->>'color'), title);

EXPLAIN ANALYZE
SELECT id, title, characteristics->>'color' as color
FROM products 
WHERE producer_id = 25
  AND supplier_id = 10
  AND characteristics->>'color' = 'Black'
ORDER BY title;

--Index Scan using idx_products_search_sort on products  (cost=0.29..8.31 rows=1 width=48) (actual time=0.044..0.044 rows=0 loops=1)"
--  Index Cond: ((producer_id = 25) AND (supplier_id = 10) AND ((characteristics ->> 'color'::text) = 'Black'::text))"
--Planning Time: 0.209 ms"
--Execution Time: 0.065 ms"