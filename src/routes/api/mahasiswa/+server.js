import { json } from '@sveltejs/kit';
import connection from '$lib/db';

// Create
export async function POST({ request }) {
  const { NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id } = await request.json();

  const result = await connection.query(
    `INSERT INTO mahasiswa (NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id]
  );

  return json({ result });
}

// Read
export async function GET({ url }) {
  const mahasiswa = await connection.query(
    `SELECT * FROM mahasiswa`
  );

  return json({ mahasiswa });
}

// Update
export async function PUT({ request }) {
  const { NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id } = await request.json();

  const result = await connection.query(
    `UPDATE mahasiswa SET nama_mahasiswa = ?, tanggallahir = ?, agama = ?, jenis_kelamin = ?, alamat = ?, kd_prodi = ?, semester_id = ? WHERE NIM = ?`,
    [nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id, NIM]
  );

  return json({ result });
}

// Partially Update
export async function PATCH({ request }) {
  const { NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id } = await request.json();

  const result = await connection.query(
    `UPDATE mahasiswa SET
      nama_mahasiswa = COALESCE(?, nama_mahasiswa),
      tanggallahir = COALESCE(?, tanggallahir),
      agama = COALESCE(?, agama),
      jenis_kelamin = COALESCE(?, jenis_kelamin),
      alamat = COALESCE(?, alamat),
      kd_prodi = COALESCE(?, kd_prodi),
      semester_id = COALESCE(?, semester_id)
    WHERE NIM = ?`,
    [nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id, NIM]
  );

  return json({ result });
}

// Delete
export async function DELETE({ request }) {
  const { NIM } = await request.json();

  const result = await connection.query(
    `DELETE FROM mahasiswa WHERE NIM = ?`,
    [NIM]
  );

  return json({ result });
}