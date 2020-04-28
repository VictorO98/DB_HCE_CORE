use db_hce_core;

DROP PROCEDURE IF EXISTS getPacienteForDNI;

DROP PROCEDURE IF EXISTS getAcudienteForDni;

DROP PROCEDURE IF EXISTS getEntidadForId;

DROP PROCEDURE IF EXISTS getHCForId;

DROP PROCEDURE IF EXISTS getAntecedenteForId;

DROP PROCEDURE IF EXISTS getFisiologicaForId;

DROP PROCEDURE IF EXISTS getMedicoForId;

DROP PROCEDURE IF EXISTS getHCForIdPaciente;

DROP PROCEDURE IF EXISTS insertAcudiente;

DROP PROCEDURE IF EXISTS insertPaciente;

DROP PROCEDURE IF EXISTS insertMedico;

DROP PROCEDURE IF EXISTS insertHC;

DROP PROCEDURE IF EXISTS insertEntidad;

DROP PROCEDURE IF EXISTS updateTokenEntidad;

DROP PROCEDURE IF EXISTS updateEntidad;

DROP PROCEDURE IF EXISTS updateMedico;

DROP PROCEDURE IF EXISTS updatePaciente;

DROP PROCEDURE IF EXISTS updateTokenPaciente;

DROP PROCEDURE IF EXISTS updateAcudiente;

DROP PROCEDURE IF EXISTS updateHC;

DROP PROCEDURE IF EXISTS deleteMedico;

DROP PROCEDURE IF EXISTS deleteEntidad;

DROP PROCEDURE IF EXISTS deleteHC;

DROP PROCEDURE IF EXISTS deletePaciente;

DROP PROCEDURE IF EXISTS deleteAcudiente;
-- CRUD PRIMERA CAPA 

-- Capas de get by ID

DELIMITER //
CREATE PROCEDURE getPacienteForDNI (IN ID BIGINT)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Pacientes WHERE DNI = ID)) THEN
		SELECT IdPaciente "Id Paciente" ,nombreCliente "Nombre Paciente", DNI "Identificación",
				fechaNacimiento ,estadoCivil "Estado Civil", telefono "Telefono", sexo "Sexo", token "Token"
		FROM Pacientes
		WHERE DNI = ID;
	ELSE
		SELECT 'NO EXISTE EL PACIENTE';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE getAcudienteForDni (IN ID BIGINT)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Acudientes WHERE DNI = ID)) THEN
		SELECT nombreAcudiente "Nombre Acudiente", DNI "Identificación", fechaNacimiento ,
				telefono "Telefono", sexo "Sexo", idAcudiente "Id Acudiente", Pacientes_idPaciente "Paciente ID"
		FROM Acudientes
		WHERE DNI = ID;
	ELSE
		SELECT 'NO EXISTE EL ACUDIENTE';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE getEntidadForId (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idEntidad FROM Entidad WHERE idEntidad = ID)) THEN
		SELECT idEntidad "Identificación", nombreEntidad "Nombre Entidad", 
				token "Token"
		FROM Entidad
		WHERE idEntidad = ID;
	ELSE
		SELECT 'NO EXISTE LA ENTIDAD';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE getHCForId (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idHistoria FROM Historia_Clinica WHERE idHistoria = ID)) THEN
		SELECT idHistoria "Identificación", Entidad_idEntidad "Id Identidad", 
				Antecedentes_idAntecedente "Id Antecedente", Fisiologica_IdFisiologica "Id Fisiologica",
                Pacientes_IdPaciente "Identifiación Paciente"
		FROM Historia_Clinica
		WHERE idHistoria = ID;
	ELSE
		SELECT 'NO EXISTE LA HISTORIA CLINICA';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE getAntecedenteForId (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idAntecedente FROM Antecedentes WHERE idAntecedente = ID)) THEN
		SELECT idAntecedente "Id Antecedente", accidentes "Accidentes", antecedentesHereditarios "Antecedentes Hereditarios",
				enfermedadesInfancia "Enfermedades Infancia", intervencionesQuirurgicas "Intervencion Quirurgicas",
                alergias "Alergias", inmunizacion "Inmunizacion"
		FROM Antecedentes
		WHERE idAntecedente = ID;
	ELSE
		SELECT 'NO EXISTE EL ANTECEDENTE';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE getFisiologicaForId (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idFisiologica FROM Fisiologica WHERE idFisiologica = ID)) THEN
		SELECT idFisiologica "Id Fisiologica", lactancia "Lactancia", iniciacionSexual "Iniciacion Sexual",
				ginecoObstretico "Gineco Obstretico", menarca "Menarca", embarazos "Embarazos",
                partos "Partos", abortos "Abortos"
		FROM Fisiologica
		WHERE idFisiologica = ID;
	ELSE
		SELECT 'NO EXISTE LA FISIOLOGICA';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE getMedicoForId (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idMedico FROM Medicos WHERE idMedico = ID)) THEN
		SELECT idMedico "Id Medico", nombreMedico "Nombre Medico",
				fechaNacimiento "Fecha Nacimiento", telefono "Telefono"
		FROM Medicos
		WHERE idMedico = ID;
	ELSE
		SELECT 'NO EXISTE EL MEDICO';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE getHCForIdPaciente (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT Pacientes_IdPaciente FROM Historia_Clinica WHERE Pacientes_IdPaciente = ID)) THEN
		SELECT idHistoria "Identificación", Entidad_idEntidad "Id Identidad", 
				Antecedentes_idAntecedente "Id Antecedente", Fisiologica_IdFisiologica "Id Fisiologica",
                Pacientes_IdPaciente "Identifiación Paciente"
		FROM Historia_Clinica
		WHERE Pacientes_IdPaciente = ID;
	ELSE
		SELECT 'NO EXISTE UNA HISTORIA CLINICA ASOCIADA CON ESE ID';
	END IF;
END //
-- Capa de insert o post

DELIMITER //
CREATE PROCEDURE insertAcudiente (IN ID BIGINT, IN NOMBRE VARCHAR(30), IN FECHA DATE, IN TELEFONO BIGINT, IN SEXO VARCHAR(30), IN IDPACIENTE INTEGER)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Acudientes WHERE DNI = ID)) THEN
		SELECT 'EL ACUDIENTE YA EXISTE';
	ELSE
		-- IF (SELECT EXISTS (SELECT idPaciente FROM Pacientes WHERE idPaciente = ))
		START TRANSACTION;
        INSERT INTO Acudientes(DNI, nombreAcudiente, fechaNacimiento, telefono, sexo, Pacientes_IdPaciente)
			VALUES(ID, NOMBRE, FECHA, TELEFONO, SEXO, IDPACIENTE);
		IF ROW_COUNT() > 0 THEN
			SELECT 'EL ACUDIENTE HA SIDO CREADO CON EXITO';
            COMMIT;
        ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL ACUDIENTE';
            ROLLBACK;
        END IF;
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertPaciente (IN ID BIGINT, IN NOMBRE VARCHAR(30), IN FECHA DATE, IN ESTADO_CIVIL VARCHAR(10),IN TELEFONO BIGINT, IN SEXO VARCHAR(30), IN TOKEN VARCHAR(50))
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Pacientes WHERE DNI = ID)) THEN
		SELECT 'EL PACIENTE YA EXISTE';
	ELSE
		START TRANSACTION;
        INSERT INTO Pacientes(DNI, nombreCliente, fechaNacimiento, estadoCivil, telefono, sexo, token)
			VALUES(ID, NOMBRE, FECHA, ESTADO_CIVIL,TELEFONO, SEXO, TOKEN);
		IF ROW_COUNT() > 0 THEN
            SELECT 'EL PACIENTE HA SIDO CREADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL PACIENTE';
            ROLLBACK;
		END IF;
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertMedico (IN ID INT, IN NOMBRE VARCHAR(30), IN FECHA DATE, IN TELEFONO BIGINT)
BEGIN
	IF (SELECT EXISTS (SELECT idMedico FROM Medicos WHERE idMedico = ID)) THEN
		SELECT 'EL MEDICO YA EXISTE';
	ELSE
		START TRANSACTION;
        INSERT INTO Medicos(idMedico, nombreMedico, fechaNacimiento, telefono)
			VALUES(ID, NOMBRE, FECHA,TELEFONO);
		IF ROW_COUNT() > 0 THEN
			SELECT 'EL MEDICO HA SIDO CREADO CON EXITO';
            COMMIT;
        ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL MEDICO';
			ROLLBACK;
        END IF;
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertHC (IN ID INT, IN ID_ENTIDAD INTEGER, IN ID_ANTECEDENTE INTEGER, IN ID_FISIOLOGICA INTEGER, IN ID_PACIENTE INTEGER)
BEGIN
	IF (SELECT EXISTS (SELECT idHistoria FROM Historia_Clinica WHERE idHistoria = ID)) THEN
		SELECT 'LA HISTORIA CLINICA YA EXISTE CON ESE ID';
	ELSE
		START TRANSACTION;
        INSERT INTO Historia_Clinica(idHistoria, Entidad_idEntidad, Antecedentes_idAntecedente, Fisiologica_IdFisiologica, Pacientes_IdPaciente)
			VALUES(ID, ID_ENTIDAD, ID_ANTECEDENTE,ID_FISIOLOGICA, ID_PACIENTE);
		IF ROW_COUNT() > 0 THEN
			SELECT 'LA HISTORIA CLINICA HA SIDO CREADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DE LA HISTORIA CLINICA';
			ROLLBACK;
		END IF;
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertEntidad (IN ID_ENTIDAD INT, IN NOMBRE_ENTIDAD VARCHAR(25), IN TOKEN VARCHAR(50))
BEGIN
	IF (SELECT EXISTS (SELECT idEntidad FROM Entidad WHERE idEntidad = ID_ENTIDAD)) THEN
		SELECT 'LA ENTIDAD YA EXISTE CON ESE ID';
	ELSE
		START TRANSACTION;
        INSERT INTO Entidad(idEntidad, nombreEntidad, token)
			VALUES(ID_ENTIDAD, NOMBRE_ENTIDAD, TOKEN);
		IF ROW_COUNT() > 0 THEN
			SELECT 'LA ENTIDAD HA SIDO CREADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DE LA ENTIDAD';
			ROLLBACK;
		END IF;
	END IF;
END //

-- Capa de update

DELIMITER //
CREATE PROCEDURE updateEntidad (IN ID INT, IN NOMBRE_ENTIDAD VARCHAR(25), IN TOKEN VARCHAR(50))
BEGIN
	IF (SELECT EXISTS (SELECT idEntidad FROM Entidad WHERE idEntidad = ID)) THEN
		START TRANSACTION;
        UPDATE Entidad 
			SET idEntidad = ID,
				nombreEntidad = NOMBRE_ENTIDAD,
				token = TOKEN 
		WHERE idEntidad = ID;
        IF ROW_COUNT() THEN
			SELECT 'LA ENTIDAD HA SIDO ACTUALIZADA';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'LA ENTIDAD NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE updateTokenEntidad(IN ID INT, IN TOKEN VARCHAR(50))
BEGIN
	IF (SELECT EXISTS (SELECT idEntidad FROM Entidad WHERE idEntidad = ID)) THEN
		START TRANSACTION;
        UPDATE Entidad SET token = TOKEN WHERE idEntidad = ID;
        IF ROW_COUNT() THEN
			SELECT 'LA ENTIDAD HA SIDO ACTUALIZADA';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'LA ENTIDAD NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE updateMedico (IN ID INT, IN NOMBRE VARCHAR(25), IN FECHA DATE, IN TELEFONO BIGINT)
BEGIN
	IF (SELECT EXISTS (SELECT idMedico FROM Medicos WHERE idMedico = ID)) THEN
		START TRANSACTION;
        UPDATE Medicos 
			SET idMedico = ID,
				nombreMedico = NOMBRE,
				fechaNacimiento = FECHA,
                telefono = TELEFONO
		WHERE idMedico = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL MEDICO HA SIDO ACTUALIZADA';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL MEDICO NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE updatePaciente (IN ID_IN BIGINT, IN ID_CHANGE BIGINT, IN NOMBRE VARCHAR(30), IN FECHA DATE, IN ESTADO_CIVIL VARCHAR(10),IN TELEFONO BIGINT, IN SEXO VARCHAR(30), IN TOKEN VARCHAR(50))
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Pacientes WHERE DNI = ID_IN)) THEN
		START TRANSACTION;
        UPDATE Pacientes 
			SET DNI = ID_CHANGE,
				nombreCliente = NOMBRE,
				fechaNacimiento = FECHA,
                estadoCivil = ESTADO_CIVIL,
                telefono = TELEFONO,
                sexo = SEXO,
                token = TOKEN
		WHERE DNI = ID_IN;
        IF ROW_COUNT() THEN
			SELECT 'EL PACIENTE HA SIDO ACTUALIZADA';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL PACIENTE NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE updateTokenPaciente(IN ID BIGINT, IN TOKEN VARCHAR(50))
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Pacientes WHERE DNI = ID)) THEN
		START TRANSACTION;
        UPDATE Pacientes SET token = TOKEN WHERE DNI = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL PACIENTE HA SIDO ACTUALIZADA';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL PACIENTE NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE updateAcudiente (IN ID BIGINT, IN NOMBRE VARCHAR(30), IN FECHA DATE, IN TELEFONO BIGINT, IN SEXO VARCHAR(30), IN IDPACIENTE INTEGER)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Acudientes WHERE DNI = ID)) THEN
		START TRANSACTION;
        UPDATE Acudientes 
			SET DNI = ID, 
                nombreAcudiente = NOMBRE, 
                fechaNacimiento = FECHA, 
                telefono = TELEFONO, 
                sexo = SEXO, 
                Pacientes_IdPaciente = IDPACIENTE
		WHERE DNI = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL ACUDIENTE HA SIDO ACTUALIZADO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL ACUDIENTE NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE updateHC (IN ID INT, IN ID_ENTIDAD INTEGER, IN ID_ANTECEDENTE INTEGER, IN ID_FISIOLOGICA INTEGER, IN ID_PACIENTE INTEGER)
BEGIN
	IF (SELECT EXISTS (SELECT idHistoria FROM Historia_Clinica WHERE idHistoria = ID)) THEN
		START TRANSACTION;
        UPDATE Acudientes 
			SET idHistoria = ID, 
				Entidad_idEntidad = ID_ENTIDAD, 
                Antecedentes_idAntecedente = ID_ANTECEDENTE, 
                Fisiologica_IdFisiologica = ID_FISIOLOGICA, 
                Pacientes_IdPaciente = ID_PACIENTE
		WHERE idHistoria = ID;
        IF ROW_COUNT() THEN
			SELECT 'LA HISTORIA CLINICA HA SIDO ACTUALIZADA';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'LA HISTORIA CLINICA NO EXISTE CON ESE ID';
	END IF;
END //

-- CAPA DE DELETE

DELIMITER //
CREATE PROCEDURE deleteMedico (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idMedico FROM Medicos WHERE idMedico = ID)) THEN
		START TRANSACTION;
        DELETE FROM Medicos WHERE idMedico = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL MEDICO FUE ELIMINADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL MEDICO NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteEntidad (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idEntidad FROM Entidad WHERE idEntidad = ID)) THEN
		START TRANSACTION;
        DELETE FROM Entidad WHERE idEntidad = ID;
        IF ROW_COUNT() THEN
			SELECT 'LA ENTIDAD FUE ELIMINADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'LA ENTIDAD NO EXISTE CON ESE ID';
	END IF;
END //

CREATE PROCEDURE deleteHC (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idHistoria FROM Historia_Clinica WHERE idHistoria = ID)) THEN
		START TRANSACTION;
        DELETE FROM Historia_Clinica WHERE idHistoria = ID;
        IF ROW_COUNT() THEN
			SELECT 'LA HISTORIA CLINICA FUE ELIMINADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'LA HISTORIA CLINICA NO EXISTE CON ESE ID';
	END IF;
END //

CREATE PROCEDURE deletePaciente (IN ID BIGINT)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Pacientes WHERE DNI = ID)) THEN
		START TRANSACTION;
        DELETE FROM Pacientes WHERE DNI = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL PACIENTE FUE ELIMINADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL PACIENTE NO EXISTE CON ESE ID';
	END IF;
END //

CREATE PROCEDURE deleteAcudiente (IN ID BIGINT)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Acudientes WHERE DNI = ID)) THEN
		START TRANSACTION;
        DELETE FROM Acudientes WHERE DNI = ID;
        IF ROW_COUNT() THEN
			SELECT 'EL ACUDIENTE FUE ELIMINADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL ACUDIENTE NO EXISTE CON ESE ID';
	END IF;
END //

-- Calls To Procedure
-- CALL insertPaciente(1144100868, "VICTOR", '1998-02-28','VIUDO',3024896157,'masculino','ey1eu9');
-- CALL insertPaciente(1144105896, "JUAN", '1998-02-18','MORTAL',2657891345,'masculino','ejhhbfau');
-- CALL getPacienteForDni(1144100868);
-- CALL getPacienteForDni(1144105896);
-- CALL updatePaciente(1144100585, 1144100868,"VICTOR", '1998-02-28','VIUDO',6565165165,'masculino','ey1eu9');
-- CALL updateTokenPaciente(1144100868,'adsads');
-- CALL deletePaciente(1144100868);

-- CALL insertAcudiente(16802551, 'MANUEL' , '1972-08-30', 3022405655, 'MASCULINO', 1);
-- CALL insertAcudiente(66678978, 'LIANA' , '1972-06-30', 3022405635, 'FEMENINO', 1);
-- CALL getAcudienteForDni(16802551);
-- CALL getAcudienteForDni(66678978);
-- CALL updateAcudiente(66678978,'MANUEL' , '1972-08-30', 4567298137, 'MASCULINO', 1);

/*
CALL insertACudiente(null, 61565465, 'Gertrudiz', '1998-02-02',1234567894,'Femenino',1);
CALL insertEntidad();
CALL insertHC();
CALL insertMedico();
;



*/