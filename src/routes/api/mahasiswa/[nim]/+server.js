import { json } from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET({params}) {
  const {nim} = params;
  
  const mahasiswa = await connection.query(
    `SELECT * FROM mahasiswa WHERE NIM = ?`, [nim]
  );
  
  return json({ mahasiswa });
}

export async function PUT({ params, request }) {
  const { nim } = params; // Get the NIM from the route parameter
  const {
    nama_mahasiswa,
    tanggallahir,
    agama,
    jenis_kelamin,
    alamat,
    kd_prodi,
    semester_id
  } = await request.json();
  
  try {
    const result = await connection.query(
      `UPDATE mahasiswa
      SET nama_mahasiswa = ?, tanggallahir = ?, agama = ?, jenis_kelamin = ?, alamat = ?, kd_prodi = ?, semester_id = ?
      WHERE NIM = ?`,
      [nama_mahasiswa, tanggallahir, agama, jenis_kelamin, alamat, kd_prodi, semester_id, nim]
    );
    
    return json({ success: true, message: 'Mahasiswa data updated successfully', result });
  } catch (error) {
    console.error(error);
    return json({ success: false, message: 'Failed to update mahasiswa data', error }, { status: 500 });
  }
}

