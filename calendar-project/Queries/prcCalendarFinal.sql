CREATE OR REPLACE PROCEDURE PRC_FERIADO AS
    v_ano NUMBER := EXTRACT(YEAR FROM SYSDATE);
    v_a NUMBER;
    v_b NUMBER;
    v_c NUMBER;
    v_d NUMBER;
    v_e NUMBER;
    v_f NUMBER;
    v_g NUMBER;
    v_h NUMBER;
    v_i NUMBER;
    v_k NUMBER;
    v_l NUMBER;
    v_m NUMBER;
    v_mes NUMBER;
    v_dia NUMBER;
    v_pascoa DATE;
    v_carnaval DATE;
    v_quarta_feira_de_cinzas DATE;
    v_paixao_de_cristo DATE;
    v_corpo_de_cristo DATE;

BEGIN
    -- Cálculo das datas dos feriados móveis
    v_a := v_ano MOD 19;
    v_b := FLOOR(v_ano / 100);
    v_c := v_ano MOD 100;
    v_d := FLOOR(v_b / 4);
    v_e := v_b MOD 4;
    v_f := FLOOR((v_b + 8) / 25);
    v_g := FLOOR((v_b - v_f + 1) / 3);
    v_h := (19 * v_a + v_b - v_d - v_g + 15) MOD 30;
    v_i := FLOOR(v_c / 4);
    v_k := v_c MOD 4;
    v_l := (32 + 2 * v_e + 2 * v_i - v_h - v_k) MOD 7;
    v_m := FLOOR((v_a + 11 * v_h + 22 * v_l) / 451);
    v_mes := FLOOR((v_h + v_l - 7 * v_m + 114) / 31);
    v_dia := ((v_h + v_l - 7 * v_m + 114) MOD 31) + 1;
    v_pascoa := TO_DATE(v_dia || '/' || v_mes || '/' || v_ano, 'DD/MM/YYYY');
    v_carnaval := v_pascoa - 47;
    v_quarta_feira_de_cinzas := v_pascoa - 46;
    v_paixao_de_cristo := v_pascoa - 2;
    v_corpo_de_cristo := v_pascoa + 60;

    -- Atualização das datas dos feriados móveis
    UPDATE TBL_FERIADO
    SET DATA = v_pascoa
    WHERE FERIADO = 'PASCOA';

    UPDATE TBL_FERIADO
    SET DATA = v_carnaval
    WHERE FERIADO = 'CARNAVAL';

    UPDATE TBL_FERIADO
    SET DATA = v_quarta_feira_de_cinzas
    WHERE FERIADO = 'QUARTA FEIRA DE CINZAS';

    UPDATE TBL_FERIADO
    SET DATA = v_paixao_de_cristo
    WHERE FERIADO = 'PAIXAO DE CRISTO';

    UPDATE TBL_FERIADO
    SET DATA = v_corpo_de_cristo
    WHERE FERIADO = 'CORPO DE CRISTO';

    -- Atualização das datas dos feriados fixos
    UPDATE TBL_FERIADO
    SET DATA = CASE
          WHEN FERIADO = 'CONFRATERNIZACAO UNIVERSAL' THEN TO_DATE('01/01/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'TIRADENTES' THEN TO_DATE('21/04/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'DIA DO TRABALHO' THEN TO_DATE('01/05/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'INDEPENDENCIA DO BRASIL' THEN TO_DATE('07/09/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'DIA DE NOSSA SENHORA APARECIDA' THEN TO_DATE('12/10/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'DIA DO SERVIDOR PUBLICO' THEN TO_DATE('28/10/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'FINADOS' THEN TO_DATE('02/11/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'PROCLAMACAO DA REPUBLICA' THEN TO_DATE('15/11/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'CONSCIENCIA NEGRA' THEN TO_DATE('20/11/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          WHEN FERIADO = 'NATAL' THEN TO_DATE('25/12/' || TO_CHAR(SYSDATE, 'YYYY'), 'DD/MM/YYYY')
          ELSE DATA 
       END;

    -- Atualização dos dias da semana do ano atual
    UPDATE TBL_FERIADO
    SET DIA_SEMANA = TO_CHAR(DATA, 'DAY');

    -- Inserção de mais 12 meses de dados na tabela
    INSERT INTO TBL_FERIADO(DATA, COD_UF, UF, ESTADO, COD_MUN, MUNICIPIO, FERIADO, TIPO_FERIADO, DIA_SEMANA)
    SELECT ADD_MONTHS(DATA, 12), COD_UF, UF, ESTADO, COD_MUN, MUNICIPIO, FERIADO, TIPO_FERIADO, DIA_SEMANA
    FROM TBL_FERIADO
    WHERE EXTRACT(YEAR FROM DATA) = EXTRACT(YEAR FROM SYSDATE);

    -- Atualização dos dias da semana do ano seguinte
    UPDATE TBL_FERIADO
    SET DIA_SEMANA = TO_CHAR(DATA, 'DAY')
    WHERE EXTRACT(YEAR FROM DATA) = EXTRACT(YEAR FROM SYSDATE) + 1;

    -- Inserção dos feriados até 2049
    WHILE v_ano <= 2049 LOOP
        INSERT INTO TBL_FERIADO (DATA, COD_UF, UF, ESTADO, COD_MUN, MUNICIPIO, FERIADO, TIPO_FERIADO, DIA_SEMANA)
        SELECT TO_DATE(v_ano || '-' || TO_CHAR(DATA, 'MM-DD'), 'YYYY-MM-DD'), 
               COD_UF, UF, ESTADO, COD_MUN, MUNICIPIO, FERIADO, TIPO_FERIADO, TO_CHAR(TO_DATE(v_ano || '-' || TO_CHAR(DATA, 'MM-DD'), 'YYYY-MM-DD'), 'DAY')
        FROM TBL_FERIADO
        WHERE EXTRACT(YEAR FROM DATA) = EXTRACT(YEAR FROM SYSDATE)
        AND NOT EXISTS (
          SELECT 1 FROM TBL_FERIADO WHERE EXTRACT(YEAR FROM DATA) = v_ano
        );
        v_ano := v_ano + 1;
    END LOOP;
END;
