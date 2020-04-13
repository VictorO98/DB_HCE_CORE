show databases;

use db_hce_core;

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-04-13 20:55:18.296

-- DROPS

DROP TABLE acudientes CASCADE;
DROP TABLE Antecedentes CASCADE;
DROP TABLE Citas_Medicas CASCADE;
DROP TABLE DiagXTrata CASCADE;
DROP TABLE Diagnosticos CASCADE;
DROP TABLE Entidad CASCADE;
DROP TABLE ExamenSegmentario CASCADE;
DROP TABLE Examen_Fisico CASCADE;
DROP TABLE Examenes CASCADE;
DROP TABLE Fisiologica CASCADE;
DROP TABLE Habitos CASCADE;
DROP TABLE Historia_Clinica CASCADE;
DROP TABLE MedXTrata CASCADE;
DROP TABLE Medicamentos CASCADE;
DROP TABLE Medicos CASCADE;
DROP TABLE Pacientes CASCADE;
DROP TABLE TipoExamen CASCADE;
DROP TABLE Tratamientos CASCADE;

-- tables
-- Table: Acudientes
CREATE TABLE Acudientes (
    DNI integer NOT NULL,
    nombreAcudiente varchar(15) NOT NULL,
    fechaNacimiento date NOT NULL,
    telefono integer NOT NULL,
    sexo varchar(15) NOT NULL,
    Pacientes_IdPaciente integer NOT NULL,
    CONSTRAINT Acudientes_pk PRIMARY KEY (DNI)
);

-- Table: Antecedentes
CREATE TABLE Antecedentes (
    idAntecedente integer NOT NULL,
    accidentes varchar(25) NOT NULL,
    antecedentesHereditarios varchar(25) NOT NULL,
    enfermedadesInfancia varchar(25) NOT NULL,
    intervencionesQuirurgicas varchar(25) NOT NULL,
    alergias varchar(25) NOT NULL,
    inmunizacion varchar(25) NOT NULL,
    CONSTRAINT Antecedentes_pk PRIMARY KEY (idAntecedente)
);

-- Table: Citas_Medicas
CREATE TABLE Citas_Medicas (
    idConsulta integer NOT NULL,
    fecha timestamp NOT NULL,
    motivo varchar(50) NOT NULL,
    epsAgenda integer NOT NULL,
    Medicos_idMedico integer NOT NULL,
    Examen_Fisico_idExamen integer NOT NULL,
    Habitos_idHabito integer NOT NULL,
    ExSegmentario_idExamen integer NOT NULL,
    Historia_Clinica_idHistoria integer NOT NULL,
    CONSTRAINT Citas_Medicas_pk PRIMARY KEY (idConsulta)
);

-- Table: DiagXTrata
CREATE TABLE DiagXTrata (
    Id integer NOT NULL,
    Diagnosticos_idDiagnostico integer NOT NULL,
    Tratamientos_idTratamiento integer NOT NULL,
    CONSTRAINT DiagXTrata_pk PRIMARY KEY (Id)
);

-- Table: Diagnosticos
CREATE TABLE Diagnosticos (
    idDiagnostico integer NOT NULL,
    Diagnostico varchar(50) NOT NULL,
    Citas_Medicas_idConsulta integer NOT NULL,
    CONSTRAINT Diagnosticos_pk PRIMARY KEY (idDiagnostico)
);

-- Table: Entidad
CREATE TABLE Entidad (
    idEntidad integer NOT NULL,
    nombreEntidad varchar(25) NOT NULL,
    token varchar(50) NOT NULL,
    CONSTRAINT Entidad_pk PRIMARY KEY (idEntidad)
);

-- Table: ExamenSegmentario
CREATE TABLE ExamenSegmentario (
    idExamen integer NOT NULL,
    cabeza varchar(25) NOT NULL,
    cuello varchar(25) NOT NULL,
    torax varchar(25) NOT NULL,
    AparatoCirculatorio varchar(25) NOT NULL,
    AparatoRespiratorio varchar(25) NOT NULL,
    Abdomen varchar(25) NOT NULL,
    AparatoUrogenital varchar(25) NOT NULL,
    SistemaNervioso varchar(25) NOT NULL,
    psicologicoMental varchar(25) NOT NULL,
    perine varchar(25) NOT NULL,
    examenGenital varchar(25) NOT NULL,
    miembrosSuperiores varchar(25) NOT NULL,
    miembrosInferiores varchar(25) NOT NULL,
    CONSTRAINT ExamenSegmentario_pk PRIMARY KEY (idExamen)
);

-- Table: Examen_Fisico
CREATE TABLE Examen_Fisico (
    idExamen integer NOT NULL,
    estadoConciencia varchar(25) NOT NULL,
    lenguaje varchar(25) NOT NULL,
    auditivo varchar(25) NOT NULL,
    agudezaVisual varchar(25) NOT NULL,
    peso float(5,2) NOT NULL,
    estatura float(5,2) NOT NULL,
    facie varchar(25) NOT NULL,
    edadRealAparente varchar(25) NOT NULL,
    temperatura float(5,2) NOT NULL,
    actitud varchar(25) NOT NULL,
    CONSTRAINT Examen_Fisico_pk PRIMARY KEY (idExamen)
);

-- Table: Examenes
CREATE TABLE Examenes (
    idExamen integer NOT NULL,
    resumen varchar(30) NOT NULL,
    resultados varchar(30) NOT NULL,
    anexos varchar(30) NOT NULL,
    TipoExamen_idTipoExamen integer NOT NULL,
    Diagnosticos_idDiagnostico integer NOT NULL,
    CONSTRAINT Examenes_pk PRIMARY KEY (idExamen)
);

-- Table: Fisiologica
CREATE TABLE Fisiologica (
    IdFisiologica integer NOT NULL,
    lactancia varchar(25) NOT NULL,
    iniciacionSexual varchar(25) NOT NULL,
    ginecoObstretico varchar(25) NOT NULL,
    menarca varchar(25) NOT NULL,
    embarazos varchar(25) NOT NULL,
    partos varchar(25) NOT NULL,
    abortos varchar(25) NOT NULL,
    CONSTRAINT Fisiologica_pk PRIMARY KEY (IdFisiologica)
);

-- Table: Habitos
CREATE TABLE Habitos (
    idHabito integer NOT NULL,
    alimentacion varchar(25) NOT NULL,
    apetito varchar(25) NOT NULL,
    sed varchar(25) NOT NULL,
    diuresis varchar(25) NOT NULL,
    catarsisIntestinal varchar(25) NOT NULL,
    sueno varchar(25) NOT NULL,
    relacionesSexuales varchar(25) NOT NULL,
    alcohol varchar(25) NOT NULL,
    tabaco varchar(25) NOT NULL,
    drogas varchar(25) NOT NULL,
    medicacion varchar(25) NOT NULL,
    CONSTRAINT Habitos_pk PRIMARY KEY (idHabito)
);

-- Table: Historia_Clinica
CREATE TABLE Historia_Clinica (
    idHistoria integer NOT NULL,
    Entidad_idEntidad integer NOT NULL,
    Antecedentes_idAntecedente integer NOT NULL,
    Fisiologica_IdFisiologica integer NOT NULL,
    Pacientes_IdPaciente integer NOT NULL,
    CONSTRAINT Historia_Clinica_pk PRIMARY KEY (idHistoria)
);

-- Table: MedXTrata
CREATE TABLE MedXTrata (
    id integer NOT NULL,
    Medicamentos_idMedicamento integer NOT NULL,
    Tratamientos_idTratamiento integer NOT NULL,
    RepeticionMed varchar(30) NOT NULL,
    CONSTRAINT MedXTrata_pk PRIMARY KEY (id)
);

-- Table: Medicamentos
CREATE TABLE Medicamentos (
    idMedicamento integer NOT NULL,
    nombreMedicamento varchar(20) NOT NULL,
    gramaje float(10,2) NOT NULL,
    CONSTRAINT Medicamentos_pk PRIMARY KEY (idMedicamento)
);

-- Table: Medicos
CREATE TABLE Medicos (
    idMedico integer NOT NULL,
    nombreMedico varchar(25) NOT NULL,
    fechaNacimiento date NOT NULL,
    telefono integer NOT NULL,
    CONSTRAINT Medicos_pk PRIMARY KEY (idMedico)
);

-- Table: Pacientes
CREATE TABLE Pacientes (
    DNI integer NOT NULL,
    nombreCliente varchar(25) NOT NULL,
    fechaNacimiento date NOT NULL,
    estadoCivil varchar(10) NOT NULL,
    telefono integer NOT NULL,
    sexo varchar(10) NOT NULL,
    token varchar(50) NOT NULL,
    IdPaciente integer NOT NULL,
    CONSTRAINT Pacientes_pk PRIMARY KEY (IdPaciente)
);

-- Table: TipoExamen
CREATE TABLE TipoExamen (
    idTipoExamen integer NOT NULL,
    nombreTipo varchar(15) NOT NULL,
    CONSTRAINT TipoExamen_pk PRIMARY KEY (idTipoExamen)
);

-- Table: Tratamientos
CREATE TABLE Tratamientos (
    idTratamiento integer NOT NULL,
    concepto varchar(50) NOT NULL,
    CONSTRAINT Tratamientos_pk PRIMARY KEY (idTratamiento)
);

-- foreign keys
-- Reference: Acudientes_Pacientes (table: Acudientes)
ALTER TABLE Acudientes ADD CONSTRAINT Acudientes_Pacientes FOREIGN KEY Acudientes_Pacientes (Pacientes_IdPaciente)
    REFERENCES Pacientes (IdPaciente);

-- Reference: CitasMedicasExamenSegmentario (table: Citas_Medicas)
ALTER TABLE Citas_Medicas ADD CONSTRAINT CitasMedicasExamenSegmentario FOREIGN KEY CitasMedicasExamenSegmentario (ExSegmentario_idExamen)
    REFERENCES ExamenSegmentario (idExamen);

-- Reference: Citas_Medicas_Examen_Fisico (table: Citas_Medicas)
ALTER TABLE Citas_Medicas ADD CONSTRAINT Citas_Medicas_Examen_Fisico FOREIGN KEY Citas_Medicas_Examen_Fisico (Examen_Fisico_idExamen)
    REFERENCES Examen_Fisico (idExamen);

-- Reference: Citas_Medicas_Habitos (table: Citas_Medicas)
ALTER TABLE Citas_Medicas ADD CONSTRAINT Citas_Medicas_Habitos FOREIGN KEY Citas_Medicas_Habitos (Habitos_idHabito)
    REFERENCES Habitos (idHabito);

-- Reference: Citas_Medicas_Historia_Clinica (table: Citas_Medicas)
ALTER TABLE Citas_Medicas ADD CONSTRAINT Citas_Medicas_Historia_Clinica FOREIGN KEY Citas_Medicas_Historia_Clinica (Historia_Clinica_idHistoria)
    REFERENCES Historia_Clinica (idHistoria);

-- Reference: Citas_Medicas_Medicos (table: Citas_Medicas)
ALTER TABLE Citas_Medicas ADD CONSTRAINT Citas_Medicas_Medicos FOREIGN KEY Citas_Medicas_Medicos (Medicos_idMedico)
    REFERENCES Medicos (idMedico);

-- Reference: DiagXTrata_Diagnosticos (table: DiagXTrata)
ALTER TABLE DiagXTrata ADD CONSTRAINT DiagXTrata_Diagnosticos FOREIGN KEY DiagXTrata_Diagnosticos (Diagnosticos_idDiagnostico)
    REFERENCES Diagnosticos (idDiagnostico);

-- Reference: DiagXTrata_Tratamientos (table: DiagXTrata)
ALTER TABLE DiagXTrata ADD CONSTRAINT DiagXTrata_Tratamientos FOREIGN KEY DiagXTrata_Tratamientos (Tratamientos_idTratamiento)
    REFERENCES Tratamientos (idTratamiento);

-- Reference: Diagnosticos_Citas_Medicas (table: Diagnosticos)
ALTER TABLE Diagnosticos ADD CONSTRAINT Diagnosticos_Citas_Medicas FOREIGN KEY Diagnosticos_Citas_Medicas (Citas_Medicas_idConsulta)
    REFERENCES Citas_Medicas (idConsulta);

-- Reference: Examenes_Diagnosticos (table: Examenes)
ALTER TABLE Examenes ADD CONSTRAINT Examenes_Diagnosticos FOREIGN KEY Examenes_Diagnosticos (Diagnosticos_idDiagnostico)
    REFERENCES Diagnosticos (idDiagnostico);

-- Reference: Examenes_TipoExamen (table: Examenes)
ALTER TABLE Examenes ADD CONSTRAINT Examenes_TipoExamen FOREIGN KEY Examenes_TipoExamen (TipoExamen_idTipoExamen)
    REFERENCES TipoExamen (idTipoExamen);

-- Reference: Historia_Clinica_Antecedentes (table: Historia_Clinica)
ALTER TABLE Historia_Clinica ADD CONSTRAINT Historia_Clinica_Antecedentes FOREIGN KEY Historia_Clinica_Antecedentes (Antecedentes_idAntecedente)
    REFERENCES Antecedentes (idAntecedente);

-- Reference: Historia_Clinica_Entidad (table: Historia_Clinica)
ALTER TABLE Historia_Clinica ADD CONSTRAINT Historia_Clinica_Entidad FOREIGN KEY Historia_Clinica_Entidad (Entidad_idEntidad)
    REFERENCES Entidad (idEntidad);

-- Reference: Historia_Clinica_Fisiologica (table: Historia_Clinica)
ALTER TABLE Historia_Clinica ADD CONSTRAINT Historia_Clinica_Fisiologica FOREIGN KEY Historia_Clinica_Fisiologica (Fisiologica_IdFisiologica)
    REFERENCES Fisiologica (IdFisiologica);

-- Reference: Historia_Clinica_Pacientes (table: Historia_Clinica)
ALTER TABLE Historia_Clinica ADD CONSTRAINT Historia_Clinica_Pacientes FOREIGN KEY Historia_Clinica_Pacientes (Pacientes_IdPaciente)
    REFERENCES Pacientes (IdPaciente);

-- Reference: MedXDiagXTrata_Medicamentos (table: MedXTrata)
ALTER TABLE MedXTrata ADD CONSTRAINT MedXDiagXTrata_Medicamentos FOREIGN KEY MedXDiagXTrata_Medicamentos (Medicamentos_idMedicamento)
    REFERENCES Medicamentos (idMedicamento);

-- Reference: MedXTrataXDiag_Tratamientos (table: MedXTrata)
ALTER TABLE MedXTrata ADD CONSTRAINT MedXTrataXDiag_Tratamientos FOREIGN KEY MedXTrataXDiag_Tratamientos (Tratamientos_idTratamiento)
    REFERENCES Tratamientos (idTratamiento);
    
-- unique keys
-- Reference (Unique key in Historias clinicas)
ALTER TABLE historia_clinica ADD CONSTRAINT U_Pacientes_idPaciente UNIQUE (Pacientes_idPaciente);

ALTER TABLE historia_clinica ADD CONSTRAINT U_Fisiologicas_idFisiologica UNIQUE(Fisiologica_idFisiologica);

ALTER TABLE historia_clinica ADD CONSTRAINT U_Antecedentes_idAntecedente UNIQUE(Antecedentes_idAntecedente);

-- References (Unique key in Citas medicas)
ALTER TABLE Citas_Medicas ADD CONSTRAINT U_Examen_Fisico_idExamen UNIQUE(Examen_Fisico_idExamen);

ALTER TABLE citas_medicas ADD CONSTRAINT U_Habitos_idHabito UNIQUE(Habitos_idHabito);

ALTER TABLE citas_medicas ADD CONSTRAINT U_ExSegmentario_idExamen UNIQUE (ExSegmentario_idExamen);

-- References (Unique Key in Pacientes)
ALTER TABLE pacientes ADD CONSTRAINT U_DNI UNIQUE (DNI);

-- References (Unique Key in Acudientes)
ALTER TABLE acudientes ADD CONSTRAINT U_DNI UNIQUE (DNI);

-- End of file.

