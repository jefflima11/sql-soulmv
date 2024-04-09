/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 11/03/2024
TITULO: RELATÓRIO DE CONTAS RECEBIDAS E INADIMPLENTES
DESCRICAO: 
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT 	SUM(TT_REG_FAT)QTD_INA_FAT,
		SUM(TT_REG_AMB)QTD_INA_AMB

FROM   (SELECT	COUNT(*)TT_REG_FAT,
				TO_NUMBER('') TT_REG_AMB
		FROM   (SELECT 	CR.CD_REG_FAT,
						CR.DS_CON_REC,
						CR.CD_CON_REC,
						CR.VL_PREVISTO,
						CR.VL_ACRESCIMO,
						ICR.VL_SOMA_RECEBIDO,
						( CR.VL_PREVISTO - (DECODE(ICR.VL_SOMA_RECEBIDO,NULL,0,ICR.VL_SOMA_RECEBIDO) - DECODE(CR.VL_ACRESCIMO,NULL,0,CR.VL_ACRESCIMO)))DIF
				FROM    DBAMV.CON_REC CR,
						DBAMV.ITCON_REC ICR

				WHERE   CR.CD_CON_REC = ICR.CD_CON_REC
				  AND   CR.CD_MULTI_EMPRESA = 1
				  AND   CR.CD_REG_FAT IS NOT NULL
				  AND   ICR.NR_PARCELA = 1
				  AND   CR.TP_CON_REC = 'P'
				  AND   TO_CHAR(CR.DT_LANCAMENTO,'MMYYYY') = '012024'
				)

		WHERE   DIF NOT IN (0)

		UNION ALL

		SELECT	TO_NUMBER('') TT_REG_FAT,
						COUNT(*)TT_REG_AMB

		FROM   (SELECT	CR.CD_REG_AMB,
						CR.DS_CON_REC,
						CR.CD_CON_REC,
						CR.VL_PREVISTO,
						CR.VL_ACRESCIMO,
						ICR.VL_SOMA_RECEBIDO,
						( CR.VL_PREVISTO - (DECODE(ICR.VL_SOMA_RECEBIDO,NULL,0,ICR.VL_SOMA_RECEBIDO) - DECODE(CR.VL_ACRESCIMO,NULL,0,CR.VL_ACRESCIMO)))DIF

				FROM    DBAMV.CON_REC CR,
						DBAMV.ITCON_REC ICR

				WHERE   CR.CD_CON_REC = ICR.CD_CON_REC
				  AND   CR.CD_MULTI_EMPRESA = 1
				  AND   CR.CD_REG_AMB IS NOT NULL
				  AND   ICR.NR_PARCELA = 1
				  AND   CR.TP_CON_REC = 'P'
				  AND   TO_CHAR(CR.DT_LANCAMENTO,'MMYYYY') = '012024')

		WHERE   DIF NOT IN (0)

);