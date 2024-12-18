import {json} from "@sveltejs/kit";
import connection from "$lib/db";

// Read
export async function GET() {
  const jadwal = await connection.query("SELECT * FROM jadwal");
  
  return json({jadwal});
}

//   Create
export async function POST() {

}

//   Update
export async function PUT() {

}

export async function PUT() {

}

// delete
export async function DELETE() {

}
