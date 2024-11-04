CREATE DATABASE pengambilan_krs;
use pengambilan_krs;
DROP DATABASE pengambilan_krs;

CREATE TABLE Semester (
	semester_id INT PRIMARY KEY,
    semester ENUM ('Ganjil', 'Genap') NOT NULL,
    tahun_ajaran VARCHAR (9) NOT NULL
);

CREATE TABLE Prodi (
    kd_prodi VARCHAR(10) PRIMARY KEY,
    nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE Mahasiswa (
    NIM VARCHAR(6) PRIMARY KEY,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    tanggallahir DATE NOT NULL,
    agama VARCHAR(20),
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    alamat TEXT,
    kd_prodi VARCHAR(10),
    semester_id INT,
    FOREIGN KEY (kd_prodi) REFERENCES Prodi(kd_prodi),
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id)
);

CREATE TABLE Mata_Kuliah (
    kd_mk VARCHAR(10) PRIMARY KEY,
    matakuliah VARCHAR(100) NOT NULL,
    SKS INT NOT NULL,
    kd_prodi VARCHAR(10),
    semester_id INT,
    FOREIGN KEY (kd_prodi) REFERENCES Prodi(kd_prodi)
);

CREATE TABLE Jadwal (
    jadwal_id VARCHAR(10) PRIMARY KEY,
    kd_mk VARCHAR(10),
    mata_kuliah VARCHAR(100),
    waktu DATETIME,
    FOREIGN KEY (kd_mk) REFERENCES Mata_Kuliah(kd_mk)
);

CREATE TABLE KRS (
    kd_KRS VARCHAR(15) PRIMARY KEY,
    nama_mahasiswa VARCHAR(100),
    NIM VARCHAR(6),
    semester_id INT,
    kd_mk VARCHAR(10),
    FOREIGN KEY (NIM) REFERENCES Mahasiswa(NIM),
    FOREIGN KEY (kd_mk) REFERENCES Mata_Kuliah(kd_mk),
    FOREIGN KEY (semester_id) REFERENCES Semester(semester_id)
);