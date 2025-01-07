import { json } from '@sveltejs/kit';
import connection from '$lib/db';

// GET method
export async function GET({ url }) {
  const nim = url.searchParams.get('nim');

  const mahasiswa = await connection.query(
    `SELECT *
    FROM krs_mk
    JOIN KRS on KRS.kd_krs = krs_mk.kd_krs
    JOIN Mata_Kuliah ON krs_mk.kd_mk = Mata_Kuliah.kd_mk
    JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
    JOIN Prodi on Mahasiswa.kd_prodi = Prodi.kd_prodi
    JOIN Semester ON Mahasiswa.semester_id = Semester.semester_id
    JOIN Jadwal ON Mata_Kuliah.kd_mk = Jadwal.kd_mk
    WHERE Mahasiswa.NIM = '${nim}'`
  );

  return json({ krs: { ...mahasiswa } });
}

// POST method
export async function POST({ request }) {
  const { matakuliah, nim } = await request.json();
  
  const existingKRS = await connection.query(
    `SELECT kd_krs FROM KRS WHERE nim = ?`,
    [nim]
  );
  
  // Check if KRS already exists
  let kd_krs;
  if (existingKRS[0].length <= 0) {
    kd_krs = "KRS" + nim;
    await connection.query(
      `INSERT INTO KRS (kd_krs, NIM) VALUES (?, ?)`,
      [kd_krs, nim]
    );
  } else {
    kd_krs = existingKRS[0][0]?.kd_krs;
  }
  
  matakuliah.forEach(async (mk) => {
    const { kd_mk } = mk;
    
    await connection.query(
      `INSERT INTO krs_mk (kd_krs, kd_mk) VALUES (?, ?)`,
      [kd_krs, kd_mk]
    );
  });
  
  return json({ message: 'success' });
}

// PUT method
export async function PUT({ request }) {
  const { kd_krs, kd_mk, NIM } = await request.json();

  const result = await connection.query(
    `UPDATE krs SET kd_mk = ?, NIM = ? WHERE kd_krs = ?`,
    [kd_mk, NIM, kd_krs]
  );

  return json({ result });
}

// PATCH method
export async function PATCH({ request }) {
  const { kd_krs, kd_mk, NIM } = await request.json();

  const result = await connection.query(
    `UPDATE krs SET kd_mk = COALESCE(?, kd_mk), NIM = COALESCE(?, NIM) WHERE kd_krs = ?`,
    [kd_mk, NIM, kd_krs]
  );

  return json({ result });
}

// DELETE method
export async function DELETE({ request }) {
  const { kd_krs } = await request.json();

  const result = await connection.query(
    `DELETE FROM krs WHERE kd_krs = ?`,
    [kd_krs]
  );

  return json({ result });
}