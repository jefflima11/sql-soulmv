/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 01/02/2024
TITULO: EXAMES LAB POR ATENDIMENTO PA
DESCRICAO: RETORNO DE INFORMAÇÕES DE EXAMES LABORATORIAIS DESENOLVIDOS VIA ATENDIMENTO PRONTO ATENDIMENTO ADULTO
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT  Count(IPL.CD_ITPED_LAB)TOTAL
       ,'LABORATORIAIS' EXAMES
       ,To_Char(DT_PEDIDO,'MM/YYYY') DATA
FROM
        DBAMV.PED_LAB PL
       ,DBAMV.ATENDIME A
       ,DBAMV.ITPED_LAB IPL
       ,DBAMV.ORI_ATE O

WHERE
        A.CD_ATENDIMENTO = PL.CD_ATENDIMENTO
  AND   IPL.CD_PED_LAB = PL.CD_PED_LAB
  AND   O.CD_ORI_ATE = A.CD_ORI_ATE

  AND   A.TP_ATENDIMENTO IN ('U')
  AND   A.DT_ATENDIMENTO BETWEEN To_Date('01/01/2023','DD/MM/YYYY')  AND To_Date('31/07/2023','DD/MM/YYYY')
  AND   A.CD_ORI_ATE = 14

GROUP BY To_Char(DT_PEDIDO,'MM/YYYY')