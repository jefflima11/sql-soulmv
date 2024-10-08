/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 01/02/2024
TITULO: QUANTITATIVO DE PACIENTE EM OBSERVAÇÃO PA POR MÊS
DESCRICAO: 
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT  Count(DT_ATENDIMENTO) TOTAL_OBSERVACAO
       ,DT_ATENDIMENTO

FROM    (
          SELECT  A.CD_ATENDIMENTO
                ,PA.NM_PACIENTE
                ,O.DS_ORI_ATE
                ,To_Char(A.DT_ATENDIMENTO,'MM/YYYY') DT_ATENDIMENTO
                --,A.DT_ATENDIMENTO
                ,To_Char(A.HR_ATENDIMENTO,'HH24:MI') HORA_ATENDIMENTO
                ,P.DS_PRODUTO

          FROM
                  DBAMV.ATENDIME A
                ,DBAMV.PACIENTE PA
                ,DBAMV.PRODUTO P
                ,DBAMV.SOLSAI_PRO SSP
                ,DBAMV.ITSOLSAI_PRO ISSP
                ,DBAMV.PRE_MED PM
                ,DBAMV.ORI_ATE O

          WHERE
                  A.CD_ATENDIMENTO = SSP.CD_ATENDIMENTO
            AND   SSP.CD_SOLSAI_PRO = ISSP.CD_SOLSAI_PRO
            AND   ISSP.CD_PRODUTO = P.CD_PRODUTO
            AND   A.CD_ATENDIMENTO = PM.CD_ATENDIMENTO
            AND   A.CD_PACIENTE = PA.CD_PACIENTE
            AND   A.CD_ORI_ATE = O.CD_ORI_ATE

            AND   A.TP_ATENDIMENTO = 'U'
            AND   A.DT_ALTA IS NOT NULL
            --AND   A.DT_ATENDIMENTO = To_Date(SYSDATE)
            AND   P.DS_PRODUTO LIKE ('%SORO%500ML%')
            AND   A.CD_MULTI_EMPRESA = 1
            AND   A.CD_ORI_ATE = 14
            AND   A.DT_ATENDIMENTO BETWEEN To_Date('01/01/2023','DD/MM/YYYY') AND To_Date(To_Date('31/07/2023','DD/MM/YYYY'))


          GROUP BY
                  A.CD_ATENDIMENTO
                  ,A.DT_ATENDIMENTO
                  ,A.HR_ATENDIMENTO
                  ,P.DS_PRODUTO
                  ,PA.NM_PACIENTE
            ,O.DS_ORI_ATE

          ORDER BY DT_ATENDIMENTO

        )F


--WHERE F.DT_ATENDIMENTO = '05/2023'
GROUP BY DT_ATENDIMENTO

ORDER BY DT_ATENDIMENTO
--MULTI EMPRESA = 1 } HOSPITAL UNIMED