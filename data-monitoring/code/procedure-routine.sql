-- This step is used to create or replace the procedure during the excution routine
create or replace PROCEDURE PRC_MONITORING AS 
    
    
    /*
    The cursor is being used to check if the object cotains all the columns that are necessary to validate if the object is ok to be used in the data monitor process
    */
    CURSOR c_tabela IS -- Utiliza o cursor para validar os campos
        SELECT M.SCHEMA_NAME,
               M.OBJECT_NAME,
               M.FREQUENCY_TYPE,
               (SELECT 'X' 
                  FROM ALL_TAB_COLUMNS 
                 WHERE COLUMN_NAME = 'NU_SESSION' 
                   AND TABLE_NAME = M.OBJECT_NAME 
                   AND OWNER = M.SCHEMA_NAME) AS NU_SESSION,
               (SELECT 'X' 
                  FROM ALL_TAB_COLUMNS 
                 WHERE COLUMN_NAME = 'DT_INSERT' 
                   AND TABLE_NAME = M.OBJECT_NAME 
                   AND OWNER = M.SCHEMA_NAME) AS DT_INSERT,
               (SELECT 'X' 
                  FROM ALL_TAB_COLUMNS 
                 WHERE COLUMN_NAME = 'DT_LAST_UPDATE' 
                   AND TABLE_NAME = M.OBJECT_NAME 
                   AND OWNER = M.SCHEMA_NAME) AS DT_LAST_UPDATE,
               TO_CHAR(TO_DATE(TO_CHAR('20240101' || ' ' || m.UPDATE_TIME), 'RRRRMMDD HH24:MI') + INTERVAL '1' HOUR, 'HH24:MI') AS LIMIT_TIME,
               M.UPDATE_TIME AS ESTIMATED_TIME -- Alias para ESTIMATED_TIME
        FROM SCHEMA_NAME.MONITORING M
       /*
       This step uses the "PARAMETER"  is used as deafault info of all objects information.
       */
        
        WHERE M.UPDATE_TIME IS NOT NULL 
        AND UPDATE_TYPE IS NOT NULL
        AND M.FREQUENCY_TYPE = 'DAILY'; -- Into this filter is LIMITED to objects that have daily updated frequency

    /*
    This step is where all the variables are being create to do the data modeling process and return the database update status.
    */
    v_QUERY VARCHAR2(1000);
    v_UP_DATE_CHECK VARCHAR2(6);
    v_UP_HOUR_CHECK VARCHAR2(6);
    v_UP_RESULT_CHECK VARCHAR2(12);
    v_FINISH_TIME VARCHAR2(8);
    v_ESTIMATED_TIME VARCHAR2(8);
    v_ACTUAL_DATE DATE := SYSDATE; -- Creates the relation with today's information

    TYPE MYREC IS RECORD 
    (
        NU_SESSION_ODI NUMBER(10,0),
        DT_INSERT DATE,
        DT_LAST_UPDATE DATE,
        QT_ROWS NUMBER(10,0)
    );
    myrecord MYREC;


/*
 Creates the procedure LOOP   
*/
BEGIN
    
    FOR r_tabela IN c_tabela LOOP -- Defines witch table are being realted

   --   DBMS_OUTPUT.PUT_LINE('Consultando a tabela: ' || r_tabela.schema_name || '.' || r_tabela.object_name);    
        IF r_tabela.NU_SESSION = 'X' AND r_tabela.DT_INSERT = 'X' AND r_tabela.DT_LAST_UPDATE = 'X'  THEN -- If this columns exists then

            v_query :=  'SELECT MAX(NU_SESSION) NU_SESSION, MAX(DT_INSERT) DT_INSERT, MAX(DT_LAST_UPDATE) DT_LAST_UPDATE, COUNT(1) AS QT_ROWS FROM ' || r_tabela.schema_name || '.' || r_tabela.object_name || ' WHERE TRUNC(DT_LAST_UPDATE) = TRUNC(SYSDATE)'; -- Compares the Last Update date with Sysdate

            -- Excute dinamic table process
            EXECUTE IMMEDIATE v_query INTO myrecord;

            -- This step is used to create the status that are being returned according with the updated information
            IF TRUNC(myrecord.DT_LAST_UPDATE) != TRUNC(SYSDATE) THEN 
                v_UP_DATE_CHECK := 'NOT OK';
            ELSE
                v_UP_DATE_CHECK := 'OK';
            END IF;

            IF TO_CHAR(myrecord.DT_LAST_UPDATE, 'HH24:MI') <= r_tabela.LIMIT_TIME THEN 
                v_UP_HOUR_CHECK := 'OK';
            ELSE 
                v_UP_HOUR_CHECK := 'NOT OK';
            END IF;

            IF TRUNC(myrecord.DT_LAST_UPDATE) = TRUNC(SYSDATE) AND TO_CHAR(myrecord.DT_LAST_UPDATE, 'HH24:MI') <= r_tabela.LIMIT_TIME THEN
                v_UP_RESULT_CHECK := 'UPDATED';
            ELSIF TRUNC(myrecord.DT_LAST_UPDATE) = TRUNC(SYSDATE) AND TO_CHAR(myrecord.DT_LAST_UPDATE, 'HH24:MI') > r_tabela.LIMIT_TIME THEN
                v_UP_RESULT_CHECK := 'LATE UPDATED';
            ELSE 
                v_UP_RESULT_CHECK := 'NOT OK';
            END IF;

            -- This step ads a time to the finish hour
            v_FINISH_TIME := TO_CHAR(myrecord.DT_LAST_UPDATE, 'HH24:MI');

            INSERT INTO SCHEMA_NAME.MONITORING -- It's used to insert information into the columns
            (
                NU_SESSION,
                DT_INSERT,
                DT_LAST_UPDATE,
                SCHEMA_NAME,
                OBJECT_NAME,
                FREQUENCY_TYPE,
                ACTUAL_DATE,
                ESTIMATED_TIME,
                LIMIT_TIME,
                FINISH_TIME,
                DATA_VOLUME,
                UP_DATE_CHECK,
                UP_HOUR_CHECK,
                RESULT_UPDATE
            )
            VALUES -- The values below are being inserted into the columns 
            (
                myrecord.NU_SESSION,
                myrecord.DT_INSERT,
                myrecord.DT_LAST_UPDATE,
                r_tabela.schema_name,
                r_tabela.object_name,
                r_tabela.frequency_type,
                v_ACTUAL_DATE,
                r_tabela.ESTIMATED_TIME, -- The right way to insert estimated time
                r_tabela.LIMIT_TIME,
                v_FINISH_TIME,
                myrecord.QT_ROWS,
                v_UP_DATE_CHECK,
                v_UP_HOUR_CHECK,
                v_UP_RESULT_CHECK
            );
            COMMIT;

        END IF;

    END LOOP;

/*
    How much data are going to be saved
*/
--DELETE FROM FA_MONITORING WHERE DT_INSERT > TRUNC(SYSDATE -60); -- REGRA DE ARMAZENAMENTO DE DADOS DA TABELA
-- COMMIT;
END PRC_MONITORING;
