/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 01/02/2024
TITULO: RETONRO DE PACIENTE PA COM MESMO CID DENTRO DE 24 HORAS MENSAL
DESCRICAO: 
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT  Count(TOTAL) TOTAL
       ,To_Char(DT_ATENDIMENTO,'MM/YYYY') DATA

FROM (
SELECT
       P.NM_PACIENTE
      --,A.CD_ATENDIMENTO
      ,Count(NM_PACIENTE) TOTAL
      ,A.DT_ATENDIMENTO
      ,C.DS_CID

FROM DBAMV.ATENDIME A
    ,DBAMV.PACIENTE P
    ,DBAMV.CID C

WHERE A.CD_PACIENTE = P.CD_PACIENTE
AND   A.CD_CID = C.CD_CID

AND   A.TP_ATENDIMENTO = 'U'
AND   A.CD_ORI_ATE = 14
AND   A.DT_ATENDIMENTO BETWEEN To_Date('01/01/2023','DD/MM/YYYY') AND To_Date('31/07/2023','DD/MM/YYYY')

GROUP BY NM_PACIENTE,DT_ATENDIMENTO,DS_CID

HAVING Count(NM_PACIENTE)>1

ORDER BY TOTAL

)
GROUP BY To_Char(DT_ATENDIMENTO,'MM/YYYY')
ORDER BY DATA
