import {json} from "@sveltejs/kit";
import connection from "$lib/db";

export async function GET() {
  const jadwal = await connection.query("SELECT * FROM jadwal");
  
  return json({ jadwal });
}