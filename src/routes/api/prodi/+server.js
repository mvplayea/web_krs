import connection from '$lib/db.js';
import { json } from '@sveltejs/kit';
import { getParams } from '$lib/util';

// Create
export async function POST({ request }) {
  const { kd_prodi, nama_prodi } = await request.json();

  const result = await connection.query(
    `INSERT INTO prodi (kd_prodi, nama_prodi) VALUES (?, ?)`,
    [kd_prodi, nama_prodi]
  );

  return json({ result });
}

// Read
export async function GET({ url }) {
  const kd_prodi = await getParams(url, 'kd_prodi');
  if (kd_prodi) {
    const prodi = await connection.query(`SELECT * FROM prodi WHERE kd_prodi=${kd_prodi}`);
    return json({ prodi });
  } else {
    const prodi = await connection.query(`SELECT * FROM prodi`);
    return json({ prodi });
  }
}

// Update
export async function PUT({ request }) {
  const { kd_prodi, nama_prodi } = await request.json();

  const result = await connection.query(
    `UPDATE prodi SET nama_prodi = ? WHERE kd_prodi = ?`,
    [nama_prodi, kd_prodi]
  );

  return json({ result });
}

// Partially Update
export async function PATCH({ request }) {
  const { kd_prodi, nama_prodi } = await request.json();

  const result = await connection.query(
    `UPDATE prodi SET
      nama_prodi = COALESCE(?, nama_prodi)
    WHERE kd_prodi = ?`,
    [nama_prodi, kd_prodi]
  );

  return json({ result });
}

// Delete
export async function DELETE({ request }) {
  const { kd_prodi } = await request.json();

  const result = await connection.query(
    `DELETE FROM prodi WHERE kd_prodi = ?`,
    [kd_prodi]
  );

  return json({ result });
}