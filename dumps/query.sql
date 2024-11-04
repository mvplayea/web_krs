SELECT * FROM Mahasiswa;

SELECT * FROM Mata_Kuliah;

SELECT * FROM Mata_Kuliah WHERE semester_id = 1;

SELECT * FROM Mata_Kuliah WHERE semester_id IN (1, 2, 3);

SELECT * FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
WHERE Mahasiswa.nama_mahasiswa = 'Bunga';

-- SELECT data KRS yang bergabung dengan tabel Mahasiswa dan Mata Kuliah
SELECT KRS.kd_KRS, Mahasiswa.nama_mahasiswa, Mata_Kuliah.matakuliah, Mata_Kuliah.SKS, Semester.semester, Semester.tahun_ajaran
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
JOIN Semester ON KRS.semester_id = Semester.semester_id;

-- SELECT semua mahasiswa yang terdaftar dalam KRS dengan semester Ganjil 2023/2024
SELECT Mahasiswa.nama_mahasiswa, KRS.kd_KRS, Mata_Kuliah.matakuliah, Mata_Kuliah.SKS
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
JOIN Semester ON KRS.semester_id = Semester.semester_id
WHERE Semester.semester = 'Ganjil' AND Semester.tahun_ajaran = '2023/2024';

-- SELECT semua mahasiswa untuk mata kuliah pilihan di semester 5
SELECT Mahasiswa.nama_mahasiswa, Mata_Kuliah.matakuliah, Mata_Kuliah.SKS
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
WHERE Mata_Kuliah.semester_id = 5 AND Mata_Kuliah.kd_prodi = '0801';

-- SELECT semua data KRS untuk mahasiswa dengan NIM '080102'
SELECT KRS.*, Mahasiswa.nama_mahasiswa, Mata_Kuliah.matakuliah, Mata_Kuliah.SKS
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
WHERE Mahasiswa.NIM = '080102';

-- SELECT mata kuliah berdasarkan program studi dan semester yang diinginkan
SELECT Mata_Kuliah.matakuliah, Mata_Kuliah.SKS, Prodi.nama_prodi, Semester.semester, Semester.tahun_ajaran
FROM Mata_Kuliah
JOIN Prodi ON Mata_Kuliah.kd_prodi = Prodi.kd_prodi
JOIN Semester ON Mata_Kuliah.semester_id = Semester.semester_id
WHERE Prodi.nama_prodi = 'Sistem Informasi' AND Semester.semester = 'Genap';

-- SELECT mahasiswa dan jumlah SKS yang diambil di semester tertentu
SELECT Mahasiswa.nama_mahasiswa, SUM(Mata_Kuliah.SKS) AS total_SKS
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
WHERE KRS.semester_id = 1
GROUP BY Mahasiswa.nama_mahasiswa;
-- bai

-- Jumlah mahasiswa per prodi:
SELECT Prodi.nama_prodi, COUNT(Mahasiswa.NIM) AS jumlah_mahasiswa
FROM Prodi
LEFT JOIN Mahasiswa ON Prodi.kd_prodi = Mahasiswa.kd_prodi
GROUP BY Prodi.nama_prodi;

-- Mahasiswa yang belum mengambil mata kuliah tertentu:
SELECT Mahasiswa.nama_mahasiswa
FROM Mahasiswa
WHERE Mahasiswa.NIM NOT IN (
    SELECT KRS.NIM 
    FROM KRS
    WHERE KRS.kd_mk = 'TI001' -- Ganti dengan kode mata kuliah yang diinginkan
);

-- Mata kuliah yang paling banyak diambil:
SELECT Mata_Kuliah.matakuliah, COUNT(KRS.kd_mk) AS jumlah_pendaftar
FROM Mata_Kuliah
JOIN KRS ON Mata_Kuliah.kd_mk = KRS.kd_mk
GROUP BY Mata_Kuliah.matakuliah
ORDER BY jumlah_pendaftar DESC
LIMIT 1;

-- Rata-rata SKS per semester:
SELECT Semester.semester, AVG(Mata_Kuliah.SKS) AS rata_rata_sks
FROM Mata_Kuliah
JOIN Semester ON Mata_Kuliah.semester_id = Semester.semester_id
GROUP BY Semester.semester;

-- Jumlah KRS yang dibuat per semester:
SELECT Semester.semester, COUNT(KRS.kd_KRS) AS jumlah_krs
FROM KRS
JOIN Semester ON KRS.semester_id = Semester.semester_id
GROUP BY Semester.semester;

-- Mahasiswa yang mengambil lebih dari 24 SKS:
SELECT Mahasiswa.nama_mahasiswa, SUM(Mata_Kuliah.SKS) AS total_sks
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
GROUP BY Mahasiswa.nama_mahasiswa
HAVING SUM(Mata_Kuliah.SKS) > 24;
--karlin

-- mahasiswa yang telah lulus semua matakuliah wajib

SELECT m.id_mahasiswa, m.nama 
FROM mahasiswa m
LEFT JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
LEFT JOIN matakuliah mk ON k.id_matakuliah = mk.id_matakuliah
WHERE mk.kategori = 'wajib'
GROUP BY m.id_mahasiswa
HAVING COUNT(mk.id_matakuliah) = (SELECT COUNT(*) FROM matakuliah WHERE kategori = 'wajib');
-- jumlah dosen perprogram study

SELECT p.nama_prodi, COUNT(d.id_dosen) AS jumlah_dosen
FROM dosen d
JOIN prodi p ON d.id_prodi = p.id_prodi
GROUP BY p.nama_prodi;
-- mahasiswa yang tidak aktif dalam 2 semester terakhir

SELECT m.id_mahasiswa, m.nama
FROM mahasiswa m
LEFT JOIN krs k ON m.id_mahasiswa = k.id_mahasiswa
WHERE k.semester IN ('Semester_2_2024', 'Semester_1_2024')
GROUP BY m.id_mahasiswa
HAVING COUNT(k.id_krs) = 0;
-- presentase matakuliah yang di ambil ulang

SELECT (COUNT() * 100.0) / (SELECT COUNT() FROM krs) AS persentase_remedial
FROM krs
WHERE status = 'remedial';
-- top 5 dosen dengan jumlah kelas terbanyak

SELECT d.nama_dosen, COUNT(k.id_kelas) AS jumlah_kelas
FROM dosen d
JOIN kelas k ON d.id_dosen = k.id_dosen
GROUP BY d.nama_dosen
ORDER BY jumlah_kelas DESC
LIMIT 5;
--  mahasiswa yang mendapatkan ipk tertinggi perprodi

SELECT p.nama_prodi, m.id_mahasiswa, m.nama, m.ipk
FROM mahasiswa m
JOIN prodi p ON m.id_prodi = p.id_prodi
WHERE (m.ipk = (SELECT MAX(ipk) FROM mahasiswa WHERE id_prodi = m.id_prodi))
ORDER BY p.nama_prodi, m.ipk DESC;
-- jumlah mahasiswa yang mengambil matakuliah dengan pilihan tertentu

SELECT mk.nama_matakuliah, COUNT(k.id_mahasiswa) AS jumlah_peminat
FROM matakuliah mk
JOIN krs k ON mk.id_matakuliah = k.id_matakuliah
WHERE mk.kategori = 'pilihan'
GROUP BY mk.nama_matakuliah
ORDER BY jumlah_peminat DESC;
-- Rata-rata waktu kelulusan mahasiswa per prodi

SELECT p.nama_prodi, AVG(m.tahun_keluar - m.tahun_masuk) AS rata_waktu_kelulusan
FROM mahasiswa m
JOIN prodi p ON m.id_prodi = p.id_prodi
WHERE m.status = 'lulus'
GROUP BY p.nama_prodi;
-- Jumlah mahasiswa per status (aktif, cuti, lulus, dll.)

SELECT status, COUNT(id_mahasiswa) AS jumlah
FROM mahasiswa
GROUP BY status;
-- Jumlah mahasiswa yang mengambil SKS lebih dari rata-rata

SELECT COUNT(DISTINCT k.id_mahasiswa) AS jumlah_mahasiswa
FROM krs k
JOIN mahasiswa m ON k.id_mahasiswa = m.id_mahasiswa
GROUP BY m.id_mahasiswa
HAVING SUM(k.sks) > (SELECT AVG(total_sks) FROM (SELECT SUM(sks) AS total_sks FROM krs GROUP BY id_mahasiswa) AS subquery);
--edo

-- Menampilkan Jumlah Mata Kuliah yang Ditawarkan oleh Setiap Prodi
SELECT Prodi.nama_prodi, COUNT(Mata_Kuliah.kd_mk) AS jumlah_mata_kuliah
FROM Mata_Kuliah
JOIN Prodi ON Mata_Kuliah.kd_prodi = Prodi.kd_prodi
GROUP BY Prodi.nama_prodi;
-- Menampilkan Mahasiswa yang Mengambil Mata Kuliah yang Sama di Dua Semester Berbeda
SELECT DISTINCT Mahasiswa.nama_mahasiswa, Mata_Kuliah.matakuliah
FROM KRS K1
JOIN KRS K2 ON K1.NIM = K2.NIM AND K1.kd_mk = K2.kd_mk AND K1.semester_id <> K2.semester_id
JOIN Mahasiswa ON K1.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON K1.kd_mk = Mata_Kuliah.kd_mk;
-- Menampilkan Jumlah Mahasiswa yang Terdaftar di Setiap Program Studi
SELECT Prodi.nama_prodi, COUNT(Mahasiswa.NIM) AS jumlah_mahasiswa
FROM Mahasiswa
JOIN Prodi ON Mahasiswa.kd_prodi = Prodi.kd_prodi
GROUP BY Prodi.nama_prodi;
-- Menampilkan Mahasiswa yang Mengambil Mata Kuliah Pilihan pada Semester "Genap"
SELECT Mahasiswa.nama_mahasiswa, Mata_Kuliah.matakuliah
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
JOIN Semester ON KRS.semester_id = Semester.semester_id
WHERE Mata_Kuliah.jenis_matakuliah = 'Pilihan' AND Semester.semester = 'Genap';
-- -Menampilkan Nama Mahasiswa dan Total Jumlah SKS yang Diambil pada Tahun Ajaran 2023/2024
SELECT Mahasiswa.nama_mahasiswa, SUM(Mata_Kuliah.SKS) AS total_SKS
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
JOIN Semester ON KRS.semester_id = Semester.semester_id
WHERE Semester.tahun_ajaran = '2023/2024'
GROUP BY Mahasiswa.nama_mahasiswa;
-- Menampilkan Jumlah Mahasiswa yang Mengambil Setiap Mata Kuliah Pilihan
SELECT Mata_Kuliah.matakuliah, COUNT(KRS.NIM) AS jumlah_mahasiswa
FROM KRS
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
WHERE Mata_Kuliah.jenis_matakuliah = 'Pilihan'
GROUP BY Mata_Kuliah.matakuliah;
-- Menampilkan Nama dan NIM Mahasiswa yang Mengambil Mata Kuliah dengan Jumlah SKS Minimum
SELECT Mahasiswa.nama_mahasiswa, Mahasiswa.NIM
FROM KRS
JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
WHERE Mata_Kuliah.SKS = (SELECT MIN(SKS) FROM Mata_Kuliah);
--angie

-- Menampilkan mata kuliah dengan jumlah SKS tertinggi dan menghitung berapa banyak mahasiswa yang mendaftar di mata kuliah tersebut:
SELECT mk.matakuliah, mk.SKS, COUNT(k.NIM) AS jumlah_pendaftar
FROM Mata_Kuliah mk
LEFT JOIN KRS k ON mk.kd_mk = k.kd_mk
WHERE mk.SKS = (SELECT MAX(SKS) FROM Mata_Kuliah)
GROUP BY mk.matakuliah, mk.SKS;
--Menampilkan mahasiswa di setiap program studi yang mengambil jumlah mata kuliah terbanyak:
SELECT p.nama_prodi, m.nama_mahasiswa, COUNT(k.kd_mk) AS jumlah_matakuliah
FROM Prodi p
JOIN Mahasiswa m ON p.kd_prodi = m.kd_prodi
JOIN KRS k ON m.NIM = k.NIM
GROUP BY p.nama_prodi, m.nama_mahasiswa
ORDER BY p.nama_prodi, jumlah_matakuliah DESC;
--Menampilkan mata kuliah yang tidak diambil oleh satu pun mahasiswa dalam semester tertentu:
SELECT mk.matakuliah
FROM Mata_Kuliah mk
LEFT JOIN KRS k ON mk.kd_mk = k.kd_mk AND k.semester_id = '2023-1' 
WHERE k.kd_mk IS NULL;
--Menghitung jumlah mahasiswa yang mengulang mata kuliah tertentu:
SELECT mk.matakuliah, COUNT(DISTINCT k.NIM) AS jumlah_pengulang
FROM KRS k
JOIN Mata_Kuliah mk ON k.kd_mk = mk.kd_mk
WHERE k.status = 'mengulang'
GROUP BY mk.matakuliah;
--Menghitung rata-rata IPK mahasiswa per program studi untuk mahasiswa yang sudah lulus:
SELECT p.nama_prodi, AVG(m.ipk) AS rata_rata_ipk
FROM Prodi p
JOIN Mahasiswa m ON p.kd_prodi = m.kd_prodi
WHERE m.status = 'lulus'
GROUP BY p.nama_prodi;
--Menghitung jumlah mahasiswa yang lulus di setiap tahun:
SELECT m.tahun_keluar AS tahun_lulus, COUNT(m.NIM) AS jumlah_mahasiswa_lulus
FROM Mahasiswa m
WHERE m.status = 'lulus'
GROUP BY m.tahun_keluar
ORDER BY tahun_lulus;
--nico