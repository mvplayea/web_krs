import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET () {
  const krs = await connection.query("SELECT * FROM KRS JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM WHERE Mahasiswa.NIM = 'A00002'");
  
  return json({ krs });
}