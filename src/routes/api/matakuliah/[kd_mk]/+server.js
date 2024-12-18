import { json } from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET({params}) {
  const {kd_mk} = params;
  
  const matakuliah = await connection.query(
    `SELECT * FROM mata_kuliah WHERE kd_mk = ?`, [kd_mk]
  );
  
  return json({ matakuliah });
}

export async function PUT({ params, request }) {
  const { kd_mk } = params; // Get the NIM from the route parameter
  const { matakuliah, SKS, semester_id, kd_prodi} = await request.json();
  
  try {
    const result = await connection.query(
      `UPDATE mata_kuliah
      SET matakuliah = ?, SKS = ?, semester_id = ?, kd_prodi = ?
      WHERE kd_Mk = ?`,
      [matakuliah, SKS, semester_id, kd_prodi, kd_mk]
    );
    
    return json({ success: true, message: 'Matakuliah data updated successfully', result });
  } catch (error) {
    console.error(error);
    return json({ success: false, message: 'Failed to update mahasiswa data', error }, { status: 500 });
  }
}


export async function DELETE({ params }) {
  const { kd_mk } = params;
  
  try {
    const result = await connection.query(
      `DELETE FROM mata_kuliah WHERE kd_mk = ?`, [kd_mk]
    );
    
    return json({ success: true, message: 'Matakuliah data deleted successfully', result });
  } catch (error) {
    console.error(error);
    return json({ success: false, message: 'Failed to delete matakuliah data', error }, { status: 500 });
  }
}