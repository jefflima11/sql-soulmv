/*CREATED BY
NAME: JEFFERSON LIMA GONCALVES
CARGO: ANALISTA E DESENVOLVEDOR DE SISTEMAS JR
DATA: 27/05/2024
TITULO: EXAMES LABORATORIAIS SOLICITADOS EM PRESCRIÇÕES NO PERIÓDO
DESCRICAO: 
FILTROS:

ÚLTIMA ATUALIZAÇÃO
RESPÓNSAVEL:
DATA:
MOTIVO:
DESCRIÇÃO:
*/

SELECT  TP.CD_TIP_PRESC,
        PM.DT_PRE_MED,
		TP.DS_TIP_PRESC,
		DECODE(EL.CD_EXA_LAB,NULL,'N/A',EL.CD_EXA_LAB) CD_SAD,
		DECODE(EL.NM_EXA_LAB,NULL,'N/A',EL.NM_EXA_LAB) DS_SAD,
		DECODE(PF2.CD_PRO_FAT,NULL,'N/A',PF2.CD_PRO_FAT) CD_PRO_FAT_X_SAD,
		DECODE(PF2.DS_PRO_FAT,NULL,'N/A',PF2.DS_PRO_FAT) DS_PRO_FAT_X_SAD,
		DECODE(PF.CD_PRO_FAT,NULL,'N/A',PF.CD_PRO_FAT) CD_PRO_FAT,
		DECODE(PF.DS_PRO_FAT,NULL,'N/A',PF.DS_PRO_FAT) DS_PRO_FAT 

FROM    DBAMV.ITPRE_MED IPM,
        DBAMV.PRE_MED PM,
		DBAMV.TIP_PRESC TP,
		DBAMV.EXA_LAB EL,
		DBAMV.PRO_FAT PF,
		DBAMV.PRO_FAT PF2

WHERE   IPM.CD_PRE_MED = PM.CD_PRE_MED
  AND   IPM.CD_TIP_PRESC = TP.CD_TIP_PRESC
  AND   TP.CD_EXA_LAB = EL.CD_EXA_LAB(+)
  AND   TP.CD_PRO_FAT = PF.CD_PRO_FAT(+)
  AND   EL.CD_PRO_FAT = PF2.CD_PRO_FAT(+)

  AND   TP.CD_TIP_ESQ = 'LAB'
  AND   PM.DT_PRE_MED BETWEEN TO_DATE('01/01/2023','DD/MM/YYYY') AND TO_DATE('31/12/2023','DD/MM/YYYY')
