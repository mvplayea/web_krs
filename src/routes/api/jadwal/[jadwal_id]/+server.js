import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET({params}) {
    const {jadwal_id} = params;

    const jadwal = await connection.query(
        `SELECT * FROM jadwal WHERE jadwal_id = ?`, [jadwal_id]
    );

    return json({jadwal});
}

export async function PUT({params, request}) {
    const {jadwal_id} = params; // Get the NIM from the route parameter
    const {kd_mk, waktu} = await request.json();

    try {
        const result = await connection.query(
            `UPDATE jadwal 
            SET kd_mk = ?, waktu = ? 
            WHERE jadwal_id = ?`,
            [kd_mk, waktu, jadwal_id]
        );

        return json({success: true, message: 'jadwal data updated successfully', result});
    } catch (error) {
        console.error(error);
        return json({success: false, message: 'Failed to update mahasiswa data', error}, {status: 500});
    }
}


export async function DELETE({params}) {
    const {jadwal_id} = params;

    try {
        const result = await connection.query(
            `DELETE FROM jadwal WHERE jadwal_id = ?`, [jadwal_id]
        );

        return json({success: true, message: 'jadwal data deleted successfully', result});
    } catch (error) {
        console.error(error);
        return json({success: false, message: 'Failed to delete jadwal data', error}, {status: 500});
    }
}
