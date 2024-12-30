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

<div class="container">
  <h1>Data Mahasiswa</h1>
  
  <a href="/admin/mahasiswa/create">
    <button>+ Data Mahasiswa</button>
  </a>
  
  {#if mahasiswaData}
    <div class="table-wrapper">
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
            <td>{mhs.tanggallahir}</td>
            <td>{mhs.agama}</td>
            <td>{mhs.jenis_kelamin}</td>
            <td>{mhs.alamat}</td>
            <td>{mhs.kd_prodi}</td>
            <td>{mhs.semester_id}</td>
            <td>
              <a href="/admin/mahasiswa/edit/{mhs.NIM}" class="edit-btn">Edit</a>
            </td>
          </tr>
        {/each}
        </tbody>
      </table>
    </div>
  {:else}
    <p>Loading data...</p>
  {/if}
</div>

<style>
  .container {
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
  }
  
  h1 {
    margin-bottom: 20px;
    font-size: 24px;
  }
  
  .table-wrapper {
    overflow-x: auto;
  }
  
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
  }
  
  th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: left;
  }
  
  th {
    background-color: #f4f4f4;
    font-weight: bold;
  }
  
  tr:nth-child(even) {
    background-color: #f8f8f8;
  }
  
  tr:hover {
    background-color: #f5f5f5;
  }
  
  .edit-btn {
    display: inline-block;
    padding: 8px 16px;
    background-color: #4CAF50;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    text-align: center;
  }
  
  .edit-btn:hover {
    background-color: #45a049;
  }
  
  @media (max-width: 768px) {
    .container {
      padding: 10px;
    }
    
    th, td {
      padding: 8px;
      font-size: 14px;
    }
  }
</style>