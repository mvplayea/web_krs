import {json} from '@sveltejs/kit';
import connection from '$lib/db';
import {getParams} from "$lib/util.js";

export async function GET({url}) {
    const semester_id = await getParams(url, 'semester_id');

    const matakuliah = await connection.query(
        `SELECT * FROM mata_kuliah where semester_id = ?`, [semester_id]
    );

    return json({matakuliah});
}
