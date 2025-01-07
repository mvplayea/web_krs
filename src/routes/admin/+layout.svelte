<script>
    let {children} = $props();
</script>

<style>
    section {
        display: flex;
        justify-content: center;
        width: 100%;
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

    .icon {
        width: 20px;
        height: 20px;
        background-color: white; /* Placeholder for the icon */
        border-radius: 4px;
    }

    .content {
        padding: 20px;
        width: 100%;
        background-color: #763497;
        display: flex;
        justify-content: flex-start;
        align-items: center;
    }
</style>

<section>
    <div class="sidebar">
        <h2>Aetherion University</h2>
        <ul>
            <li><a href="/admin/mahasiswa">Manajemen Mahasiswa</a></li>
            <li><a href="/admin/matakuliah">Manajemen Mata Kuliah</a></li>
            <li><a href="/admin/jadwal">Manajemen Jadwal</a></li>
            <li><a href="/admin/prodi">Program Studi</a></li>
        </ul>
    </div>
    <div class="content">
        {@render children()}
    </div>
</section>
