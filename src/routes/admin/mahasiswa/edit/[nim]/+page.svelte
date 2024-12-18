<script src="../../../../api/matakuliah/[kd_mk]/+server.js"></script>
<script>
  import { onMount } from 'svelte';
  import axios from 'axios';
  import { page } from '$app/stores';
  
  const nim = $page.params.nim;
  let mahasiswaData;
  
  let formData = {
    NIM: '',
    nama_mahasiswa: '',
    tanggallahir: '',
    agama: '',
    jenis_kelamin: '',
    alamat: '',
    kd_prodi: '',
    semester_id: ''
  };
  
  // Load existing data
  async function loadMahasiswaData() {
    try {
      const response = await axios.get(`/api/mahasiswa/${nim}`);
      // Update each property reactively
      mahasiswaData = response.data.mahasiswa[0];
      
      formData = {
        ...formData,
        ...mahasiswaData[0],
        taggallahir: new Date(mahasiswaData[0].tanggallahir).toISOString().split('T')[0],
      }
    } catch (error) {
      console.error('Error loading data:', error);
      alert('Failed to load student data');
    }
  }
  
  async function handleSubmit() {
    try {
      formData = {
        ...formData,
        tanggallahir: new Date(formData.tanggallahir).toISOString().split('T')[0],
      }
      const response = await axios.put(`/api/mahasiswa/${nim}`, formData);
      if (response.status === 200) {
        alert('Data updated successfully!');
        window.location.href = '/admin/mahasiswa'; // Redirect to the main list
      }
    } catch (error) {
      console.error('Error:', error);
      alert('Failed to update data');
    }
  }
  
  onMount(() => {
    loadMahasiswaData();
  });
</script>

<!-- HTML and Styling remains the same -->
<div class="container">
<!---->
  <div class="table-section">
    <h3>Data Mahasiswa</h3>
    <table>
      <thead>
      <tr>
        <th>Nama</th>
        <th>tanggal lahir</th>
        <th>alamat</th>
        <th>agama</th>
        <th>Jenis kelamin</th>
        <th>Prodi</th>
        <th>Semester</th>
      </tr>
      </thead>
      <tbody>
      {#each mahasiswaData as data}
        <tr>
          <td>
            {data.nama_mahasiswa}
          </td>
          <td>
            {data.semester_id}
          </td>
          <td>
            {data.alamat}
          </td>
          <td>
            {data.agama}
          </td>
          <td>
            {data.jenis_kelamin == 'L' ? 'Laki-laki' : 'Perempuan'}
          </td>
          <td>
            {data.kd_prodi}
          </td>
          <td>
            {data.semester_id}
          </td>
        </tr>
      {/each}
      </tbody>
    </table>
  </div>
  
  <h1>Edit Data Mahasiswa</h1>
  
  <form on:submit|preventDefault={handleSubmit}>
    <div class="form-group">
      <label for="nim">NIM:</label>
      <input
        type="text"
        id="nim"
        bind:value={formData.NIM}
        readonly
      />
    </div>
    
    <div class="form-group">
      <label for="nama">Nama Mahasiswa:</label>
      <input
        type="text"
        id="nama"
        bind:value={formData.nama_mahasiswa}
      />
    </div>
    
    <div class="form-group">
      <label for="tanggallahir">Tanggal Lahir:</label>
      <input
        type="date"
        id="tanggallahir"
        bind:value={formData.tanggallahir}
      />
    </div>
    
    <div class="form-group">
      <label for="agama">Agama:</label>
      <select
        id="agama"
        bind:value={formData.agama}
      >
        <option value="">Select Religion</option>
        <option value="Islam">Islam</option>
        <option value="Kristen">Kristen</option>
        <option value="Katolik">Katolik</option>
        <option value="Hindu">Hindu</option>
        <option value="Buddha">Buddha</option>
        <option value="Konghucu">Konghucu</option>
      </select>
    </div>
    
    <div class="form-group">
      <label for="jenis_kelamin">Jenis Kelamin:</label>
      <select
        id="jenis_kelamin"
        bind:value={formData.jenis_kelamin}
      >
        <option value="">Select Gender</option>
        <option value="L">Laki-laki</option>
        <option value="P">Perempuan</option>
      </select>
    </div>
    
    <div class="form-group">
      <label for="alamat">Alamat:</label>
      <textarea
        id="alamat"
        bind:value={formData.alamat}
        rows="3"
      ></textarea>
    </div>
    
    <div class="form-group">
      <label for="kd_prodi">Kode Prodi:</label>
      <input
        type="text"
        id="kd_prodi"
        bind:value={formData.kd_prodi}
      />
    </div>
    
    <div class="form-group">
      <label for="semester_id">Semester ID:</label>
      <input
        type="text"
        id="semester_id"
        bind:value={formData.semester_id}
      />
    </div>
    
    <div class="button-group">
      <button type="submit" class="submit-btn">
        Update Data
      </button>
      <a href="/static" class="cancel-btn">Cancel</a>
    </div>
  </form>
</div>

<style>
  .container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }
  
  h1 {
    font-size: 24px;
    margin-bottom: 20px;
  }
  .table-section {
    background-color: #444444;
    border-radius: 10px;
    padding: 15px;
  }
  
  table {
    width: 100%;
    border-collapse: collapse;
  }
  
  th,
  td {
    border: 1px solid #666666;
    padding: 10px;
    text-align: center;
    color: #ffffff;
  }
  
  th {
    background-color: #333333;
    font-weight: bold;
  }
  
  .form-group {
    margin-bottom: 15px;
  }
  
  label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
  }
  
  input, select, textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
  }
  
  input[readonly] {
    background-color: #f5f5f5;
    cursor: not-allowed;
  }
  
  textarea {
    resize: vertical;
    min-height: 80px;
  }
  
  select {
    height: 35px;
  }
  
  .button-group {
    display: flex;
    gap: 10px;
    margin-top: 20px;
  }
  
  .submit-btn, .cancel-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    text-decoration: none;
    text-align: center;
    flex: 1;
  }
  
  .submit-btn {
    background-color: #4CAF50;
    color: white;
  }
  
  .submit-btn:hover {
    background-color: #45a049;
  }
  
  .cancel-btn {
    background-color: #f44336;
    color: white;
    display: inline-block;
  }
  
  .cancel-btn:hover {
    background-color: #da190b;
  }
  
  input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: #4CAF50;
    box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
  }
  
  /* Add some basic form validation styles */
  input:invalid, select:invalid, textarea:invalid {
    border-color: #ff6b6b;
  }
  
  /* Responsive design */
  @media (max-width: 600px) {
    .container {
      padding: 10px;
    }
    
    .button-group {
      flex-direction: column;
    }
  }
</style>