<script>
  import axios from 'axios';
  import {onMount} from 'svelte';
  import {getUser} from "$lib/util.js";
  
  let formData = {};
  let mk = {};
  let data = [];
  let user;
  
  const getData = async () => {
    user = getUser(localStorage)
    const mhs = localStorage.getItem('mahasiswa');
    
    if (mhs) {
      const temp = JSON.parse(mhs);
      const res = await axios.get('http://localhost:5173/api/krs', {
        params: {
          nim: temp.NIM
        }
      });
      
      return await res.data.krs[0];
    }
  };
  
  const getMK = async () => {
    const res = await axios.get('http://localhost:5173/api/matakuliah');
    
    return await res.data.mk[0];
  }
  
  const saveKRS = async () => {
  
  }
  
  onMount(async () => {
    data = await getData();
    mk = await getMK();
  });
</script>

<section>
  <div class="container">
    <h1>KRS ANDA</h1>
    {#if user}
    <div class="info-section">
      <p>Mahasiswa: </p>
      <p>Fakultas: </p>
      <p>Prodi: </p>
      <p>Semester: </p>
      <p>Basis: </p>
    </div>
      {/if}
    
    <div class="table-section">
      <h3>Kartu Rencana Studi (KRS) - Semester Ganjil 2024-2025</h3>
      <table>
        <thead>
        <tr>
          <th>No</th>
          <th>Kode</th>
          <th>Nama Matakuliah</th>
          <th>Sesi</th>
          <th>SKS</th>
          <th>Waktu</th>
          <th>Jenis Kelas</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</section>

<!--<div class="container">-->
<!--  <div class="table-section">-->

<!--    <h3>Kartu Rencana Studi (KRS) - Semester Ganjil 2024-2025</h3>-->
<!--    <table>-->
<!--      <thead>-->
<!--      <tr>-->
<!--        <th>No</th>-->
<!--        <th>Kode</th>-->
<!--        <th>Nama Matakuliah</th>-->
<!--        <th>Sesi</th>-->
<!--        <th>SKS</th>-->
<!--        <th>Waktu</th>-->
<!--        <th>Jenis Kelas</th>-->
<!--      </tr>-->
<!--      </thead>-->
<!--      <tbody>-->
<!--      {#each data as krs}-->
<!--        <tr>-->
<!--          <td>-->
<!--            {data.indexOf(krs) + 1}-->
<!--          </td>-->
<!--          <td>-->
<!--            {krs.kd_mk}-->
<!--          </td>-->
<!--          <td>-->
<!--            {krs.matakuliah}-->
<!--          </td>-->
<!--          <td> 1</td>-->
<!--          <td>-->
<!--            {krs.SKS}-->
<!--          </td>-->
<!--          <td>-->
<!--            {new Date(krs.waktu).toLocaleTimeString('id-ID', {-->
<!--              hour: 'numeric',-->
<!--              minute: 'numeric'-->
<!--            })}-->
<!--          </td>-->
<!--          <td> tatap muka</td>-->
<!--        </tr>-->
<!--      {/each}-->
<!--      </tbody>-->
<!--    </table>-->
<!--  </div>-->
<!--  -->
<!--  <div class="button-section">-->
<!--    <a href="/jadwal">-->
<!--      <button class="button">Lihat Jadwal Perkuliahan</button>-->
<!--    </a>-->
<!--  </div>-->
<!--</div>-->
<!--<div class="table-section">-->
<!--  <h3>Pilih KRS</h3>-->
<!--  <table>-->
<!--    <thead>-->
<!--    <tr>-->
<!--      <th>Kode</th>-->
<!--      <th>Nama Matakuliah</th>-->
<!--      <th>SKS</th>-->
<!--      <th>Prodi</th>-->
<!--      <th>Semester</th>-->
<!--    </tr>-->
<!--    </thead>-->
<!--    <tbody>-->
<!--    {#each data as krs}-->
<!--      <tr>-->
<!--        <td>{krs.kd_mk}</td>-->
<!--        <td>{krs.matakuliah}</td>-->
<!--        <td>{krs.SKS}</td>-->
<!--        <td>{krs.kd_prodi}</td>-->
<!--        <td> {krs.semester} </td>-->
<!--      </tr>-->
<!--    {/each}-->
<!--    </tbody>-->
<!--  </table>-->
<!--</div>-->

<style>
  /*body {*/
  /*  font-family: Arial, sans-serif;*/
  /*  background-color: #2c2c2c;*/
  /*  color: #ffffff;*/
  /*  display: flex;*/
  /*  flex-direction: column;*/
  /*  align-items: center;*/
  /*  flex-direction: column;*/
  /*  height: 100vh;*/
  /*  margin: 0;*/
  /*}*/
  
  /*.container {*/
  /*  padding: 20px;*/
  /*  width: 80%;*/
  /*  max-width: 800px;*/
  /*}*/
  
  /*h1 {*/
  /*  text-align: center;*/
  /*  font-size: 1.5rem;*/
  /*  margin-bottom: 20px;*/
  /*  margin-top: 0;*/
  /*}*/
  
  /*.info-section {*/
  /*  background-color: #d9d9d9;*/
  /*  color: #000000;*/
  /*  padding: 15px;*/
  /*  border-radius: 10px;*/
  /*  margin-bottom: 20px;*/
  /*  font-size: 1rem;*/
  /*}*/
  
  /*.info-section p {*/
  /*  margin: 10px 0;*/
  /*}*/
  
  /*h3 {*/
  /*  margin: 0 0 20px;*/
  /*  font-size: 1rem;*/
  /*  color: #ffffff;*/
  /*}*/
  
  /*.table-section {*/
  /*  background-color: #444444;*/
  /*  border-radius: 10px;*/
  /*  padding: 15px;*/
  /*}*/
  
  /*table {*/
  /*  width: 100%;*/
  /*  border-collapse: collapse;*/
  /*}*/
  
  /*th,*/
  /*td {*/
  /*  border: 1px solid #666666;*/
  /*  padding: 10px;*/
  /*  text-align: center;*/
  /*  color: #ffffff;*/
  /*}*/
  
  /*th {*/
  /*  background-color: #333333;*/
  /*  font-weight: bold;*/
  /*}*/
  
  /*.button-section {*/
  /*  text-align: right;*/
  /*  margin-top: 10px;*/
  /*}*/
  
  /*.button {*/
  /*  background-color: #6c6c6c;*/
  /*  color: #ffffff;*/
  /*  border: none;*/
  /*  padding: 10px 20px;*/
  /*  border-radius: 5px;*/
  /*  cursor: pointer;*/
  /*  font-size: 0.9rem;*/
  /*  transition: background-color 0.3s;*/
  /*}*/
  
  /*.button:hover {*/
  /*  background-color: #888888;*/
  /*}*/
  
  section {
    font-family: Arial, sans-serif;
    background-color: #763497;
    color: #ffffff;
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100vh;
    margin: 0;
  }
  
  .container {
    padding: 20px;
    width: 90%;
    max-width: 800px;
  }
  
  h1 {
    text-align: center;
    font-size: 1.5rem;
    margin-bottom: 20px;
    margin-top: 80px;
  }
  
  .info-section {
    background-color: #FFFFFF;
    color: #000000;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 20px;
    font-size: 1rem;
  }
  
  .info-section p {
    margin: 10px 0;
  }
  
  h3 {
    background-color: #C2C8DA;
    padding: 10px;
    text-align: center;
    margin: 0;
    border-radius: 3px;
    font-size: 1.1rem;
    color: #ffffff;
  }
  
  .table-section {
    border-radius: 10px;
    padding: 1px;
  }
  
  table {
    width: 100%;
    border-collapse: collapse;
    background-color: #FFFFFF;
  }
  
  th, td {
    border: 1px solid #666666;
    padding: 10px;
    text-align: center;
  }
  
  th {
    background-color: #FFFFFF;
    font-weight: bold;
    color: #000000;
  }
  
  td {
    color: #000000;
  }
  
  .button-section .exit-button {
    background: #D9D9D9;
    color: #000000;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    position: fixed;
    right: 40px;
    margin-top: 10px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }
  
  .button-section .exit-button:hover {
    transform: translateY(-2px);
    background: linear-gradient(135deg, #746e6e, #837c8b);
  }
</style>
