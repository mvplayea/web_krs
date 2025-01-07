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
  const {semester} = getParams(url, 'semester');
  const {prodi} = getParams(url, 'prodi');
  
  if (semester && prodi) {
    const matakuliah = await connection.query(
      `SELECT *
      FROM mata_kuliah
      JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi
      WHERE semester_id = ? AND mata_kuliah.kd_prodi = ?`,
      [semester, prodi]
    );
    
    return json({matakuliah});
  } else {
    const matakuliah = await connection.query(
      `SELECT *
    FROM mata_kuliah
    JOIN prodi ON mata_kuliah.kd_prodi = prodi.kd_prodi`
    );
    
    return json({matakuliah});
  }
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