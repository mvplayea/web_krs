<script>
  import axios from 'axios';
  import {onMount} from 'svelte';
  
  let page = 1;
  let jadwalData;
  let semester;
  let prodi;
  
  async function getDataJadwal() {
    const params = {
      page,
      semester,
      prodi,
    }
    try {
      const response = await axios.get('/api/jadwal', {params});
      jadwalData = await response.data.jadwal[0];
    } catch (error) {
      console.error('Error:', error);
    }
  }
  
  async function deleteJadwal(jadwal_id) {
    const isConfirmed = confirm('Apakah anda yakin ingin menghapus data ini?');
    if (!isConfirmed) {
      try {
        const response = await axios.delete(`/api/jadwal/${jadwal_id}`);
        alert(response.data.message);
        window.location.reload();
      } catch (error) {
        console.error('Error:', error);
      }
    }
  }
  
  function nextPage() {
    page++;
    getDataJadwal();
  }
  
  function prevPage() {
    if (page > 1) {
      page--;
      getDataJadwal();
    }
  }
  
  function setSemester(event) {
    semester = event.target.value;
    getDataJadwal()
  }
  
  function setProdi(event) {
    prodi = event.target.value;
    getDataJadwal()
  }
  
  onMount(async () => {
    console.log('halo');
    await getDataJadwal();
  });
</script>

<div class="main">
  <h1>Manajemen Jadwal</h1>
  <a href="/admin/jadwal/create">
    <button class="button-input">+ Input Jadwal</button>
  </a>
  <div class="controls">
    <label for="semester">Semester</label>
    <select id="semester" name="semester" onchange={setSemester}>
      <option value="">Pilih Semester</option>
      <option value="1">Semester 1</option>
      <option value="2">Semester 2</option>
      <option value="3">Semester 3</option>
      <option value="4">Semester 4</option>
      <option value="5">Semester 5</option>
      <option value="6">Semester 6</option>
      <option value="7">Semester 7</option>
      <option value="8">Semester 8</option>
    </select>
    <label for="semester">Prodi</label>
    <select id="prodi" name="prodi" onchange={setProdi}>
      <option value="">Pilih Prodi</option>
      <option value="0801">Teknik Informatika</option>
      <option value="0802">Sistem Informasi</option>
    </select>
  </div>
  {#if jadwalData}
    <div class="table-container">
      <table>
        <thead>
        <tr>
          <th>Kode Jadwal</th>
          <th>Kode Mata Kuliah</th>
          <th>Mata Kuliah</th>
          <th>Waktu</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        {#each jadwalData as jd}
          <tr>
            <td>{jd.jadwal_id}</td>
            <td>{jd.kd_mk}</td>
            <td>{jd.matakuliah}</td>
            <td>{new Date(jd.waktu).toLocaleDateString('id-ID')}</td>
            <td class="btn-container">
              <a href="/admin/jadwal/edit/{jd.jadwal_id}" class="button-edit">Edit</a>
              <button onclick={() => deleteJadwal(jd.jadwal_id)} class="button-delete">Hapus</button>
            </td>
          </tr>
        {/each}
        </tbody>
      </table>
    </div>
  {/if}
  <div class="pagination">
    {#if jadwalData}
      <span>Showing {jadwalData.length} entries</span>
    {/if}
    <div class="nav">
      <button onclick={prevPage}>Previous</button>
      <span>{page}</span>
      <button onclick={nextPage}>Next</button>
    </div>
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

