import { json } from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET({ url }) {
  const mk = await connection.query(
    `SELECT *
    FROM mata_kuliah
    JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi`
  );
  
  return json({ mk });
}

//   Create
export async function POST() {

}

//   Update
export async function PUT() {

}

export async function PATCH() {

}

// delete
export async function DELETE() {

}
