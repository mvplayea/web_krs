import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET () {
  const mahasiswa = await connection.query('SELECT * FROM mahasiswa');
  
  return json({ mahasiswa });
}