import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET () {
  const temp = await connection.query('SELECT * FROM users WHERE user_type_value = 2');
  
  return json({ message: 'GET /dashboard', temp });
}