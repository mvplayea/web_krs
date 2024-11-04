import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET () {
  const mahasiswa = await connection.query("SELECT * FROM Mahasiswa WHERE Mahasiswa.NIM = 'A00005'");
  
  return json({ mahasiswa });
}