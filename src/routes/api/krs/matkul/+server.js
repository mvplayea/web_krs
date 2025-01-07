import {getParams} from "$lib/util.js";
import connection from '$lib/db';
import {json} from '@sveltejs/kit';

export async function GET({url}) {
  try {
    const nim = await getParams(url, 'nim');
    
    const [result] = await connection.query(
      `SELECT m.semester_id, m.kd_prodi, k.kd_krs, GROUP_CONCAT(km.kd_mk) AS enrolled_mks
      FROM mahasiswa m
      LEFT JOIN krs k ON m.NIM = k.NIM
      LEFT JOIN krs_mk km ON k.kd_krs = km.kd_krs
      WHERE m.NIM = ?
      GROUP BY m.semester_id, m.kd_prodi, k.kd_krs`,
      [nim]
    );
    
    const { semester_id, kd_prodi, enrolled_mks } = result[0] || {};
    
    // Wrap each kd_mk in quotes if there are enrolled courses
    const excludedMks = enrolled_mks
      ? enrolled_mks.split(',').map(mk => `'${mk}'`).join(',')
      : '';
    
    const query = `
      SELECT *
      FROM mata_kuliah
      WHERE semester_id = ?
      AND kd_prodi = ?
      ${excludedMks ? `AND kd_mk NOT IN (${excludedMks})` : ''}
    `;
    
    const [matakuliah] = await connection.query(query, [semester_id, kd_prodi]);
    
    return json({ matakuliah });
    
  } catch (error) {
    console.log(error)
    return json({ error: error.message }, { status: 500 });
  }
}