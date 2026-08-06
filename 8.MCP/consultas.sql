getSalesbyState:

SELECT e.sigla AS state, e.estado AS state_name, COUNT(*)::int AS total_sales, COALESCE(SUM(v.valor_pago),0)::numeric(12,2) AS total_revenue
FROM vendas v
JOIN concessionarias c ON c.id_concessionarias = v.id_concessionarias
JOIN cidades ci ON ci.id_cidades = c.id_cidades
JOIN estados e ON e.id_estados = ci.id_estados
GROUP BY e.sigla, e.estado
ORDER BY total_revenue DESC;


getTopVehicles:

SELECT ve.nome AS vehicle, ve.tipo AS type, COUNT(*)::int AS total_sales, COALESCE(SUM(v.valor_pago),0)::numeric(12,2) AS total_revenue
FROM vendas v
JOIN veiculos ve ON ve.id_veiculos = v.id_veiculos
GROUP BY ve.nome, ve.tipo
ORDER BY total_sales DESC
LIMIT 5;


getSalesSummary:

SELECT COUNT(*)::int AS total_sales, COALESCE(SUM(valor_pago),0)::numeric(12,2) AS total_revenue, COALESCE(AVG(valor_pago),0)::numeric(12,2) AS avg_ticket
FROM vendas;