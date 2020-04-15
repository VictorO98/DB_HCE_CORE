use db_hce_core;

DROP PROCEDURE getPacienteForDNI;

-- CRUD PRIMERA CAPA 

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

-- Calls To Procedure
CALL  getPacienteForDNI(6667978);