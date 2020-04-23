use db_hce_core;

DROP PROCEDURE IF EXISTS getPacienteForDNI;

DROP PROCEDURE IF EXISTS getAcudienteForDni;

DROP PROCEDURE IF EXISTS getEntidadForId;

DROP PROCEDURE IF EXISTS getHCForId;

DROP PROCEDURE IF EXISTS getAntecedenteForId;

DROP PROCEDURE IF EXISTS getFisiologicaForId;

DROP PROCEDURE IF EXISTS getMedicoForId;

DROP PROCEDURE IF EXISTS insertAcudiente;

DROP PROCEDURE IF EXISTS insertPaciente;

-- CRUD PRIMERA CAPA 

-- Capas de get by ID

DELIMITER //
CREATE PROCEDURE getPacienteForDNI (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Pacientes WHERE DNI = ID)) THEN
		SELECT 'EXISTE';
		SELECT IdPaciente "Id Paciente" ,nombreCliente "Nombre Paciente", DNI "Identificación",
				fechaNacimiento ,estadoCivil "Estado Civil", telefono "Telefono", sexo "Sexo"
		FROM Pacientes
		WHERE DNI = ID;
	ELSE
		SELECT 'NO EXISTE EL PACIENTE';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE getAcudienteForDni (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Acudientes WHERE DNI = ID)) THEN
		SELECT 'EXISTE';
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
		SELECT 'EXISTE';
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
		SELECT 'EXISTE';
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
		SELECT 'EXISTE';
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
		SELECT 'EXISTE';
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
		SELECT 'EXISTE';
		SELECT idMedico "Id Medico", nombreMedico "Nombre Medico",
				fechaNacimiento "Fecha Nacimiento", telefono "Telefono"
		FROM Medicos
		WHERE idMedico = ID;
	ELSE
		SELECT 'NO EXISTE EL MEDICO';
	END IF;
END //

-- Capa de insert o post

DELIMITER //
CREATE PROCEDURE insertAcudiente (IN ID INT, IN NOMBRE VARCHAR(30), IN FECHA DATE, IN TELEFONO INTEGER, IN SEXO VARCHAR(30), IN IDPACIENTE INTEGER)
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Acudientes WHERE DNI = ID)) THEN
		SELECT 'EL ACUDIENTE YA EXISTE';
	ELSE
		SELECT 'EL ACUDIENTE HA SIDO CREADO CON EXITO';
        INSERT INTO Acudientes(DNI, nombreAcudiente, fechaNacimiento, telefono, sexo, Pacientes_IdPaciente)
			VALUES(ID, NOMBRE, FECHA, TELEFONO, SEXO, IDPACIENTE);
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertPaciente (IN ID INT, IN NOMBRE VARCHAR(30), IN FECHA DATE, IN ESTADO_CIVIL VARCHAR(10),IN TELEFONO INTEGER, IN SEXO VARCHAR(30), IN TOKEN VARCHAR(50))
BEGIN
	IF (SELECT EXISTS (SELECT DNI FROM Pacientes WHERE DNI = ID)) THEN
		SELECT 'EL PACIENTE YA EXISTE';
	ELSE
		SELECT 'EL PACIENTE HA SIDO CREADO CON EXITO';
        INSERT INTO Pacientes(DNI, nombreCliente, fechaNacimiento, estadoCivil, telefono, sexo, token)
			VALUES(ID, NOMBRE, FECHA, ESTADO_CIVIL,TELEFONO, SEXO, TOKEN);
	END IF;
END //

-- Calls To Procedure
