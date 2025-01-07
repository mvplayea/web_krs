<script>
  import axios from 'axios';
  import {onMount} from 'svelte';
  import {getUser} from "$lib/util.js";
  
  let data = [];
  let user;
  
  const getData = async () => {
    user = getUser(localStorage)
    const params = {
      nim: user.NIM
    }
    const res = await axios.get('http://localhost:5173/api/jadwal', {params});
    
    return await res.data.jadwal;
  };
  
  onMount(async () => {
    data = await getData();
    console.log(data);
  });
</script>

<div class="container">
  <div class="header">Jadwal Perkuliahan</div>
  
  {#if user}
    <div class="info-box">
      <div>
        <p>Nama Mahasiswa : {user && user.nama_mahasiswa}</p>
        <p>NIM : {user && user.NIM}</p>
        <p>Jenis Kelamin : {user && user.jenis_kelamin === 'L' ? 'Laki-laki' : 'Perempuan'}</p>
      </div>
      <div>
        <p>Fakultas/Prodi : {user && user.nama_prodi}</p>
        <p>Semester MHS : {user && user.semester_id}</p>
      </div>
    </div>
  {/if}
  
  <div class="schedule-section">
    <div class="schedule-title">Jadwal Perkuliahan Mingguan</div>
    <table class="schedule-table">
      <thead>
      
      <tr>
        <th>Kode</th>
        <th>Kode MK</th>
        <th>Mata Kuliah</th>
      </tr>
      </thead>
      <tbody>
      {#each data as item}
        <tr>
          <td>{new Date(item.waktu).toLocaleDateString('id-ID')}</td>
          <td>{item.kode_mk}</td>
          <td>{item.mata_kuliah}</td>
        </tr>
      {/each}
      </tbody>
    </table>
  </div>
  
  <a href="http://127.0.0.1:5501/beranda.html" class="back-button">Kembali</a>
</div>

<style>
  section {
    font-family: 'Roboto', Arial, sans-serif;;
    background-color: #763497;;
    color: #000000;
    display: flex;
    justify-content: center;
    padding: 20px;
  }
  
  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 5px 20px;
    background-color: #C2C8DA;
    color: #000000;
    position: fixed;
    width: 97%;
    top: 0;
    z-index: 10;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }
  
  .top-bar .logo {
    text-align: left;
    font-size: 1.8rem;
    margin-left: 1px;
  }
  
  .top-bar .nav {
    flex: 1;
    display: flex;
    justify-content: center;
    gap: 25px;
  }
  
  .top-bar .nav a {
    color: #000000;
    text-decoration: none;
    font-size: 1rem;
    padding: 8px 12px;
    border-radius: 4px;
    transition: background-color 0.3s, color 0.3s;
  }
  
  .top-bar .nav a:hover {
    background-color: #f5f5f5;
    color: #333;
  }
  
  .container {
    width: 80%;
    background-color: #763497;
    padding: 25px;
    border-radius: 10px;
  }
  
  .header {
    text-align: center;
    font-weight: bold;
    font-size: 24px;
    margin-bottom: 20px;
    margin-top: 35px;
    color: #C2C8DA;
  }
  
  .info-box {
    background-color: #f2f2f2;
    padding: 15px;
    border-radius: 10px;
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
  }
  
  .info-box div {
    width: 45%;
  }
  
  .info-box div p {
    margin: 8px 0;
  }
  
  .schedule-section {
    margin-bottom: 10px;
  }
  
  .schedule-title {
    font-weight: bold;
    font-size: 18px;
    border-bottom: 2px solid #C2C8DA;
    padding-bottom: 5px;
    margin-bottom: 10px;
    color: #C2C8DA;
  }
  
  .schedule-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
  }
  
  .schedule-table th, .schedule-table td {
    border: 1px solid #000;
    padding: 8px;
    text-align: center;
  }
  
  .schedule-table th {
    background-color: #e0e0e0;
  }
  
  .schedule-table td {
    background-color: #e0e0e0;
  }
  
  .back-button {
    background-color: #2C2C2C;
    color: #fff;
    padding: 10px 20px;
    text-align: center;
    border-radius: 5px;
    text-decoration: none;
    float: right;
  }
</style>
