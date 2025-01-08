import { json } from '@sveltejs/kit';
import connection from '$lib/db';
import {getParams} from "$lib/util.js";

// GET method
export async function GET({ url }) {
  const nim = url.searchParams.get('nim');

  const mahasiswa = await connection.query(
    `SELECT *
    FROM krs_mk
    LEFT JOIN KRS on KRS.kd_krs = krs_mk.kd_krs
    LEFT JOIN Mata_Kuliah ON krs_mk.kd_mk = Mata_Kuliah.kd_mk
    LEFT JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
    WHERE Mahasiswa.NIM = '${nim}'`
  );

  return json({ krs: { ...mahasiswa } });
}

// POST method
export async function POST({ request }) {
    const { matakuliah, nim } = await request.json();

    for (const mk of matakuliah) {
        const { kd_mk } = mk;

        await connection.query(
            `CALL InsertKRS_MK(?, ?)`,
            [nim, kd_mk]
        );
    }

    return json({ message: 'success' });
}

// PUT method
export async function PUT({ request }) {
  const { kd_krs, kd_mk, NIM } = await request.json();

  const result = await connection.query(
    `UPDATE krs SET kd_mk = ?, NIM = ? WHERE kd_krs = ?`,
    [kd_mk, NIM, kd_krs]
  );

  return json({ result });
}

// PATCH method
export async function PATCH({ request }) {
  const { kd_krs, kd_mk, NIM } = await request.json();

  const result = await connection.query(
    `UPDATE krs SET kd_mk = COALESCE(?, kd_mk), NIM = COALESCE(?, NIM) WHERE kd_krs = ?`,
    [kd_mk, NIM, kd_krs]
  );

  return json({ result });
}

// DELETE method
export async function DELETE({ url }) {
  const kd_krs = await getParams(url, 'kd_krs');
    const kd_mk = await getParams(url, 'kd_mk');

  const result = await connection.query(
    `DELETE FROM krs_mk WHERE kd_krs = ? AND kd_mk = ?`,
    [kd_krs, kd_mk]
  );

  return json({ result });
}