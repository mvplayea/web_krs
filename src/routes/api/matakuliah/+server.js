import {json} from '@sveltejs/kit';
import connection from '$lib/db';
import {getParams} from "$lib/util.js";

// Create
export async function POST({request}) {
    const {kd_mk, matakuliah, SKS, semester_id, kd_prodi} = await request.json();

    const result = await connection.query(
        `INSERT INTO mata_kuliah (kd_mk, matakuliah, SKS, semester_id, kd_prodi)
    VALUES (?, ?, ?, ?, ?)`,
        [kd_mk, matakuliah, SKS, semester_id, kd_prodi]
    );

    return json({result});
}

// Read
export async function GET({url}) {
    const semester = await getParams(url, 'semester');
    const prodi = await getParams(url, 'prodi');
    const page = await getParams(url, 'page');

    const pageNumber = page ? parseInt(page) : 0;  // Default to page 1

    const matakuliah = await connection.query(
        `CALL GetMataKuliah(?, ?, ?)`,
        [semester, prodi, pageNumber]
    );

    return json({matakuliah: matakuliah[0]});
}


// Update
export async function PUT({request}) {
    const {kd_mk, matakuliah, SKS, semester_id, kd_prodi} = await request.json();

    const result = await connection.query(
        `UPDATE mata_kuliah SET matakuliah = ?, SKS = ?, semester_id = ?, kd_prodi = ? WHERE kd_mk = ?`,
        [matakuliah, SKS, semester_id, kd_prodi, kd_mk]
    );

    return json({result});
}

// Partially Update
export async function PATCH({request}) {
    const {kd_mk, matakuliah, SKS, semester_id, kd_prodi} = await request.json();

    const result = await connection.query(
        `UPDATE mata_kuliah SET
      matakuliah = COALESCE(?, matakuliah),
      SKS = COALESCE(?, SKS),
      semester_id = COALESCE(?, semester_id),
      kd_prodi = COALESCE(?, kd_prodi)
    WHERE kd_mk = ?`,
        [matakuliah, SKS, semester_id, kd_prodi, kd_mk]
    );

    return json({result});
}

// Delete
export async function DELETE({request}) {
    const {kd_mk} = await request.json();

    const result = await connection.query(
        `DELETE FROM mata_kuliah WHERE kd_mk = ?`,
        [kd_mk]
    );

    return json({result});
}