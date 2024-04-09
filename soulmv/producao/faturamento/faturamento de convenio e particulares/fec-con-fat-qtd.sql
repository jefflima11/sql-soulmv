/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 18/03/2024
TITULO: CONTAS FECHADAS POR FATURISTAS ANALITICO
DESCRICAO: MÉDIA DE FATURAMENTO INDIVIDUAL DIÁRIA
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO: MÉDIA DIARIA
*/

SELECT	QTD_TT,
				DT_COMPETENCIA,
				NM_USUARIO_FECHOU,
				TP_CONTA

FROM   (SELECT	COUNT(RG.CD_REG_FAT) QTD_TT,
				TO_DATE(RF.DT_FECHAMENTO) DT_COMPETENCIA,
				RG.NM_USUARIO_FECHOU,
				TO_CHAR('INT') TP_CONTA

		FROM	DBAMV.REG_FAT RG,
				DBAMV.REMESSA_FATURA RF,
				DBAMV.FATURA F

		WHERE	RG.CD_REMESSA = RF.CD_REMESSA
		  AND   RF.CD_FATURA = F.CD_FATURA
		  AND 	RG.SN_FECHADA = RF.SN_FECHADA
		  AND 	RG.CD_MULTI_EMPRESA = F.CD_MULTI_EMPRESA
		  AND 	RF.SN_FECHADA = 'S'
		  AND   F.CD_MULTI_EMPRESA = 1
		  AND 	TO_CHAR(F.DT_COMPETENCIA,'MMYYYY') = '012024'

		GROUP BY	TO_DATE(RF.DT_FECHAMENTO),
					RG.NM_USUARIO_FECHOU,
					TO_CHAR('INT')

		UNION ALL

		SELECT	COUNT(RA.CD_REG_AMB) QTD_TT,
				TO_DATE(RF.DT_FECHAMENTO) DT_COMPETENCIA,
				IRA.NM_USUARIO_FECHOU,
				TO_CHAR('AMB') TP_CONTA

		FROM 	DBAMV.REG_AMB RA,
				DBAMV.REMESSA_FATURA RF,
				DBAMV.FATURA F,
				DBAMV.ITREG_AMB IRA

		WHERE	RA.CD_REMESSA = RF.CD_REMESSA
		  AND	RF.CD_FATURA = F.CD_FATURA
		  AND 	RA.CD_REG_AMB = IRA.CD_REG_AMB
		  AND	RA.CD_MULTI_EMPRESA = F.CD_MULTI_EMPRESA
		  AND  	RA.SN_FECHADA = RF.SN_FECHADA
		  AND  	F.CD_MULTI_EMPRESA = 1
		  AND 	RF.SN_FECHADA = 'S'
		  AND   TO_CHAR(RF.DT_FECHAMENTO,'MMYYYY') = '012024' 

		GROUP BY	TO_DATE(RF.DT_FECHAMENTO),
					IRA.NM_USUARIO_FECHOU,
					TO_CHAR('AMB')
	   )


ORDER BY NM_USUARIO_FECHOU;