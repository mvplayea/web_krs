<script>
    import axios from "axios";
    import {onMount} from "svelte";

    let mahasiswaData;

    async function getDataMahasiswa() {
        try {
            const response = await axios.get('/api/mahasiswa');
            mahasiswaData = await response.data.mahasiswa[0];
        } catch (error) {
            console.error('Error:', error);
        }
    }

    onMount(async () => {
        await getDataMahasiswa();
    })
</script>

<div class="main">
    <h1>Manajemen Mahasiswa</h1>
    <a href="/admin/mahasiswa/create">
        <button class="button-input">+ Input Mahasiswa</button>
    </a>
    <!--    <div class="controls">-->
    <!--        <div class="show-entries">-->
    <!--            Show-->
    <!--            <select>-->
    <!--                <option value="10">10</option>-->
    <!--                <option value="25">25</option>-->
    <!--                <option value="50">50</option>-->
    <!--                <option value="100">100</option>-->
    <!--            </select>-->
    <!--            Entries-->
    <!--        </div>-->
    <!--    </div>-->
    {#if mahasiswaData}
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>NIM</th>
                    <th>Nama</th>
                    <th>Tanggal Lahir</th>
                    <th>Agama</th>
                    <th>Jenis Kelamin</th>
                    <th>Alamat</th>
                    <th>Kode Prodi</th>
                    <th>Semester ID</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                {#each mahasiswaData as mhs}
                    <tr>
                        <td>{mhs.NIM}</td>
                        <td>{mhs.nama_mahasiswa}</td>
                        <td>{new Date(mhs.tanggallahir).toLocaleDateString('id-Id')}</td>
                        <td>{mhs.agama}</td>
                        <td>{mhs.jenis_kelamin === 'L' ? 'Laki-laki' : 'Perempuan'}</td>
                        <td>{mhs.alamat}</td>
                        <td>{mhs.kd_prodi}</td>
                        <td>{mhs.semester_id}</td>
                        <td>
                            <button class="button-edit">
                                <a href="/admin/mahasiswa/edit/{mhs.NIM}" class="edit-btn">Edit</a>
                            </button>
                        </td>
                    </tr>
                {/each}
                </tbody>
            </table>
        </div>
    {/if}
    <div class="pagination">
        {#if mahasiswaData}
            <span>Showing {mahasiswaData.length} entries</span>
        {/if}
<!--        <div class="nav">-->
<!--            <a href="#">Previous</a>-->
<!--            <span>1</span>-->
<!--            <a href="#">Next</a>-->
<!--        </div>-->
    </div>
</div>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
    }

    .sidebar {
        width: 20%;
        background-color: #d3d3e1;
        height: 100vh;
        padding: 15px;
        box-sizing: border-box;
        float: left;
    }

    .sidebar h2 {
        margin: 0;
        margin-bottom: 20px;
        font-size: 20px;
        text-align: center;
        color: #000;
    }

    .sidebar ul {
        list-style-type: none;
        padding: 0;
    }

    .sidebar ul li {
        margin-bottom: 20px;
    }

    .sidebar ul li a {
        text-decoration: none;
        color: #000;
        padding: 5px;
        display: block;
        border-radius: 5px;
        transition: background-color 0.3s;
    }

    .sidebar ul li a:hover,
    .sidebar ul li a:active,
    .sidebar ul li a:focus {
        background-color: #763497;
        color: white;
    }


    .main {
        margin-left: 4em;
        padding: 20px;
        background-color: #763497;
        color: white;
        min-height: 100vh;
        box-sizing: border-box;
        width: 100%;
    }

    .main h1 {
        margin: 0;
        padding-bottom: 20px;
        font-weight: 100;
    }

    .controls {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
        margin-bottom: 20px;
        color: #ffffff;
    }

    .controls .show-entries, .controls .search {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 5px;
        padding: 5px;
        border-radius: 5px;
        color: white;
    }

    .controls select, .controls input {
        background-color: transparent;
        border: 1px solid white;
        color: rgb(255, 255, 255);
        padding: 5px;
        border-radius: 3px;
    }

    .button-input {
        background-color: #C2C8DA;
        color: #000000;
        padding: 10px 10px;
        width: 98%;
        border: none;
        cursor: pointer;
        border-radius: 5px;
        font-weight: bold;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: left;
        margin-bottom: 10px;
    }

    .table-container {
        margin-top: 20px;
        padding: 20px;
        border-radius: 10px;
        color: black;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        color: #ffffff;
    }

    table th, table td {
        padding: 10px;
        text-align: center;
        border: 1px solid #ddd;
    }

    .button-edit {
        text-decoration: none;
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        border-radius: 3px;
        margin-bottom: 3px;
    }

    .button-delete {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        border-radius: 3px;
    }

    .pagination {
        margin-top: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .pagination span {
        font-size: 14px;
        color: #FFFFFF;
    }

    .pagination .nav {
        display: flex;
        gap: 5px;
    }

    .pagination .nav a {
        color: #FFFFFF;
        text-decoration: none;
    }
</style>

<!--<style>-->
<!--    .container {-->
<!--        padding: 20px;-->
<!--        max-width: 1200px;-->
<!--        margin: 0 auto;-->
<!--    }-->

<!--    h1 {-->
<!--        margin-bottom: 20px;-->
<!--        font-size: 24px;-->
<!--    }-->

<!--    .table-wrapper {-->
<!--        overflow-x: auto;-->
<!--    }-->

<!--    table {-->
<!--        width: 100%;-->
<!--        border-collapse: collapse;-->
<!--        margin-top: 20px;-->
<!--    }-->

<!--    th, td {-->
<!--        border: 1px solid #ddd;-->
<!--        padding: 12px;-->
<!--        text-align: left;-->
<!--    }-->

<!--    th {-->
<!--        background-color: #f4f4f4;-->
<!--        font-weight: bold;-->
<!--    }-->

<!--    tr:nth-child(even) {-->
<!--        background-color: #f8f8f8;-->
<!--    }-->

<!--    tr:hover {-->
<!--        background-color: #f5f5f5;-->
<!--    }-->

<!--    .edit-btn {-->
<!--        display: inline-block;-->
<!--        padding: 8px 16px;-->
<!--        background-color: #4CAF50;-->
<!--        color: white;-->
<!--        text-decoration: none;-->
<!--        border-radius: 4px;-->
<!--        text-align: center;-->
<!--    }-->

<!--    .edit-btn:hover {-->
<!--        background-color: #45a049;-->
<!--    }-->

<!--    @media (max-width: 768px) {-->
<!--        .container {-->
<!--            padding: 10px;-->
<!--        }-->

<!--        th, td {-->
<!--            padding: 8px;-->
<!--            font-size: 14px;-->
<!--        }-->
<!--    }-->
<!--</style>-->