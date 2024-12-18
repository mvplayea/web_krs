import connection from "$lib/db.js";
import {json} from "@sveltejs/kit";

export async function GET({ url }) {
  const nim = url.searchParams.get('nim');
  
  const prodi = await connection.query(
    `SELECT kd_prodi, nama_prodi
    FROM prodi`
  );
  
  return json({ prodi });
}
