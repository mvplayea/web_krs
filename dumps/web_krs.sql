drop database if exists pengambilan_krs;
create database pengambilan_krs;
use pengambilan_krs;

create table if not exists prodi
(
    kd_prodi   varchar(10)  not null
        primary key,
    nama_prodi varchar(100) not null
);

create table if not exists mata_kuliah
(
    kd_mk       varchar(10)  not null
        primary key,
    matakuliah  varchar(100) not null,
    SKS         int          not null,
    kd_prodi    varchar(10)  null,
    semester_id int          null,
    constraint mata_kuliah_ibfk_1
        foreign key (kd_prodi) references prodi (kd_prodi)
);

create table if not exists jadwal
(
    jadwal_id   varchar(10)  not null
        primary key,
    kd_mk       varchar(10)  null,
    mata_kuliah varchar(100) null,
    waktu       datetime     null,
    constraint jadwal_ibfk_1
        foreign key (kd_mk) references mata_kuliah (kd_mk)
);

create index kd_mk
    on jadwal (kd_mk);

create index kd_prodi
    on mata_kuliah (kd_prodi);

create table if not exists semester
(
    semester_id  int                      not null
        primary key,
    semester     enum ('Ganjil', 'Genap') not null,
    tahun_ajaran varchar(9)               not null
);

create table if not exists mahasiswa
(
    NIM            varchar(6)      not null
        primary key,
    nama_mahasiswa varchar(100)    not null,
    tanggallahir   date            not null,
    agama          varchar(20)     null,
    jenis_kelamin  enum ('L', 'P') not null,
    alamat         text            null,
    kd_prodi       varchar(10)     null,
    semester_id    int             null,
    constraint mahasiswa_ibfk_1
        foreign key (kd_prodi) references prodi (kd_prodi),
    constraint mahasiswa_ibfk_2
        foreign key (semester_id) references semester (semester_id)
);

create table if not exists krs
(
    kd_KRS         varchar(15)  not null
        primary key,
    nama_mahasiswa varchar(100) null,
    NIM            varchar(6)   null,
    semester_id    int          null,
    constraint krs_ibfk_1
        foreign key (NIM) references mahasiswa (NIM),
    constraint krs_ibfk_2
        foreign key (semester_id) references semester (semester_id)
);

create index NIM
    on krs (NIM);

create index semester_id
    on krs (semester_id);

create table if not exists krs_mk
(
    kd_krs varchar(15) not null,
    kd_mk  varchar(10) not null,
    primary key (kd_krs, kd_mk),
    constraint krs_mk_ibfk_1
        foreign key (kd_krs) references krs (kd_KRS),
    constraint krs_mk_ibfk_2
        foreign key (kd_mk) references mata_kuliah (kd_mk)
);

create index kd_mk
    on krs_mk (kd_mk);

create index kd_prodi
    on mahasiswa (kd_prodi);

create index semester_id
    on mahasiswa (semester_id);

use pengambilan_krs;

INSERT INTO Semester (semester_id, semester, tahun_ajaran)
VALUES (1, 'Ganjil', '2023/2024'),
       (2, 'Genap', '2023/2024'),
       (3, 'Ganjil', '2024/2025'),
       (4, 'Genap', '2024/2025'),
       (5, 'Ganjil', '2025/2026'),
       (6, 'Genap', '2025/2026'),
       (7, 'Ganjil', '2027/2028'),
       (8, 'Genap', '2027/2028');

INSERT INTO Prodi (kd_prodi, nama_prodi)
VALUES ('0801', 'Teknik Infomatika'),
       ('0802', 'Sistem Informasi');

INSERT INTO Mahasiswa (NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id)
VALUES ('080101', 'Bunga', '2005-05-12', 'Islam', 'P', 'Jl. Mawar No.1', '0801', 1),
       ('080201', 'Cici', '2004-06-23', 'Islam', 'P', 'Jl. Melati No.45', '0802', 2),
       ('080102', 'Rui', '2003-07-12', 'Katolik', 'L', 'Jl. Agraris No.17', '0801', 3),
       ('080202', 'Dani', '2004-12-14', 'Islam', 'L', 'Jl. Rawanya No.68', '0802', 4),
       ('080103', 'Lela', '2006-04-09', 'Hindu', 'P', 'Jl. Sudirman No.32', '0801', 5),
       ('080203', 'Kaluna', '2005-10-01', 'Islam', 'P', 'Jl. Ciruwa No.75', '0802', 6),
       ('080104', 'Rei', '2005-08-18', 'Islam', 'L', 'Jl. Rambutan No.50', '0801', 7),
       ('080204', 'Adri', '2005-03-27', 'Budha', 'L', 'Jl. Mangga No.73', '0802', 8);

-- Data Mata Kuliah Teknik Informatika
INSERT INTO Mata_Kuliah (kd_mk, matakuliah, SKS, kd_prodi, semester_id)
VALUES ('TI001', 'Algoritma dan Pemrograman', 3, '0801', 1),
       ('TI002', 'Aljabar Linier dan Matriks', 3, '0801', 1),
       ('TI003', 'Dasar Sistem Informasi', 3, '0801', 1),
       ('TI004', 'Organisasi dan Manajemen', 3, '0801', 2),
       ('TI005', 'Organisasi dan Arsitektur Komputer', 3, '0801', 2),
       ('TI006', 'Struktur Data', 3, '0801', 2),
       ('TI007', 'Matematika Diskrit', 3, '0801', 2),
       ('TI008', 'Bahasa Pemrograman', 3, '0801', 2),
       ('TI009', 'Kalkulus 1', 3, '0801', 2),
       ('TI010', 'Kalkulus 2', 3, '0801', 3),
       ('TI011', 'Desain Analisis Algoritma', 3, '0801', 3),
       ('TI012', 'Sistem Operasi', 3, '0801', 3),
       ('TI013', 'Basis Data', 3, '0801', 3),
       ('TI014', 'Rekayasa Perangkat Lunak', 3, '0801', 3),
       ('TI015', 'Pemrograman Berorientasi Objek', 3, '0801', 3),
       ('TI016', 'Manajemen Proyek Perangkat Lunak', 3, '0801', 4),
       ('TI017', 'Keamanan Informasi', 3, '0801', 4),
       ('TI018', 'Machine Learning', 3, '0801', 4),
       ('TI019', 'Arsitektur Berbasis Layanan', 3, '0801', 4),
       ('TI020', 'Internet of Things', 3, '0801', 4),
       ('TI021', 'Pemrograman Web', 3, '0801', 4),
       ('TI022', 'Jaringan Komputer', 3, '0801', 4),
       ('TI023', 'Analisis dan Perancangan Sistem Informasi', 3, '0801', 4),
       ('TI024', 'Data Warehouse', 3, '0801', 4),
       ('TI025', 'Kecerdasan Artifisial', 3, '0801', 5),
       ('TI026', 'Pemrograman Mobile', 3, '0801', 5),
       ('TI027', 'Kriptografi', 3, '0801', 5),
       ('TI028', 'Pengolahan Citra', 3, '0801', 5),
       ('TI029', 'Jaringan Mobile', 3, '0801', 5),
       ('TI030', 'Pengembangan Perangkat Lunak', 3, '0801', 5),
       ('TI031', 'Perancangan Aplikasi Mobile', 3, '0801', 5),
       ('TI032', 'Statistika', 3, '0801', 5),
       ('TI033', 'Data Mining', 3, '0801', 5),
       ('TI034', 'Isu Sosial dan Keprofesian Teknologi Informasi', 3, '0801', 6),
       ('TI035', 'Arsitektur Enterprise', 3, '0801', 6),
       ('TI036', 'Cyber Security', 3, '0801', 6),
       ('TI037', 'Mobile Application dan Teknologi', 3, '0801', 6),
       ('TI038', 'Metodologi Penelitian', 3, '0801', 6),
       ('TI039', 'Interaksi Manusia Komputer', 3, '0801', 6),
       ('TI040', 'Big Data', 3, '0801', 6),
       ('TI041', 'Sistem Basis Data Terdistribusi', 3, '0801', 7),
       ('TI042', 'Jaringan Komputer Lanjut', 3, '0801', 7),
       ('TI043', 'Kapita Selekta Informatika', 3, '0801', 7),
       ('TI044', 'Software Quality Assurance', 3, '0801', 7),
       ('TI045', 'Game Development', 3, '0801', 7),
       ('TI046', 'Seminar Proposal', 2, '0801', 7),
       ('TI047', 'Tugas Akhir', 6, '0801', 8);

-- Data Mata Kuliah Sistem Informasi
INSERT INTO Mata_Kuliah (kd_mk, matakuliah, SKS, kd_prodi, semester_id)
VALUES ('SI001', 'Algoritma dan Pemrograman', 3, '0802', 1),
       ('SI002', 'Dasar Sistem Informasi', 3, '0802', 1),
       ('SI003', 'Aljabar Linier dan Matriks', 3, '0802', 1),
       ('SI004', 'Bahasa Inggris 1', 3, '0802', 1),
       ('SI005', 'Bahasa Indonesia', 2, '0802', 1),
       ('SI006', 'Pendidikan Kewarganegaraan', 2, '0802', 1),
       ('SI007', 'Pendidikan Pancasila', 2, '0802', 1),
       ('SI008', 'Pemodelan Proses Bisnis', 3, '0802', 2),
       ('SI009', 'Analisis Kebutuhan Informasi', 3, '0802', 2),
       ('SI010', 'Struktur Data', 3, '0802', 2),
       ('SI011', 'Organisasi dan Manajemen', 3, '0802', 2),
       ('SI012', 'Organisasi dan Arsitektur Komputer', 3, '0802', 2),
       ('SI013', 'Matematika Diskrit', 3, '0802', 2),
       ('SI014', 'Sistem Informasi Enterprise', 3, '0802', 3),
       ('SI015', 'Manajemen Sumber Daya Informasi', 3, '0802', 3),
       ('SI016', 'Pemrograman Berorientasi Objek', 3, '0802', 3),
       ('SI017', 'Basis Data', 3, '0802', 3),
       ('SI018', 'Sistem Operasi', 3, '0802', 3),
       ('SI019', 'Rekayasa Perangkat Lunak', 3, '0802', 3),
       ('SI020', 'Kewirausahaan 1', 3, '0802', 3),
       ('SI021', 'Metode Sampling dan Survei SI', 3, '0802', 4),
       ('SI022', 'Manajemen Proyek Sistem Informasi', 3, '0802', 4),
       ('SI023', 'Integrasi dan Kustomisasi ERP', 3, '0802', 4),
       ('SI024', 'Pemrograman Web', 3, '0802', 4),
       ('SI025', 'Jaringan Komputer', 3, '0802', 4),
       ('SI026', 'Analisis dan Perancangan Sistem Informasi', 3, '0802', 4),
       ('SI027', 'Data Warehouse', 3, '0802', 4),
       ('SI028', 'Infrastruktur dan Manajemen Layanan TI', 3, '0802', 5),
       ('SI029', 'E-Bisnis', 3, '0802', 5),
       ('SI030', 'Audit dan Kendali Sistem Informasi', 3, '0802', 5),
       ('SI031', 'Arsitektur Enterprise', 3, '0802', 5),
       ('SI032', 'Analisis Resiko Sistem Informasi', 3, '0802', 5),
       ('SI033', 'Implementasi Sistem Informasi', 3, '0802', 5),
       ('SI034', 'Rekayasa Layanan', 3, '0802', 5),
       ('SI035', 'Statistik', 3, '0802', 5),
       ('SI036', 'Data Mining', 3, '0802', 5),
       ('SI037', 'Isu Sosial dan Keprofesian Sistem Informasi', 3, '0802', 6),
       ('SI038', 'Evaluasi Sistem Informasi', 3, '0802', 6),
       ('SI039', 'Jaminan dan Keamanan Informasi', 3, '0802', 6),
       ('SI040', 'Masyarakat Virtual', 3, '0802', 6),
       ('SI041', 'Internet of Things', 3, '0802', 6),
       ('SI042', 'Metodologi Penelitian', 3, '0802', 6),
       ('SI043', 'Interaksi Manusia Komputer', 3, '0802', 6),
       ('SI044', 'Big Data', 3, '0802', 6),
       ('SI045', 'Manajemen Pengetahuan', 3, '0802', 7),
       ('SI046', 'Kapita Selekta Sistem Informasi', 3, '0802', 7),
       ('SI047', 'IT untuk Pemulihan Bencana', 3, '0802', 7),
       ('SI048', 'Intelegensia Bisnis', 3, '0802', 7),
       ('SI049', 'Seminar Proposal', 2, '0802', 7),
       ('SI050', 'Tugas Akhir', 6, '0802', 8);

-- TI
INSERT INTO Jadwal (jadwal_id, kd_mk, mata_kuliah, waktu)
VALUES ('JD001', 'TI001', 'Algorithma dan Pemrograman', '2024-09-05 08:00:00'),
       ('JD002', 'TI002', 'Aljabar Linier dan Matriks', '2024-09-05 10:00:00'),
       ('JD003', 'TI003', 'Dasar Sistem Information', '2024-09-06 13:00:00'),
       ('JD004', 'TI004', 'Organisasi dan Manajemen', '2024-09-07 09:00:00'),
       ('JD005', 'TI005', 'Organisasi dan Arsitektur Komputer', '2024-09-08 11:00:00'),
       ('JD006', 'TI006', 'Struktur Data', '2024-09-09 08:00:00'),
       ('JD007', 'TI007', 'Matematika Diskrit', '2024-09-09 10:00:00'),
       ('JD008', 'TI008', 'Bahasa Pemrograman', '2024-09-10 13:00:00'),
       ('JD009', 'TI009', 'Kalkulus 1', '2024-09-11 08:00:00'),
       ('JD010', 'TI010', 'Kalkulus 2', '2024-09-12 09:00:00'),
       ('JD011', 'TI011', 'Desain Analisis Algorithma', '2024-09-12 11:00:00'),
       ('JD012', 'TI012', 'Sistem Operasi', '2024-09-13 08:00:00'),
       ('JD013', 'TI013', 'Basis Data', '2024-09-14 10:00:00'),
       ('JD014', 'TI014', 'Rekayasa Perangkat Lunak', '2024-09-15 09:00:00'),
       ('JD015', 'TI015', 'Pemrograman Berorientasi Objek', '2024-09-15 13:00:00'),
       ('JD016', 'TI016', 'Manajemen Proyek Perangkat Lunak', '2024-09-16 08:00:00'),
       ('JD017', 'TI017', 'Keamanan Informasi', '2024-09-17 09:00:00'),
       ('JD018', 'TI018', 'Machine Learning', '2024-09-17 11:00:00'),
       ('JD019', 'TI019', 'Arsitektur Berbasis Layanan', '2024-09-18 08:00:00'),
       ('JD020', 'TI020', 'Internet of Things', '2024-09-18 10:00:00'),
       ('JD021', 'TI021', 'Pemrograman Web', '2024-09-19 09:00:00'),
       ('JD022', 'TI022', 'Jaringan Komputer', '2024-09-19 11:00:00'),
       ('JD023', 'TI023', 'Analisis dan Perancangan Sistem Informasi', '2024-09-20 08:00:00'),
       ('JD024', 'TI024', 'Data Warehouse', '2024-09-21 09:00:00'),
       ('JD025', 'TI025', 'Kecerdasan Artifisial', '2024-09-21 11:00:00'),
       ('JD026', 'TI026', 'Pemrograman Mobile', '2024-09-22 08:00:00'),
       ('JD027', 'TI027', 'Kriptografi', '2024-09-23 09:00:00'),
       ('JD028', 'TI028', 'Pengolahan Citra', '2024-09-23 11:00:00'),
       ('JD029', 'TI029', 'Jaringan Mobile', '2024-09-24 08:00:00'),
       ('JD030', 'TI030', 'Pengembangan Perangkat Lunak', '2024-09-24 10:00:00'),
       ('JD031', 'TI031', 'Perancangan Aplikasi Mobile', '2024-09-25 08:00:00'),
       ('JD032', 'TI032', 'Statistika', '2024-09-26 09:00:00'),
       ('JD033', 'TI033', 'Data Mining', '2024-09-26 11:00:00'),
       ('JD034', 'TI034', 'Isu Sosial dan Keprofesian Teknologi Informasi', '2024-09-27 08:00:00'),
       ('JD035', 'TI035', 'Arsitektur Enterprise', '2024-09-27 10:00:00'),
       ('JD036', 'TI036', 'Cyber Security', '2024-09-28 08:00:00'),
       ('JD037', 'TI037', 'Mobile Application dan Teknologi', '2024-09-29 09:00:00'),
       ('JD038', 'TI038', 'Metodologi Penelitian', '2024-09-30 08:00:00'),
       ('JD039', 'TI039', 'Interaksi Manusia Komputer', '2024-09-30 10:00:00'),
       ('JD040', 'TI040', 'Big Data', '2024-10-01 08:00:00'),
       ('JD041', 'TI041', 'Sistem Basis Data Terdistribusi', '2024-10-02 09:00:00'),
       ('JD042', 'TI042', 'Jaringan Komputer Lanjut', '2024-10-02 11:00:00'),
       ('JD043', 'TI043', 'Kapitaselekta Informatika', '2024-10-03 08:00:00'),
       ('JD044', 'TI044', 'Software Quality Assurance', '2024-10-04 09:00:00'),
       ('JD045', 'TI045', 'Game Development', '2024-10-04 11:00:00'),
       ('JD046', 'TI046', 'Seminar Proposal', '2024-10-05 08:00:00'),
       ('JD047', 'TI047', 'Tugas Akhir', '2024-10-06 08:00:00');

-- SI
INSERT INTO Jadwal (jadwal_id, kd_mk, mata_kuliah, waktu)
VALUES ('JD048', 'SI001', 'Algoritma dan Pemrograman', '2024-10-07 08:00:00'),
       ('JD049', 'SI002', 'Dasar Sistem Informasi', '2024-10-07 10:00:00'),
       ('JD050', 'SI003', 'Aljabar Linier dan Matriks', '2024-10-08 08:00:00'),
       ('JD051', 'SI004', 'Bahasa Inggris 1', '2024-10-08 10:00:00'),
       ('JD052', 'SI005', 'Bahasa Indonesia', '2024-10-09 08:00:00'),
       ('JD053', 'SI006', 'Pendidikan Kewarganegaraan', '2024-10-09 10:00:00'),
       ('JD054', 'SI007', 'Pendidikan Pancasila', '2024-10-10 08:00:00'),
       ('JD055', 'SI008', 'Pemodelan Proses Bisnis', '2024-10-11 08:00:00'),
       ('JD056', 'SI009', 'Analisis Kebutuhan Informasi', '2024-10-11 10:00:00'),
       ('JD057', 'SI010', 'Struktur Data', '2024-10-12 08:00:00'),
       ('JD058', 'SI011', 'Organisasi dan Manajemen', '2024-10-12 10:00:00'),
       ('JD059', 'SI012', 'Organisasi dan Arsitektur Komputer', '2024-10-13 08:00:00'),
       ('JD060', 'SI013', 'Matematika Diskrit', '2024-10-13 10:00:00'),
       ('JD061', 'SI014', 'Sistem Informasi Enterprise', '2024-10-14 08:00:00'),
       ('JD062', 'SI015', 'Manajemen Sumber Daya Informasi', '2024-10-14 10:00:00'),
       ('JD063', 'SI016', 'Pemrograman Berorientasi Objek', '2024-10-15 08:00:00'),
       ('JD064', 'SI017', 'Basis Data', '2024-10-15 10:00:00'),
       ('JD065', 'SI018', 'Sistem Operasi', '2024-10-16 08:00:00'),
       ('JD066', 'SI019', 'Rekayasa Perangkat Lunak', '2024-10-16 10:00:00'),
       ('JD067', 'SI020', 'Kewirausahaan 1', '2024-10-17 08:00:00'),
       ('JD068', 'SI021', 'Metode Sampling dan Survei SI', '2024-10-17 10:00:00'),
       ('JD069', 'SI022', 'Manajemen Proyek Sistem Informasi', '2024-10-18 08:00:00'),
       ('JD070', 'SI023', 'Integrasi dan Kustomisasi ERP', '2024-10-18 10:00:00'),
       ('JD071', 'SI024', 'Pemrograman Web', '2024-10-19 08:00:00'),
       ('JD072', 'SI025', 'Jaringan Komputer', '2024-10-19 10:00:00'),
       ('JD073', 'SI026', 'Analisis dan Perancangan Sistem Informasi', '2024-10-20 08:00:00'),
       ('JD074', 'SI027', 'Data Warehouse', '2024-10-20 10:00:00'),
       ('JD075', 'SI028', 'Infrastruktur dan Manajemen Layanan TI', '2024-10-21 08:00:00'),
       ('JD076', 'SI029', 'E-Bisnis', '2024-10-21 10:00:00'),
       ('JD077', 'SI030', 'Audit dan Kendali Sistem Informasi', '2024-10-22 08:00:00'),
       ('JD078', 'SI031', 'Arsitektur Enterprise', '2024-10-22 10:00:00'),
       ('JD079', 'SI032', 'Analisis Resiko Sistem Informasi', '2024-10-23 08:00:00'),
       ('JD080', 'SI033', 'Implementasi Sistem Informasi', '2024-10-23 10:00:00'),
       ('JD081', 'SI034', 'Rekayasa Layanan', '2024-10-24 08:00:00'),
       ('JD082', 'SI035', 'Statistik', '2024-10-24 10:00:00'),
       ('JD083', 'SI036', 'Data Mining', '2024-10-25 08:00:00'),
       ('JD084', 'SI037', 'Isu Sosial dan Keprofesian Sistem Informasi', '2024-10-25 10:00:00'),
       ('JD085', 'SI038', 'Evaluasi Sistem Informasi', '2024-10-26 08:00:00'),
       ('JD086', 'SI039', 'Jaminan dan Keamanan Informasi', '2024-10-26 10:00:00'),
       ('JD087', 'SI040', 'Masyarakat Virtual', '2024-10-27 08:00:00'),
       ('JD088', 'SI041', 'Internet of Things', '2024-10-27 10:00:00'),
       ('JD089', 'SI042', 'Metodologi Penelitian', '2024-10-28 08:00:00'),
       ('JD090', 'SI043', 'Interaksi Manusia Komputer', '2024-10-28 10:00:00'),
       ('JD091', 'SI044', 'Big Data', '2024-10-29 08:00:00'),
       ('JD092', 'SI045', 'Manajemen Pengetahuan', '2024-10-29 10:00:00'),
       ('JD093', 'SI046', 'Kapita Selekta Sistem Informasi', '2024-10-30 08:00:00'),
       ('JD094', 'SI047', 'IT untuk Pemulihan Bencana', '2024-10-30 10:00:00'),
       ('JD095', 'SI048', 'Intelegensia Bisnis', '2024-10-31 08:00:00'),
       ('JD096', 'SI049', 'Seminar Proposal', '2024-10-31 10:00:00'),
       ('JD097', 'SI050', 'Tugas Akhir', '2024-11-01 08:00:00');

INSERT INTO KRS (kd_KRS, NIM, semester_id)
VALUES ('KRS001', '080101', 1),
       ('KRS002', '080201', 2),
       ('KRS003', '080102', 3),
       ('KRS004', '080202', 4),
       ('KRS005', '080103', 5),
       ('KRS006', '080203', 6),
       ('KRS007', '080104', 7),
       ('KRS008', '080204', 8);


#  STORE PROCEDURE
DELIMITER //
CREATE PROCEDURE GetMataKuliah(
    IN p_semester INT,
    IN p_prodi INT,
    IN p_page INT
)
BEGIN
    DECLARE v_offset INT;

    -- Calculate the offset for pagination (fixed LIMIT of 10)
    SET v_offset = (p_page - 1) * 10;

    -- Query with filtering and pagination
    IF p_semester IS NOT NULL AND p_prodi IS NOT NULL THEN
        SELECT * FROM mata_kuliah
                          JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi
        WHERE semester_id = p_semester
          AND mata_kuliah.kd_prodi = p_prodi
        LIMIT 10 OFFSET v_offset;
    ELSEIF p_semester IS NOT NULL THEN
        SELECT * FROM mata_kuliah
                          JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi
        WHERE semester_id = p_semester
        LIMIT 10 OFFSET v_offset;
    ELSEIF p_prodi IS NOT NULL THEN
        SELECT * FROM mata_kuliah
                          JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi
        WHERE mata_kuliah.kd_prodi = p_prodi
        LIMIT 10 OFFSET v_offset;
    ELSE
        SELECT * FROM mata_kuliah
                          JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi
        LIMIT 10 OFFSET v_offset;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetJadwal(
    IN p_semester INT,
    IN p_prodi INT,
    IN p_page INT
)
BEGIN
    DECLARE v_offset INT;

    -- Calculate the offset for pagination (fixed LIMIT of 10)
    SET v_offset = (p_page - 1) * 10;

    -- Query with filtering and pagination for the jadwal table
    IF p_semester IS NOT NULL AND p_prodi IS NOT NULL THEN
        SELECT jadwal.jadwal_id, jadwal.kd_mk, jadwal.waktu, mata_kuliah.matakuliah, mata_kuliah.sks, mata_kuliah.semester_id, mata_kuliah.kd_prodi
        FROM jadwal
                 JOIN mata_kuliah ON jadwal.kd_mk = mata_kuliah.kd_mk
                 JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi
        WHERE mata_kuliah.semester_id = p_semester
          AND mata_kuliah.kd_prodi = p_prodi
        LIMIT 10 OFFSET v_offset;
    ELSEIF p_semester IS NOT NULL THEN
        SELECT jadwal.jadwal_id, jadwal.kd_mk, jadwal.waktu, mata_kuliah.matakuliah, mata_kuliah.sks, mata_kuliah.semester_id, mata_kuliah.kd_prodi
        FROM jadwal
                 JOIN mata_kuliah ON jadwal.kd_mk = mata_kuliah.kd_mk
        WHERE mata_kuliah.semester_id = p_semester
        LIMIT 10 OFFSET v_offset;
    ELSEIF p_prodi IS NOT NULL THEN
        SELECT jadwal.jadwal_id, jadwal.kd_mk, jadwal.waktu, mata_kuliah.matakuliah, mata_kuliah.sks, mata_kuliah.semester_id, mata_kuliah.kd_prodi
        FROM jadwal
                 JOIN mata_kuliah ON jadwal.kd_mk = mata_kuliah.kd_mk
                 JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi
        WHERE mata_kuliah.kd_prodi = p_prodi
        LIMIT 10 OFFSET v_offset;
    ELSE
        SELECT jadwal.jadwal_id, jadwal.kd_mk, jadwal.waktu, mata_kuliah.matakuliah, mata_kuliah.sks, mata_kuliah.semester_id, mata_kuliah.kd_prodi
        FROM jadwal
                 JOIN mata_kuliah ON jadwal.kd_mk = mata_kuliah.kd_mk
        LIMIT 10 OFFSET v_offset;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsertJadwal(IN p_kd_mk VARCHAR(10), IN p_waktu DATETIME)
BEGIN
    DECLARE last_id VARCHAR(10);
    DECLARE new_id INT;
    DECLARE mata_kuliah_name VARCHAR(255);

    -- Get the last jadwal_id (without the 'JD' prefix)
    SELECT MAX(CAST(SUBSTRING(jadwal_id, 3) AS UNSIGNED)) INTO new_id
    FROM jadwal;

    -- If no data exists, start from 1
    IF new_id IS NULL THEN
        SET new_id = 1;
    ELSE
        SET new_id = new_id + 1;
    END IF;

    -- Format the new jadwal_id as JDxxx (e.g., JD001, JD002, ...)
    SET last_id = CONCAT('JD', LPAD(new_id, 3, '0'));

    -- Fetch mata_kuliah based on kd_mk
    SELECT matakuliah INTO mata_kuliah_name
    FROM mata_kuliah
    WHERE kd_mk = p_kd_mk;

    -- Check if mata_kuliah exists, if not, set an error or handle it
    IF mata_kuliah_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mata Kuliah not found';
    END IF;

    -- Insert the new jadwal record with mata_kuliah
    INSERT INTO jadwal (jadwal_id, kd_mk, waktu, mata_kuliah)
    VALUES (last_id, p_kd_mk, p_waktu, mata_kuliah_name);

END //
DELIMITER ;

# TRIGGER
DELIMITER //
CREATE TRIGGER BeforeDeleteMataKuliah
    BEFORE DELETE ON mata_kuliah
    FOR EACH ROW
BEGIN
    DELETE FROM krs_mk
    WHERE kd_mk = OLD.kd_mk;

    DELETE FROM jadwal
    WHERE kd_mk = OLD.kd_mk;

END //
DELIMITER ;

