SELECT 
    v.nome AS veiculo,
    e.sigla AS estado,
    SUM(ven.valor_pago) AS total_vendas
FROM 
    vendas ven
JOIN 
    veiculos v ON v.id_veiculos = ven.id_veiculos
JOIN 
    concessionarias c ON c.id_concessionarias = ven.id_concessionarias
JOIN 
    cidades ci ON ci.id_cidades = c.id_cidades
JOIN 
    estados e ON e.id_estados = ci.id_estados
WHERE 
    e.sigla = ‘SP’    
GROUP BY 
    v.nome, e.sigla
ORDER BY 
    total_vendas DESC;
