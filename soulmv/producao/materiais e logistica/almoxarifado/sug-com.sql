/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 09/04/2023
TITULO: RELATÓRIO DE SUGENSTÃO DE COMPRAS
DESCRICAO: 
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT  E.DS_ESTOQUE ESTOQUE,
        P.DS_PRODUTO,
		UP.DS_UNIDADE,
        EP.QT_ESTOQUE_ATUAL QUANT,
        TRUNC(P.VL_CUSTO_MEDIO,4) VL_UNIT
        
        
FROM    DBAMV.EST_PRO EP,
        DBAMV.ESTOQUE E,
		DBAMV.PRODUTO P,
		DBAMV.UNI_PRO UP

WHERE   EP.CD_ESTOQUE = E.CD_ESTOQUE
  AND   EP.CD_PRODUTO = P.CD_PRODUTO
  AND   P.CD_PRODUTO = UP.CD_PRODUTO
  
  AND   EP.CD_PRODUTO = 12582
  AND   E.CD_ESTOQUE = 1
