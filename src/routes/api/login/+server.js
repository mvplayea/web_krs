import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET() {
  const mhs = await connection.query("SELECT * FROM MAHASISWA")

  return json({data: mhs})
}

export async function POST({request}) {
  const {username, password} = await request.json();

  const mhs = await connection.query(`
  SELECT * FROM Mahasiswa
  WHERE Mahasiswa.NIM = ?`,
    [username]);

  return json({mahasiswa: mhs[0]});
}

//   Update
export async function PUT() {

}

export async function PATCH() {

}

// delete
export async function DELETE() {

}
