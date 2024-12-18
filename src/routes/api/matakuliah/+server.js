import { json } from '@sveltejs/kit';
import connection from '$lib/db';


//   Create
export async function POST({request}) {
  const { kd_mk, matakuliah, SKS, semester_id, kd_prodi} = await request.json();
  
  const result = await connection.query(
    `INSERT INTO mata_kuliah (kd_mk, matakuliah, SKS, semester_id, kd_prodi)
    VALUES (?, ?, ?, ?, ?)`,
    [kd_mk, matakuliah, SKS, semester_id, kd_prodi]
  );
  
  return json({ result });
}

// read
export async function GET({ url }) {
  const matakuliah = await connection.query(
    `SELECT *
    FROM mata_kuliah
    JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi`
  );
  
  return json({ matakuliah });
}

//   Update
export async function PUT() {

}

export async function PATCH() {

}

// delete
export async function DELETE() {

}
