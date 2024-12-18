import { json } from '@sveltejs/kit';
import connection from '$lib/db';

// Create
export async function POST({request}) {
  const { NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id} = await request.json();
  
  const result = await connection.query(
    `INSERT INTO mahasiswa (NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [NIM, nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id]
  );
  
  return json({ result });
}

// Read
export async function GET({ url }) {
  // const nim = url.searchParams.get('nim');
  
  const mahasiswa = await connection.query(
    `SELECT * FROM mahasiswa`
  );
  
  return json({ mahasiswa });
}

//   Update
export async function PUT() {

}

export async function PATCH() {

}

// delete
export async function DELETE() {

}
