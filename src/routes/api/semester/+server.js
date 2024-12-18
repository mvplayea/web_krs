import connection from "$lib/db.js";
import {json} from "@sveltejs/kit";

export async function GET() {
  const semester = await connection.query(
    `SELECT *
    FROM semester`
  );
  
  return json({ semester });
}
