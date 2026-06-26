SET enable_seqscan = off;
SET enable_hashjoin = off;

-- зміна налаштувань планувальника, яка обмежує його від використання seqscan та hashjoin, змушуючи використовувати індекси та більш оптимальні види join: nested loop та merge
