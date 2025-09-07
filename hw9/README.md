# Результаты тестирования sysbench

## Конфигурация по умолчанию
```
SQL statistics:
    queries performed:
        read:                            435386
        write:                           124367
        other:                           62189
        total:                           621942
    transactions:                        31090  (518.11 per sec.)
    queries:                             621942 (10364.52 per sec.)
    ignored errors:                      9      (0.15 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.0062s
    total number of events:              31090

Latency (ms):
         min:                                    3.68
         avg:                                    7.72
         max:                                   80.61
         95th percentile:                       15.55
         sum:                               239902.25

Threads fairness:
    events (avg/stddev):           7772.5000/8.62
    execution time (avg/stddev):   59.9756/0.00
```

## Кастомная конфигурация (my.cnf)
```
SQL statistics:
    queries performed:
        read:                            580356
        write:                           165767
        other:                           82892
        total:                           829015
    transactions:                        41438  (690.55 per sec.)
    queries:                             829015 (13815.25 per sec.)
    ignored errors:                      16     (0.27 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          60.0062s
    total number of events:              41438

Latency (ms):
         min:                                    3.72
         avg:                                    5.79
         max:                                   29.24
         95th percentile:                        7.17
         sum:                               239871.33

Threads fairness:
    events (avg/stddev):           10359.5000/9.12
    execution time (avg/stddev):   59.9678/0.00
```

## Выводы

Метрика	                     | Тест 1    | Тест 2    | Улучшение
-----------------------------|-----------|-----------|----------
Transactions per second (TPS)|	518.11	 |  690.55	 |  +33.3%
Queries per second           |	10364.52 |	13815.25 |	+33.3%
Avg. latency (ms)            |	7.72	 |  5.79	 |  -25.0%
95th percentile latency (ms) |	15.55	 |  7.17	 |  -53.9%
