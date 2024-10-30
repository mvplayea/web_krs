import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET () {
  const krs = await connection.query('SELECT * FROM krs');
  
  return json({ krs });
}