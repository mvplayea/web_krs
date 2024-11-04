import { json } from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET({ url }) {
	const nim = url.searchParams.get('nim');

	const mahasiswa = await connection.query(
		`SELECT *
    FROM KRS
    JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
    JOIN Mata_Kuliah ON KRS.kd_mk = Mata_Kuliah.kd_mk
    WHERE Mahasiswa.NIM = ${nim}`
  );

	return json({ mahasiswa });
}
