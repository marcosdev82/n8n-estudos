SELECT
    v.nome AS veiculo,
    c.concessionaria,
    e.estado,
    e.sigla,
    COUNT(*) AS total_vendas,
    SUM(vd.valor_pago) AS valor_total,
    AVG(vd.valor_pago) AS ticket_medio,
    MAX(vd.data_venda) AS ultima_venda
FROM vendas vd
JOIN veiculos v 
    ON vd.id_veiculos = v.id_veiculos
JOIN concessionarias c 
    ON vd.id_concessionarias = c.id_concessionarias
JOIN cidades ci
    ON c.id_cidades = ci.id_cidades
JOIN estados e
    ON ci.id_estados = e.id_estados
WHERE vd.data_venda >= NOW() - INTERVAL '30 days'
GROUP BY v.nome, c.concessionaria, e.estado, e.sigla
ORDER BY valor_total DESC;
