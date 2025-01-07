<script>
    import axios from 'axios';
    import {onMount} from 'svelte';
    import {getUser} from "$lib/util.js";

    let user;
    let dataMK = [];
    let dataKRS = [];

    const getDataMataKuliah = async () => {
        const params = {
            nim: user.NIM,
        }

        try {
            const response = await axios.get('http://localhost:5173/api/krs/matkul', {params});
            if (response.data) {
                return response.data.matakuliah;
            }
        } catch (error) {
            console.error(error);
        }
    };

    const getDataKRS = async () => {
        const params = {
            nim: user.NIM,
        }

        try {
            const response = await axios.get('http://localhost:5173/api/krs', {params});
            if (response.data) {
                return response.data.krs[0];
            }
        } catch (err) {
            console.error(err);
        }
    }

    const handleCheckboxChange = (kd_mk) => {
        dataMK = dataMK.map(mk => {
            if (mk.kd_mk === kd_mk) {
                return {
                    ...mk,
                    checked: !mk.checked
                }
            }
            return mk
        })
    }

    const saveKRS = async () => {
        const selectedMK = dataMK.filter(mk => mk.checked);
        const payload = {
            nim: user.NIM,
            matakuliah: selectedMK,
        }

        try {
            const response = await axios.post('http://localhost:5173/api/krs', {
                ...payload,
            });
            console.log(response.data);
        } catch (error) {
            console.error(error);
        } finally {
            window.location.reload();
        }

    };

    const deleteKRS = async (kd_krs, kd_mk) => {
        const params = {
            kd_krs,
            kd_mk,
        }

        try {
            const response = await axios.delete('http://localhost:5173/api/krs', {params});
            console.log(response.data);
        } catch (error) {
            console.error(error);
        } finally {
            window.location.reload();
        }
    };

    onMount(async () => {
        user = getUser(localStorage);
        dataMK = await getDataMataKuliah();
        dataKRS = await getDataKRS();
        console.log(dataMK)
        console.log(dataKRS)
    });
</script>

<section>
    <!-- Lihat KRS (di bawah menu Beranda) -->

    <!-- Notification -->
    <div class="notification">
        <div class="left">PERHATIAN!</div>
        <div class="middle">Sistem KRS anda belum tervalidasi</div>
        <div class="right">Jika KRS belum tervalidasi, maka mahasiswa tidak dapat mengikuti perkuliahan</div>
    </div>
    <div class="notification-footer">
        Silahkan memilih kelas perkuliahan terlebih dahulu
    </div>

    <!--  KRS ANDAJ-->

    <!-- Main Content -->
    <div class="container">
        <h1>KRS ANDA</h1>
        <table>
            <thead>
            <tr>
                <th>Kode</th>
                <th>Nama Matakuliah</th>
                <th>SKS</th>
                <th>Jenis Kelas</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            {#each dataKRS as krs}
                <tr id={krs.nim}>
                    <td>{krs.kd_mk}</td>
                    <td>{krs.matakuliah}</td>
                    <td>{krs.SKS}</td>
                    <td>TATAP MUKA</td>
                    <td>
                        <button onclick={() => deleteKRS(krs.kd_krs, krs.kd_mk)} class="btn-save-krs">
                            <a href="#" class="btn-submit">Hapus</a>
                        </button>
                    </td>
                </tr>
            {/each}
            </tbody>
        </table>

        <h2>Pilihan Kelas Perkuliahan</h2>
        <hr class="hr-divider">
        <h3>Semester Satu <span class="semester-info">Semester Ganjil 2024-2025</span></h3>
        <table>
            <thead>
            <tr>
                <th></th>
                <th>Kode</th>
                <th>Nama Matakuliah</th>
                <th>SKS</th>
                <th>Jadwal Perkuliahan</th>
                <th>Jenis Kelas</th>
            </tr>
            </thead>
            <tbody>
            {#each dataMK as mk}
                <tr id={mk.kd_mk}>
                    <td><input type="checkbox" checked={mk.selected} onchange={() => handleCheckboxChange(mk.kd_mk)}>
                    </td>
                    <td>{mk.kd_mk}</td>
                    <td>{mk.matakuliah}</td>
                    <td>{mk.SKS}</td>
                    <td>{mk.jadwal}</td>
                    <td>TATAP MUKA</td>
                </tr>
            {/each}
            </tbody>
        </table>
        <button onclick={saveKRS()} class="btn-save-krs">
            <a href="#" class="btn-submit">Ambil Mata Kuliah</a>
        </button>

        <!-- Buttons Container -->
        <div class="buttons-container">
            <button class="btn-exit" onclick={() => alert('click')}>KEMBALI</button>
        </div>
    </div>
</section>

<style>
    /* Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    section {
        font-family: Arial, sans-serif;
        background-color: #C2C8DA;
        color: #333;
        height: 120vh;
        padding-top: 3em;
    }

    /* Header */
    .header {
        background-color: #763497;
        color: white;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .header .logo {
        font-size: 1.5rem;
        color: #C2C8DA;
    }

    .header .menu {
        display: flex;
        justify-content: center;
        gap: 20px;
        flex: 2;
    }

    .header .menu a {
        color: white;
        text-decoration: none;
        padding: 5px 10px;
        border-radius: 5px;
        transition: background-color 0.3s;
    }

    .header .menu a:hover {
        background-color: #C2C8DA;
    }

    /* Lihat KRS (di bawah menu Beranda) */
    .btn-lihat-krs {
        display: block;
        text-align: center;
        background-color: #D9D9D9;
        color: #000000;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
        font-size: 0.9rem;
        position: absolute;
        right: 10px;
        top: 80px;
        transition: background-color 0.3s;
    }

    .btn-lihat-krs:hover {
        background-color: #5a276c;
    }

    .btn-save-krs {
        border: none;
        padding: 0;
        background-color: transparent;
    }

    /* Notification */
    .notification {
        display: flex;
        align-items: center;
        border: 1px solid #ccc;
        background-color: #fff;
        padding: 10px;
        max-width: 600px;
        margin: 50px auto 10px auto;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .notification div {
        padding: 10px;
        text-align: center;
    }

    .notification .left {
        background-color: #fff;
        font-weight: bold;
        flex: 1;
        border-right: 1px solid #ccc;
    }

    .notification .middle {
        background-color: #D3A7E9;
        flex: 2;
        color: #000000;
        font-weight: bold;
    }

    .notification .right {
        background-color: #fff;
        color: #721c24;
        flex: 3;
        font-size: 14px;
    }

    .notification-footer {
        text-align: center;
        font-size: 12px;
        color: #555;
        margin-top: 10px;
    }

    /* Main Container */
    .container {
        background-color: #C2C8DA;
        padding: 20px;
        border-radius: 8px;
        margin: 20px auto;
        max-width: 1200px;
    }

    .container h2 {
        margin-bottom: 20px;
        color: black;
    }

    .container h3 {
        margin-bottom: 10px;
        font-size: 1rem;
        color: #333;
        font-weight: normal;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .hr-divider {
        border: 1px solid #000000;
        margin: 20px 0;
    }

    .semester-info {
        font-size: 1rem;
        color: #333;
        font-weight: normal;
        margin-left: auto; /* Push the semester-info to the right */
    }

    .container p {
        font-size: 0.9rem;
        margin-bottom: 10px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    table th, table td {
        border: 1px solid black;
        text-align: center;
        padding: 10px;
        color: black; /* Semua teks di tabel menjadi hitam */
    }

    table th {
        background-color: #C2C8DA;
        color: black;
    }

    table tr:nth-child(even) {
        background-color: #C2C8DA;
    }

    table tr:hover {
        background-color: #C2C8DA;
    }

    .btn-submit {
        display: block;
        background-color: #763497;
        color: white;
        text-align: center;
        padding: 15px;
        border-radius: 5px;
        text-decoration: none;
        width: 100%;
        margin: 5px auto 0 auto;
        font-size: 1rem;
        transition: background-color 0.3s;
    }

    .btn-submit:hover {
        background-color: #5a276c;
    }

    .buttons-container {
        text-decoration: none;
        display: flex;
        flex-direction: column;
        align-items: flex-end;
    }

    /* Exit Button */
    .btn-exit {
        background-color: #000;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        font-size: 0.9rem;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-top: 10px;
    }

    .btn-exit:hover {
        background-color: #5f3559;
    }

</style>