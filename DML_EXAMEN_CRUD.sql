use db_hce_core;

SET autocommit = 0;

DROP PROCEDURE IF EXISTS getExamenForId;
DROP PROCEDURE IF EXISTS insertExamen;
DROP PROCEDURE IF EXISTS updateExamen;
DROP PROCEDURE IF EXISTS deleteExamen;
DROP PROCEDURE IF EXISTS getTipoExamenForId;
DROP PROCEDURE IF EXISTS insertTipoExamen;
DROP PROCEDURE IF EXISTS updateTipoExamen;
DROP PROCEDURE IF EXISTS deleteTipoExamen;
DROP PROCEDURE IF EXISTS getDiagnosticoForId;
DROP PROCEDURE IF EXISTS insertDiagnostico;
DROP PROCEDURE IF EXISTS updateDiagnostico;
DROP PROCEDURE IF EXISTS deleteDiagnostico;


DELIMITER //
CREATE PROCEDURE getExamenForId (IN ID INT)
BEGIN
  IF (SELECT EXISTS (SELECT idExamen FROM Examenes WHERE idExamen = ID)) THEN
    SELECT idExamen "Id Examen", 
        resumen "Resumen", 
        resultados "Resultados",
        anexos "Anexos",
        TipoExamen_idTipoExamen "Id Tipo Examen",
        Diagnosticos_idDiagnostico "Id Diagnostico"
    FROM Examenes
    WHERE idExamen = ID;
  ELSE
    SELECT 'NO EXISTE EL EXAMEN';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE insertExamen (
  IN RESUM VARCHAR(30),
  IN RESUL VARCHAR(30),
  IN ANEX VARCHAR(30), 
  IN ID_TIPOEXAMEN INT,
  IN ID_DIAGNOSTICO INT)
BEGIN
    START TRANSACTION;
        INSERT INTO Examenes(resumen, resultados, anexos, TipoExamen_idTipoExamen, Diagnosticos_idDiagnostico)
      VALUES(RESUM, RESUL, ANEX, ID_TIPOEXAMEN, ID_DIAGNOSTICO);
    IF ROW_COUNT() > 0 THEN
      SELECT 'EL EXAMEN HA SIDO CREADA CON EXITO', (SELECT MAX(idExamen) FROM Examenes) "Id Examen";
	  COMMIT;
    ELSE
      SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL EXAMEN';
      ROLLBACK;
    END IF;
END //

DELIMITER //
CREATE PROCEDURE updateExamen (
  IN ID INT, 
  IN RESUM VARCHAR(30),
  IN RESUL VARCHAR(30),
  IN ANEX VARCHAR(30), 
  IN ID_TIPOEXAMEN INT,
  IN ID_DIAGNOSTICO INT)
BEGIN
  IF (SELECT EXISTS (SELECT idExamen FROM Examenes WHERE idExamen = ID)) THEN
    START TRANSACTION;
        UPDATE Examenes 
			SET idExamen = ID,
				resumen = RESUM,
				resultados = RESUL,
				anexos = ANEX,
				TipoExamen_idTipoExamen = ID_TIPOEXAMEN,
				Diagnosticos_idDiagnostico = ID_DIAGNOSTICO
			WHERE idExamen = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL EXAMEN HA SIDO ACTUALIZADO';
            COMMIT;
	    ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
    END IF;
  ELSE
    SELECT 'EL EXAMEN NO EXISTE CON ESE ID';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteExamen (IN ID INT)
BEGIN
  IF (SELECT EXISTS (SELECT idExamen FROM Examenes WHERE idExamen = ID)) THEN
    START TRANSACTION;
        DELETE FROM Examenes WHERE idExamen = ID;
        IF ROW_COUNT() THEN
      SELECT 'EL EXAMEN FUE ELIMINADA CON EXITO';
            COMMIT;
    ELSE
      SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
    END IF;
  ELSE
    SELECT 'EL EXAMEN NO EXISTE CON ESE ID';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE getTipoExamenForId (IN ID INT)
BEGIN
  IF (SELECT EXISTS (SELECT idTipoExamen FROM TipoExamen WHERE idTipoExamen = ID)) THEN
    SELECT idTipoExamen "Id Tipo de examen", 
        nombreTipo "Nombre de tipo de examen"
    FROM TipoExamen
    WHERE idTipoExamen = ID;
  ELSE
    SELECT 'NO EXISTE EL TIPO EXAMEN';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE insertTipoExamen (IN ID INT, IN NOMBRE_TIPOEXAMEN VARCHAR(15))
BEGIN
  IF (SELECT EXISTS (SELECT idTipoExamen FROM TipoExamen WHERE idTipoExamen = ID)) THEN
    SELECT 'LA ENTIDAD YA EXISTE CON ESE ID';
  ELSE
    START TRANSACTION;
        INSERT INTO TipoExamen(idTipoExamen, nombreTipo)
      VALUES(ID, NOMBRE_TIPOEXAMEN);
    IF ROW_COUNT() > 0 THEN
		SELECT 'EL TIPO EXAMEN HA SIDO CREADA CON EXITO', ID "ID EXAMEN";
            COMMIT;
    ELSE
      SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL TIPO EXAMEN';
      ROLLBACK;
    END IF;
  END IF;
END //

DELIMITER //
CREATE PROCEDURE updateTipoExamen (IN ID INT, IN NOMBRE_TIPOEXAMEN VARCHAR(15))
BEGIN
  IF (SELECT EXISTS (SELECT idTipoExamen FROM TipoExamen WHERE idTipoExamen = ID)) THEN
    START TRANSACTION;
        UPDATE TipoExamen 
			SET idTipoExamen = ID,
				nombreTipo = NOMBRE_TIPOEXAMEN
		WHERE idTipoExamen = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL TIPO EXAMEN HA SIDO ACTUALIZADO';
            COMMIT;
		ELSE
		  SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
		  ROLLBACK;
		END IF;
  ELSE
    SELECT 'EL TIPO EXAMEN NO EXISTE CON ESE ID';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteTipoExamen (IN ID INT)
BEGIN
  IF (SELECT EXISTS (SELECT idTipoExamen FROM TipoExamen WHERE idTipoExamen = ID)) THEN
    START TRANSACTION;
        DELETE FROM TipoExamen WHERE idTipoExamen = ID;
        IF ROW_COUNT() THEN
      SELECT 'EL TIPO EXAMEN FUE ELIMINADA CON EXITO';
            COMMIT;
    ELSE
      SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
    END IF;
  ELSE
    SELECT 'EL TIPO EXAMEN NO EXISTE CON ESE ID';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE getDiagnosticoForId (IN ID INT)
BEGIN
  IF (SELECT EXISTS (SELECT idDiagnostico FROM Diagnosticos WHERE idDiagnostico = ID)) THEN
    SELECT idDiagnostico "Id Diagnostico", 
        Diagnostico "Diagnostico",
        Citas_Medicas_idConsulta "ID Cita Medica"
    FROM Diagnosticos
    WHERE idDiagnostico = ID;
  ELSE
    SELECT 'NO EXISTE EL DIAGNOSTICO';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE insertDiagnostico (IN DIAG VARCHAR(50), IN ID_CITA INT)
BEGIN
    START TRANSACTION;
        INSERT INTO Diagnosticos(Diagnostico, Citas_Medicas_idConsulta)
      VALUES( DIAG, ID_CITA);
    IF ROW_COUNT() > 0 THEN
      SELECT 'EL DIAGNOSTICO HA SIDO CREADA CON EXITO', (SELECT MAX(idDiagnostico) FROM Diagnosticos) "Id Diagnostico";
            COMMIT;
    ELSE
      SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL DIAGNOSTICO';
      ROLLBACK;
    END IF;
END //

DELIMITER //
CREATE PROCEDURE updateDiagnostico (IN ID INT, IN DIAG VARCHAR(50), IN ID_CITA INT)
BEGIN
  IF (SELECT EXISTS (SELECT idDiagnostico FROM Diagnosticos WHERE idDiagnostico = ID)) THEN
    START TRANSACTION;
        UPDATE Diagnosticos 
      SET idDiagnostico = ID,
        Diagnostico = DIAG,
        Citas_Medicas_idConsulta = ID_CITA
    WHERE idDiagnostico = ID;
        IF ROW_COUNT() THEN
      SELECT 'EL ID_DIAGNOSTICO HA SIDO ACTUALIZADO';
            COMMIT;
    ELSE
      SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
      ROLLBACK;
    END IF;
  ELSE
    SELECT 'EL DIAGNOSTICO NO EXISTE CON ESE ID';
  END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteDiagnostico (IN ID INT)
BEGIN
  IF (SELECT EXISTS (SELECT idDiagnostico FROM Diagnosticos WHERE idDiagnostico = ID)) THEN
    START TRANSACTION;
        DELETE FROM Diagnosticos WHERE idDiagnostico = ID;
        IF ROW_COUNT() THEN
      SELECT 'EL DIAGNOSTICO FUE ELIMINADA CON EXITO';
            COMMIT;
    ELSE
      SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
    END IF;
  ELSE
    SELECT 'EL DIAGNOSTICO NO EXISTE CON ESE ID';
  END IF;
END //