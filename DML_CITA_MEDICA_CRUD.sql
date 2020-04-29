use db_hce_core;

SET autocommit = 0;

-- DIAGNOSTICOS

-- CITA MEDICA

DELIMITER //
CREATE PROCEDURE get_Citas_Medicas_ForId (IN ID INT)
BEGIN
	IF (SELECT EXISTS (SELECT idConsulta FROM Citas_Medicas WHERE idConsulta = ID)) THEN
		SELECT idConsulta "Id Consulta", fecha "Fecha",motivo "Motivo", epsAgenda "agenda", Medicos_idMedicos "Medicos_Idmedicos",
				Examen_Fisico_idExamen "Examen_Fisico_idExamen", Historia_Clinica_idHistoria "Historia_Clinica_idHistoria"
		FROM Citas_Medicas
		WHERE idConsulta = ID;
	ELSE
		SELECT 'NO EXISTE LA CITA MEDICA';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertCitas_Medicas (IN ID INT, IN FECHA TIMESTAMP,IN MOTIVO VARCHAR(50), IN EPSAGENDA INT,IN MEDICOS_IDMEDICOS INT,
								 IN EXAMEN_FISICO_IDEXAMEN INT,IN HISTORIA_CLINICA_IDHISTORIA INT)
BEGIN
	IF (SELECT EXISTS (SELECT idConsulta FROM Citas_Medicas WHERE idConsulta = ID)) THEN
		SELECT 'LA CITA MEDICA YA EXISTE CON ESE ID';
	ELSE
		START TRANSACTION;
        INSERT INTO Citas_Medicas(idConsulta, fecha ,motivo , epsAgenda , Medicos_idMedicos ,Examen_Fisico_idExamen ,Historia_Clinica_idHistoria )
			VALUES( ID ,  FECHA , MOTIVO , EPSAGENDA , MEDICOS_IDMEDICOS ,
					 EXAMEN_FISICO_IDEXAMEN , HISTORIA_CLINICA_IDHISTORIA );
		IF ROW_COUNT() > 0 THEN
			SELECT 'LA CITA MEDICA HA SIDO CREADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DE LA CITA MEDICA';
			ROLLBACK;
		END IF;
	END IF;
END //

DELIMITER //
CREATE PROCEDURE updateCitas_Medicas(IN ID INT, IN FECHA TIMESTAMP,IN MOTIVO VARCHAR(50), IN EPSAGENDA INT,IN MEDICOS_IDMEDICOS INT,
								 IN EXAMEN_FISICO_IDEXAMEN INT,IN HISTORIA_CLINICA_IDHISTORIA INT)
BEGIN
	IF (SELECT EXISTS (SELECT idConsulta FROM Citas_Medicas WHERE idConsulta = ID)) THEN
		START TRANSACTION;
        UPDATE Citas_Medicas 
			SET idConsulta = ID,
				fecha = FECHA,
				motivo= MOTIVO , 
				epsAgenda=EPSAGENDA , 
				Medicos_idMedicos=MEDICOS_IDMEDICOS ,
				Examen_Fisico_idExamen= EXAMEN_FISICO_IDEXAMEN ,
				Historia_Clinica_idHistoria= HISTORIA_CLINICA_IDHISTORIA
		WHERE idConsulta = ID;
        IF ROW_COUNT() THEN
			SELECT 'LA CITA MEDICA HA SIDO ACTUALIZADA';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'LA CITA MEDICA NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteCitas_Medicas (IN ID INT)
BEGIN
	IF (SELECT  EXISTS (SELECT idConsulta FROM Citas_Medicas WHERE idConsulta = ID))  THEN
		START TRANSACTION;
        DELETE FROM Citas_Medicas WHERE idConsulta = ID;
        IF ROW_COUNT() THEN
			SELECT 'LA CITA MEDICA FUE ELIMINADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'LA CITA MEDICA NO EXISTE CON ESE ID';
	END IF;
END //
DELIMITER //

-- TIPO EXAMEN

-- EXAMEN















CREATE PROCEDURE get_Examen_Fisico_ForId (IN IDEXAMEN INT)
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM Examen_Fisico WHERE idExamen = IDEXAMEN)) THEN
		SELECT idExamen " idExamen", estadoConciencia "estado Conciencia", lenguaje "lenguaje", auditivo "auditivo",agudezaVisual " agudeza Visual",
				 peso " peso",  estatura "estatura", facie "facie", edadRealAparente "edadReal Aparente" ,temperatura "temperatura", actitud "actitud"
		FROM Examen_Fisico
		WHERE idExamen = IDEXAMEN;
	ELSE
		SELECT 'NO EXISTE EL EXAMEN FISICO CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertExamen_Fisico (IN IDEXAMEN INT, IN ESTADOCONCIENCIA VARCHAR(25), IN LENGUAJE VARCHAR(25), IN AUDITIVO VARCHAR(25), IN AGUDEZAVISUAL VARCHAR(25), 
								IN PESO FLOAT(10), IN ESTATURA FLOAT(10), IN FACIE VARCHAR(25),IN  EDADREALAPATENTE VARCHAR(25), IN TEMPERATURA FLOAT(10),IN  ACTITUD VARCHAR(25))
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM Examen_Fisico WHERE idExamen = IDEXAMEN)) THEN
		SELECT 'EL EXAMEN MEDICO YA EXISTE CON ESE ID';
	ELSE
		START TRANSACTION;
        INSERT INTO Examen_Fisico(idExamen, estadoConciencia,  lenguaje,  auditivo, agudezaVisual, peso, estatura,
        			 facie, edadRealAparente, temperatura, actitud)
			VALUES(IDEXAMEN, ESTADOCONCIENCIA, LENGUAJE, AUDITIVO, AGUDEZAVISUAL, PESO, ESTATURA ,FACIE, EDADREALAPATENTE, TEMPERATURA, ACTITUD);
		IF ROW_COUNT() > 0 THEN
			SELECT 'EL EXAMEN MEDICO HA SIDO CREADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL EXAMEN MEDICO';
			ROLLBACK;
		END IF;
	END IF;
END //

DELIMITER //




CREATE PROCEDURE updateExamen_Fisico(IN IDEXAMEN INT, IN ESTADOCONCIENCIA VARCHAR(25), IN LENGUAJE VARCHAR(25), IN AUDITIVO VARCHAR(25), IN AGUDEZAVISUAL VARCHAR(25), 
								IN PESO FLOAT(10), IN ESTATURA FLOAT(10), IN FACIE VARCHAR(25),IN  EDADREALAPATENTE VARCHAR(25), IN TEMPERATURA FLOAT(10),IN  ACTITUD VARCHAR(25))
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM Examen_Fisico WHERE idExamen = IDEXAMEN)) THEN 
		START TRANSACTION;
        UPDATE Examen_Fisico 
			SET idExamen = IDEXAMEN ,
			estadoConciencia = ESTADOCONCIENCIA , 
			lenguaje= LENGUAJE ,
			auditivo= AUDITIVO ,
			agudezaVisual= AGUDEZAVISUAL ,
			peso= PESO ,
			estatura= ESTATURA ,
			facie= FACIE ,
			edadRealAparente=  EDADREALAPATENTE ,
			temperatura= TEMPERATURA ,
			actitud=  ACTITUD
		WHERE idExamen = IDEXAMEN;
        IF ROW_COUNT() THEN
			SELECT 'EL EXAMEN MEDICO HA SIDO ACTUALIZADO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL EXAMEN MEDICO NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteExamen_Fisico (IN IDEXAMEN INT)
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM Examen_Fisico WHERE idExamen = IDEXAMEN)) THEN
		START TRANSACTION;
        DELETE FROM Examen_Fisico WHERE idExamen = IDEXAMEN;
        IF ROW_COUNT() THEN
			SELECT 'EL EXAMEN FUE ELIMINADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'LEL EXAMEN NO EXISTE CON ESE ID';
	END IF;
END //


DELIMITER //












CREATE PROCEDURE get_Habito_ForId (IN IDHABITO INT)
BEGIN
	IF (SELECT EXISTS (SELECT idHabito FROM Habitos WHERE idHabito = IDHABITO)) THEN
		SELECT idHabito " idHabito", alimentacion "alimentacion", sed "sed", diuresis "diuresis",catarsisintestinal " catarsis intestinal",
			   sueno " sueno",  relacionesSexuales "relaciones Sexuales", alcohol "alcohol", tabaco "tabaco" ,drogas "drogas", medicacion "medicacion"
		FROM Habitos
		WHERE idHabito = IDHABITO;
	ELSE
		SELECT 'NO EXISTE EL HABITO  CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE insertHabito (IN IDHABITO INT,IN ALIMENTACION VARCHAR(25),IN APETITO VARCHAR(25), IN SED VARCHAR(25), IN DIURESIS VARCHAR(25),
						 IN CATARSISINTESTINAL VARCHAR(25), IN SUENO VARCHAR(25), IN RELACIONESSEXUALES VARCHAR(25), IN ALCOHOL VARCHAR(25), IN TABACO VARCHAR(25),
						  IN DROGAS VARCHAR(25), IN MEDICACION VARCHAR(25))
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM Habitos WHERE idExamen = IDHABITO) THEN
		SELECT 'EL EXAMEN  YA EXISTE CON ESE ID';
	ELSE
		START TRANSACTION;
        INSERT INTO Habitos(idHabito, alimentacion, apetito, sed, diuresis, catarsisintestinal, sueno, relacionesSexuales,
        			 alcohol, tabaco, drogas, medicacion)
			VALUES(IDHABITO, ALIMENTACION, APETITO, SED, DIURESIS, CATARSISINTESTINAL, SUENO, RELACIONESSEXUALES,
					ALCOHOL, TABACO, DROGAS, MEDICACION);
		IF ROW_COUNT() > 0 THEN
			SELECT 'EL HABITO   HA SIDO CREADA CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL HABITO  ';
			ROLLBACK;
		END IF;
	END IF;
END //

DELIMITER //

CREATE PROCEDURE updateHabito(IN IDHABITO INT,IN ALIMENTACION VARCHAR(25),IN APETITO VARCHAR(25), IN SED VARCHAR(25), IN  DIURESIS VARCHAR(25),
						 IN CATARSISINTESTINAL VARCHAR(25), IN SUENO VARCHAR(25), IN RELACIONESSEXUALES VARCHAR(25), IN ALCOHOL VARCHAR(25), IN TABACO VARCHAR(25),
						  IN DROGAS VARCHAR(25), IN MEDICACION VARCHAR(25))
BEGIN
	IF (SELECT EXISTS (SELECT idHabito FROM Habitos WHERE idHabito = IDHABITO) THEN THEN
		START TRANSACTION;
        UPDATE Habitos 
			SET idHabito = IDHABITO ,
			alimentacion = ALIMENTACION , 
			apetito= APETITO ,
			sed= SED ,
			diuresis = DIURESIS,
			catarsisintestinal= CATARSISINTESTINAL ,
			sueno= SUENO ,
			relacionesSexuales= RELACIONESSEXUALES ,
			alcohol= ALCOHOL ,
			tabaco=  TABACO ,
			drogas= DROGAS ,
			medicacion=  MEDICACION
		WHERE idHabito = IDHABITO;
        IF ROW_COUNT() THEN
			SELECT 'EL HABITO  HA SIDO ACTUALIZADO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL HABITO  NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteHabito (IN IDHABITO INT)
BEGIN
	IF (SELECT EXISTS (SELECT idHabito FROM Habitos WHERE idHabito = IDHABITO) ) THEN
		START TRANSACTION;
        DELETE FROM Habitos WHERE idHabito = IDHABITO;
        IF ROW_COUNT() THEN
			SELECT 'EL HABITO  FUE ELIMINADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL HABITO  NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //













CREATE PROCEDURE get_ExamenSegmentario_ForId (IN IDEXAMEN INT)
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM ExamenSegmentario WHERE idExamen = IDEXAMEN)) THEN
		SELECT idExamen " idExamen", cabeza "cabeza", cuello"cuello",torax "torax", AparatoCirculatorio "Aparato Circulatorio",
				AparatoRespiratorio " Aparato Respiratorio",  Abdomen " Abdomen",  AparatoUrogenital "Aparato Urogenital", 
				SistemaNervioso "Sistema Nervioso", psicologicoMental "psicologico Mental" ,perine "perine",
				examenGenital "examen Genital ", miembrosSuperioes "miembros Superioes", miembrosSuperioes "miembros Superioes"  

		FROM ExamenSegmentario
		WHERE idExamen = IDEXAMEN;
	ELSE
		SELECT 'NO EXISTE EL EXAMEN SEGMENTARIO  CON ESE ID';
	END IF;
END //


DELIMITER //
CREATE PROCEDURE insertExamenSegmentario (IN IDEXAMEN INT,IN CABEZA VARCHAR(25),IN CUELLO VARCHAR(25), IN TORAX VARCHAR(25), IN APARATOCIRCULATORIO VARCHAR(25),
	 					IN APARATORESPIRATORIO VARCHAR(25), IN ABDOMEN VARCHAR(25),	 
	 					IN APARATOUROGENITAL VARCHAR(25), IN SISTEMANERVIOSO VARCHAR(25), IN PSICOLOGICOMENTAL VARCHAR(25), IN PERINE VARCHAR(25),
						  IN EXAMENGENITAL VARCHAR(25), IN MIEMBROSSUPERIOES VARCHAR(25), IN MIEMBROSINFERIORES VARCHAR(25))
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM ExamenSegmentario WHERE idExamen = IDEXAMEN) THEN
		SELECT 'EL EXAMEN SEGMENTARIO  YA EXISTE CON ESE ID';
	ELSE
		START TRANSACTION;
        INSERT INTO ExamenSegmentario(idExamen,  cabeza,  cuello, torax,  AparatoCirculatorio,  AparatoRespiratorio,  Abdomen, 
       				 AparatoUrogenital,  SistemaNervioso,  psicologicoMental,  perine,  examenGenital, miembrosSuperioes, 
       				  miembrosInferiores
)
			VALUES(IDEXAMEN,  CABEZA,  CUELLO, TORAX,  APARATOCIRCULATORIO,  APARATORESPIRATORIO,  ABDOMEN, 
					 APARATOUROGENITAL,  SISTEMANERVIOSO,  PSICOLOGICOMENTAL,  PERINE,  EXAMENGENITAL, 
					 MIEMBROSSUPERIOES,  MIEMBROSINFERIORES
);
		IF ROW_COUNT() > 0 THEN
			SELECT 'EL EXAMEN SEGMENTARIO   HA SIDO CREADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA CREACIÓN DEL EXAMEN SEGMENTARIO  ';
			ROLLBACK;
		END IF;
	END IF;
END //

DELIMITER //


CREATE PROCEDURE updateExamenSegmentario(IN IDEXAMEN INT,IN CABEZA VARCHAR(25),IN CUELLO VARCHAR(25), IN TORAX VARCHAR(25), IN APARATOCIRCULATORIO VARCHAR(25),
	 					IN APARATORESPIRATORIO VARCHAR(25), IN ABDOMEN VARCHAR(25),	 
	 					IN APARATOUROGENITAL VARCHAR(25), IN SISTEMANERVIOSO VARCHAR(25), IN PSICOLOGICOMENTAL VARCHAR(25), IN PERINE VARCHAR(25),
						  IN EXAMENGENITAL VARCHAR(25), IN MIEMBROSSUPERIOES VARCHAR(25), IN MIEMBROSINFERIORES VARCHAR(25))
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM ExamenSegmentario WHERE idExamen = IDEXAMEN) THEN THEN
		START TRANSACTION;
        UPDATE ExamenSegmentario 
			SET idExamen = IDEXAMEN ,
			cabeza = CABEZA , 
			cuello= CUELLO ,
			torax= TORAX ,
			AparatoCirculatorio = APARATOCIRCULATORIO,
			AparatoRespiratorio= APARATORESPIRATORIO ,
			Abdomen= ABDOMEN ,
			AparatoUrogenital= APARATOUROGENITAL ,
			SistemaNervioso= SISTEMANERVIOSO ,
			psicologicoMental=  PSICOLOGICOMENTAL ,
			perine= PERINE ,
			examenGenital=  EXAMENGENITAL
			miembrosSuperioes= MIEMBROSSUPERIOES ,
			miembrosInferiores= MIEMBROSINFERIORES

		WHERE idExamen = IDEXAMEN;
        IF ROW_COUNT() THEN
			SELECT 'EL EXAMEN SEGMENTARIO  HA SIDO ACTUALIZADO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS EN LA ACTUALIZACION DE DATOS';
			ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL EXAMEN SEGMENTARIO  NO EXISTE CON ESE ID';
	END IF;
END //

DELIMITER //
CREATE PROCEDURE deleteExamenSegmentario (IN IDEXAMEN INT)
BEGIN
	IF (SELECT EXISTS (SELECT idExamen FROM ExamenSegmentario WHERE idExamen = IDEXAMEN) ) THEN
		START TRANSACTION;
        DELETE FROM ExamenSegmentario WHERE idExamen = IDEXAMEN;
        IF ROW_COUNT() THEN
			SELECT 'EL EXAMEN SEGMENTARIO  FUE ELIMINADO CON EXITO';
            COMMIT;
		ELSE
			SELECT 'HUBO PROBLEMAS AL BORRAR LOS DATOS';
            ROLLBACK;
		END IF;
	ELSE
		SELECT 'EL EXAMEN SEGMENTARIO  NO EXISTE CON ESE ID';
	END IF;
END //
