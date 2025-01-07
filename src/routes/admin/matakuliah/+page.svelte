<script>
    import axios from "axios";
    import {onMount} from "svelte";

    let matakuliahData;

    async function getDataMatakuliah() {
        try {
            const response = await axios.get('/api/matakuliah');
            matakuliahData = await response.data.matakuliah[0];
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function deleteMatakuliah(kd_mk) {
        try {
            const response = await axios.delete(`/api/matakuliah/${kd_mk}`);
            alert(response.data.message);
            window.location.reload();
        } catch (error) {
            console.error('Error:', error);
        }
    }

    onMount(async () => {
        await getDataMatakuliah();
    })
</script>

<div class="main">
    <h1>Manajemen Matakuliah</h1>
    <a href="/admin/matakuliah/create">
        <button class="button-input">+ Input Matakuliah</button>
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
    {#if matakuliahData}
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Kode MK</th>
                    <th>Matakuliah</th>
                    <th>SKS</th>
                    <th>KD Prodi</th>
                    <th>Semester</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                {#each matakuliahData as mk}
                    <tr>
                        <td>{mk.kd_mk}</td>
                        <td>{mk.matakuliah}</td>
                        <td>{mk.sks}</td>
                        <td>{mk.kd_prodi}</td>
                        <td>{mk.semester_id}</td>
                        <td class="btn-container">
                            <a href="/admin/matakuliah/edit/{mk.kd_mk}" class="button-edit">Edit</a>
                            <button on:click={() => deleteMatakuliah(mk.kd_mk)} class="button-delete">Hapus</button>
                        </td>
                    </tr>
                {/each}
                </tbody>
            </table>
        </div>
    {/if}
    <div class="pagination">
        {#if matakuliahData}
            <span>Showing {matakuliahData.length} entries</span>
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
        height: 100vh;
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

