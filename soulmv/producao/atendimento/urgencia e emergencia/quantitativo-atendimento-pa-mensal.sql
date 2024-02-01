/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 01/02/2024
TITULO: QUANTITATIVO DE ATENDIMENTO PA MENSAL
DESCRICAO: QUANTITATIVO DE ATENDIMENTO PA MENSAL (ADULTO X PEDIATRICO X OBSTETRICO)
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT
  F1.TOTAL_PA,
  F2.TOTAL_PA_ADT,
  F3.TOTAL_OBS,
  F4.TOTAL_PED,
  F1.DATA

FROM(
  SELECT
    Count(*)TOTAL_PA,
    To_Char(A.DT_ATENDIMENTO,'MM/YYYY') DATA

  FROM
    DBAMV.ATENDIME A

  WHERE
        A.DT_ATENDIMENTO BETWEEN To_Date('01012023','DDMMYYYY')
                            AND To_Date('31072023','DDMMYYYY')
    AND A.TP_ATENDIMENTO = 'U'

  GROUP BY
    To_Char(A.DT_ATENDIMENTO,'MM/YYYY')

  ORDER BY
    DATA
    )F1,

  (SELECT
     Count(*) AS TOTAL_PA_ADT,
     To_Char(A.DT_ATENDIMENTO, 'MM/YYYY') AS DATA
   FROM
     DBAMV.ATENDIME A
     JOIN DBAMV.CID C ON A.CD_CID = C.CD_CID
   WHERE
     A.DT_ATENDIMENTO BETWEEN To_Date('01012023', 'DDMMYYYY')
                          AND To_Date('31072023', 'DDMMYYYY')
     AND A.CD_ORI_ATE = 14
     AND A.TP_ATENDIMENTO = 'U'
     AND NOT (C.DS_CID LIKE '%OBSTE%' OR C.DS_CID LIKE '%PEDIA%')
     AND A.CD_SERVICO NOT IN (89,5,28)

   GROUP BY
     To_Char(A.DT_ATENDIMENTO, 'MM/YYYY')
   ORDER BY
     DATA
  )F2,
  (SELECT  Count(*)TOTAL_OBS
       ,To_Char(A.DT_ATENDIMENTO,'MM/YYYY') DATA
   FROM
     DBAMV.ATENDIME A
   WHERE
         A.DT_ATENDIMENTO BETWEEN To_Date('01012023', 'DDMMYYYY')
                              AND To_Date('31072023', 'DDMMYYYY')
     AND A.TP_ATENDIMENTO = 'U'
     AND  A.CD_SERVICO IN (89,5,28)
   GROUP BY
     To_Char(A.DT_ATENDIMENTO, 'MM/YYYY')
   ORDER BY
     DATA
  )F3,
  (SELECT
     Count(*) AS TOTAL_PED,
     To_Char(A.DT_ATENDIMENTO, 'MM/YYYY') DATA
   FROM
     DBAMV.ATENDIME A
     JOIN DBAMV.CID C ON A.CD_CID = C.CD_CID
   WHERE
         A.DT_ATENDIMENTO BETWEEN To_Date('01012023', 'DDMMYYYY')
                        AND To_Date('31072023', 'DDMMYYYY')
     AND A.CD_ORI_ATE = 4
     AND A.TP_ATENDIMENTO = 'U'

   GROUP BY
     To_Char(A.DT_ATENDIMENTO, 'MM/YYYY')
   ORDER BY
     DATA
  )F4

WHERE
       F1.DATA = F2.DATA
  AND  F2.DATA = F3.DATA(+)
  AND  F1.DATA = F4.DATA
