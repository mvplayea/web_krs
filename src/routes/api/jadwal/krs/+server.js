import {json} from "@sveltejs/kit";
import connection from "$lib/db.js";
import {getParams} from "$lib/util.js";

// Read
export async function GET({url}) {
    const nim = await getParams(url, 'nim');

    console.log(nim)
    const [jadwal] = await connection.query(
        `SELECT j.*
       FROM Jadwal j
       JOIN krs_mk km ON j.kd_mk = km.kd_mk
       JOIN krs k ON km.kd_krs = k.kd_krs
       WHERE k.NIM = ?`,
        [nim]
    );

    return json({ jadwal });
}

