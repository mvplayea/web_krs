import connection from '$lib/db.js';
import { json } from '@sveltejs/kit';
import { getParams } from '$lib/util';

export async function GET({ url }) {
	const kd_prodi = await getParams(url, 'kd_prodi');
	if (kd_prodi) {
		const prodi = await connection.query(`select * from prodi where kd_prodi=${kd_prodi}`);
		return json({ prodi });
	} else {
		const prodi = await connection.query(`select * from prodi`);
		return json({ prodi });
	}
}
