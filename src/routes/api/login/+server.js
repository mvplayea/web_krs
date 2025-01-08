import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET() {
    const mhs = await connection.query("SELECT * FROM MAHASISWA")

    return json({data: mhs})
}

export async function POST({request}) {
    const {username, password} = await request.json();

    if (username !== password) {
        return json({message: 'Salah'}, {status: 404});
    }

    const mhs = await connection.query(`
  SELECT * FROM Mahasiswa
  JOIN Prodi ON Mahasiswa.kd_prodi = Prodi.kd_prodi
  WHERE Mahasiswa.NIM = ?`, [username]);

    if (mhs[0].length === 0) {
        return json({message: 'NIM tidak ditemukan'}, {status: 404});
    }
    return json({mahasiswa: mhs[0]});
}

//   Update
export async function PUT() {

}

export async function PATCH() {

}

// delete
export async function DELETE() {

}
