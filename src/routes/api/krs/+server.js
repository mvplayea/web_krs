import {json} from '@sveltejs/kit';
import connection from '$lib/db';

export async function GET({url}) {
  const nim = url.searchParams.get('nim');
  
  const mahasiswa = await connection.query(
    `SELECT *
    FROM krs_mk
    JOIN KRS on KRS.kd_krs = krs_mk.kd_krs
    JOIN Mata_Kuliah ON krs_mk.kd_mk = Mata_Kuliah.kd_mk
    JOIN Mahasiswa ON KRS.NIM = Mahasiswa.NIM
    JOIN Prodi on Mahasiswa.kd_prodi = Prodi.kd_prodi
    JOIN Semester ON Mahasiswa.semester_id = Semester.semester_id
    JOIN Jadwal ON Mata_Kuliah.kd_mk = Jadwal.kd_mk
    WHERE Mahasiswa.NIM = '${nim}'`
  );
  
  return json({krs: {...mahasiswa}});
}

export async function POST(request) {
  const {kd_krs, kd_mk, NIM} = request.body;
  
  const krs = await connection.query(
    `INSERT INTO krs (kd_krs, kd_mk, NIM) VALUES ('${kd_krs}', '${kd_mk}', '${NIM}')`
  )
  
  return json({krs: {...krs}})
}

//   Update
export async function PUT() {

}

export async function PUT() {

}

// delete
export async function DELETE() {

}
