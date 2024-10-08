/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 01/02/2024
TITULO: CUSTO DE MAT E MED
DESCRICAO: RELATÓRIO DE CUSTO DE ATENDIMENTO DE MATERIAIS E MEDICAMENTOS
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT  Q1.CD_ATENDIMENTO,
        Q3.NM_CONVENIO,
        Q3.DATA_ATEND,
        Q3.DATA_ALTA,
        Q3.NM_PRESTADOR,
        Q3.TEMPO_MINUTOS,
        Q3.QTD_DIARIA ,
       (Q1.QTD_TOTAL) QTD_SAI_FATOR,
        Q1.CD_PRODUTO,
        Q1.DS_PRODUTO,
        TRUNC(FNC_MGES_CUSTO_MEDIO_PRODUTO(Q1.CD_PRODUTO, Q1.DATA_MVTO),2) AS CUSTO_MEDIO,
        TRUNC(((Q1.QTD_TOTAL) * FNC_MGES_CUSTO_MEDIO_PRODUTO(Q1.CD_PRODUTO, Q1.DATA_MVTO)),2) CUSTO
FROM   (SELECT  SUM(QT_SAIDA - QT_DEVOLVIDA) QTD_TOTAL,
                PA.CD_PRODUTO,
                P.DS_PRODUTO,
                MV.DT_MVTO DATA_MVTO,
                PA.CD_ATENDIMENTO
        FROM    DBAMV.PROD_ATEND PA,
                DBAMV.PRODUTO P,
                DBAMV.SNK_MVTO MV
        WHERE   PA.CD_PRODUTO = P.CD_PRODUTO
          AND   PA.CD_ATENDIMENTO = MV.CD_ATENDIMENTO
        GROUP
           BY   PA.CD_PRODUTO,
                P.DS_PRODUTO,
                MV.DT_MVTO,
                PA.CD_ATENDIMENTO
        ORDER
           BY   P.DS_PRODUTO                             
       )Q1,
       (SELECT  RF.CD_REG_FAT,
                RF.CD_ATENDIMENTO,
                RM.DT_ENTREGA_DA_FATURA DT_ENTREGA
        FROM    DBAMV.REG_FAT RF,
                DBAMV.REMESSA_FATURA RM
        WHERE   RF.CD_REMESSA = RM.CD_REMESSA
       )Q2,
       (SELECT  RF.CD_REG_FAT,
                RF.CD_ATENDIMENTO,
                C.NM_CONVENIO,
                TO_CHAR(A.DT_ATENDIMENTO,'DD/MM/YYYY') DATA_ATEND,
                TO_CHAR(A.DT_ALTA,'DD/MM/YYYY') DATA_ALTA,
                PRE.NM_PRESTADOR,
                CASE
                  WHEN  CA.SN_PRINCIPAL = 'S'
                    THEN CIR.DS_CIRURGIA
                      ELSE NULL
                        END ESPECIALIDADE,
               (AC.DT_FIM_LIMPEZA - AC.DT_REALIZACAO)*24 * 60 TEMPO_MINUTOS,
                RM.DT_ENTREGA_DA_FATURA,
                D.QTD_DIARIA
        FROM    DBAMV.REG_FAT RF,
                DBAMV.REMESSA_FATURA RM,
                DBAMV.ATENDIME A,
                DBAMV.CONVENIO C,
                DBAMV.AVISO_CIRURGIA AC,
                DBAMV.CIRURGIA_AVISO CA,
                DBAMV.CIRURGIA CIR,
                DBAMV.PRESTADOR PRE,
               (SELECT COUNT(CD_GRU_FAT) QTD_DIARIA,
                       RF.CD_ATENDIMENTO
                FROM   DBAMV.ITREG_FAT IRF,
                       DBAMV.REG_FAT RF
                WHERE  RF.CD_REG_FAT = IRF.CD_REG_FAT
                  AND  IRF.CD_GRU_FAT = 1
                GROUP 
                   BY  RF.CD_ATENDIMENTO)D
        WHERE   RF.CD_REMESSA = RM.CD_REMESSA
          AND   RF.CD_ATENDIMENTO = A.CD_ATENDIMENTO
          AND   A.CD_CONVENIO = C.CD_CONVENIO
          AND   A.CD_ATENDIMENTO = AC.CD_ATENDIMENTO
          AND   A.CD_ATENDIMENTO = D.CD_ATENDIMENTO
          AND   AC.CD_AVISO_CIRURGIA = CA.CD_AVISO_CIRURGIA
          AND   CA.CD_CIRURGIA = CIR.CD_CIRURGIA
          AND   A.CD_PRESTADOR = PRE.CD_PRESTADOR)Q3
          
WHERE  Q1.CD_ATENDIMENTO = Q2.CD_ATENDIMENTO   
  AND  Q2.CD_ATENDIMENTO = Q3.CD_ATENDIMENTO
  AND  Q2.DT_ENTREGA BETWEEN TO_DATE('01022023','DDMMYYYY') 
                         AND TO_DATE('31082023','DDMMYYYY')
  --AND  Q2.CD_ATENDIMENTO = 1042960                             
ORDER 
   BY  DS_PRODUTO
;