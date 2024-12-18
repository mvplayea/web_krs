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

<div class="container">
  <h1>Data Mata Kuliah</h1>
  
  {#if matakuliahData}
    <div class="table-wrapper">
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
              <a href="/admin/matakuliah/edit/{mk.kd_mk}" class="edit-btn">Edit</a>
              <button on:click={() => deleteMatakuliah(mk.kd_mk)} class="delete-btn">Hapus</button>
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
  
  .btn-container {
    display: flex;
    gap: 4px;
    justify-content: center;
    align-items: center;
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
  
  .delete-btn {
    display: inline-block;
    padding: 8px 16px;
    background-color: #f44336;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    text-align: center;
  }
  
  .delete-btn:hover {
    background-color: #f44336;
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
