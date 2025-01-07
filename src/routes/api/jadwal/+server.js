import {json} from "@sveltejs/kit";
import connection from "$lib/db";
import {getParams} from "$lib/util.js";

// Read
export async function GET({url}) {
    const [jadwal] = await connection.query(
        `SELECT j.* FROM Jadwal j
    LEFT JOIN mata_kuliah mk ON j.kd_mk = mk.kd_mk`
    );

    return json({jadwal});
}

//   Create
export async function POST({request}) {
    const {
        kd_mk,
        waktu,
    } = await request.json();

    try {
        await connection.query(
            `CALL InsertJadwal(?, ?)`,
            [kd_mk, waktu]
        );

        return json({success: true, message: 'Jadwal data created successfully'});
    } catch (error) {
        console.error(error);
        return json({success: false, message: 'Failed to create jadwal data', error}, {status: 500});
    }
}

//   Update
export async function PUT() {

}

export async function PUT() {

}

// delete
export async function DELETE() {

}
