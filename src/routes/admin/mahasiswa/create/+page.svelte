<script>
  import axios from "axios";
  import {onMount} from "svelte";
  
  let prodiData;
  let semesterData;
  
  async function getProdi() {
    try {
      const response = await axios.get('/api/prodi');
      
      prodiData = await response.data.prodi[0];
    } catch (error) {
      console.error('Error:', error);
    }
  }
  
  async function getSemester() {
    try {
      const response = await axios.get('/api/semester');
      
      semesterData = await response.data.semester[0];
    } catch (error) {
      console.error('Error:', error);
    }
  }
  
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
  
  async function handleSubmit() {
    try {
      const response = await axios.post('/api/mahasiswa', {
        ...formData,
      });
      
      // if (!response.status !== 200) {
      //   throw new Error('Network response was not ok');
      // }
      
      const result = await response.data;
      alert('Data submitted successfully!');
      
      // Reset form
      formData = {
        NIM: '',
        nama_mahasiswa: '',
        tanggallahir: '',
        agama: '',
        jenis_kelamin: '',
        alamat: '',
        kd_prodi: '',
        semester_id: ''
      };
    } catch (error) {
      console.error('Error:', error);
      alert('Failed to submit data');
    }
  }
  
  onMount(async () => {
    await getProdi();
    await getSemester();
  })
</script>

<div class="container">
  <h1>Student Registration Form</h1>
  
  <form on:submit|preventDefault={handleSubmit}>
    <div class="form-group">
      <label for="NIM">NIM:</label>
      <input
        type="text"
        id="NIM"
        name="NIM"
        bind:value={formData.NIM}
        required
      />
    </div>
    
    <div class="form-group">
      <label for="nama">Nama Mahasiswa:</label>
      <input
        type="text"
        id="nama"
        bind:value={formData.nama_mahasiswa}
        required
      />
    </div>
    
    <div class="form-group">
      <label for="tanggallahir">Tanggal Lahir:</label>
      <input
        type="date"
        id="tanggallahir"
        bind:value={formData.tanggallahir}
        required
      />
    </div>
    
    <div class="form-group">
      <label for="agama">Agama:</label>
      <select
        id="agama"
        bind:value={formData.agama}
        required
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
        required
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
        required
        rows="3"
      ></textarea>
    </div>
    
    <div class="form-group">
      <label for="kd_prodi">Kode Prodi:</label>
      <select
        id="kd_prodi"
        bind:value={formData.kd_prodi}
        required
      >
        {#each prodiData as prodi}
          <option value={prodi.kd_prodi}>{prodi.nama_prodi}</option>
        {/each}
      </select>
    </div>
    
    <div class="form-group">
      <label for="semester_id">Semester ID:</label>
      <select
        id="semester_id"
        bind:value={formData.semester_id}
        required
      >
        {#each semesterData as semester}
          <option value={semester.semester_id}>{semester.semester_id}</option>
        {/each}
      </select>
    </div>
    
    <button type="submit" class="submit-btn">
      Submit
    </button>
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
  
  textarea {
    resize: vertical;
    min-height: 80px;
  }
  
  select {
    height: 35px;
  }
  
  .submit-btn {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width: 100%;
    font-size: 16px;
  }
  
  .submit-btn:hover {
    background-color: #45a049;
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
  }
</style>
