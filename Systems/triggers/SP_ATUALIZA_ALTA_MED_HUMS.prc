CREATE OR REPLACE PROCEDURE SP_ATUALIZA_ALTA_MED_HUMS(
	PCD_ATENDIMENTO IN NUMBER, 
	PDT_ALTA_MEDICA IN DATE,
	PCD_PACIENTE IN NUMBER,
	PCD_MULTI_EMPRESA IN NUMBER)
IS
BEGIN
	UPDATE	ALT_ATENDIME_HUMS
		SET		DT_ALTA_MEDICA = PDT_ALTA_MEDICA,
					CD_PACIENTE = PCD_PACIENTE,
					CD_MULTI_EMPRESA = PCD_MULTI_EMPRESA
		WHERE	CD_ATENDIMENTO = PCD_ATENDIMENTO;
END ;
/
