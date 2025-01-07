<script>
  import axios from "axios";
  import {onMount} from "svelte";
  import {page} from "$app/stores";
  
  const kd_mk = $page.params.kd_mk;
  
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
    kd_mk: '',
    matakuliah: '',
    sks: '',
    kd_prodi: '',
    semester_id: '',
  };
  
  async function loadMatakulihaData() {
    try {
      const response = await axios.get(`/api/matakuliah/${kd_mk}`);
      
      const matakuliah = await response.data.matakuliah[0];
      
      formData = {
        ...formData,
        ...matakuliah[0]
      };
    } catch (error) {
      console.error('Error:', error);
    }
  }
  
  async function handleSubmit() {
    try {
      const response = await axios.put(`/api/matakuliah/${kd_mk}`, formData);
      
      if (response.status === 200) {
        alert('Data updated successfully!');
        window.location.href = '/admin/matakuliah'; // Redirect to the main list
      }
    } catch (error) {
      console.error('Error:', error);
      alert('Failed to update data');
    }
  }
  
  onMount(async () => {
    await loadMatakulihaData()
    await getProdi();
    await getSemester();
  })
</script>

<section>
    <div class="main">
        <div class="form-container">
            <div class="form-header">
                + Edit Mata Kuliah
            </div>
            <form class="form-body" on:submit|preventDefault={handleSubmit}>
                <div class="form-group">
                    <label for="kd_mk">Kode Mata Kuliah</label>
                    <input
                            type="text"
                            id="kd_mk"
                            name="kd_mk"
                            bind:value={formData.kd_mk}
                            readonly
                    />
                </div>

                <div class="form-group">
                    <label for="matakuliah">Nama Mata Kuliah</label>
                    <input
                            type="text"
                            id="matakuliah"
                            bind:value={formData.matakuliah}
                            required
                    />
                </div>

                <div class="form-group">
                    <label for="sks">SKS</label>
                    <input
                            type="number"
                            id="sks"
                            bind:value={formData.SKS}
                            required
                    />
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

                <button type="submit" class="submit-button">Simpan</button>
            </form>
        </div>
    </div>
</section>

<style>
    section {
        margin: 0;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        width: 100%;
    }

    .main {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        flex-wrap: wrap;
        padding: 10px;
    }

    .main .form-container {
        width: 100%;
        max-width: 700px;
        background-color: #C2C8DA;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin: 20px;
    }

    .form-header {
        background-color: #6a1b9a;
        color: white;
        font-size: 25px;
        font-weight: bold;
        padding: 15px;
        text-align: left;
    }

    .form-body {
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    label {
        font-size: 14px;
        font-weight: bold;
        color: #333;
    }

    input,
    select,
    textarea {
        padding: 10px;
        border: 1px solid #763497;
        border-radius: 4px;
        font-size: 14px;
        background-color: #C2C8DA;
    }

    input:focus,
    select:focus {
        outline: none;
        border-color: #6a1b9a;
    }

    .submit-button {
        padding: 10px;
        background-color: #6a1b9a;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
        align-self: flex-start; /* Align button to the left */
    }

    .submit-button:hover {
        background-color: #501380;
    }

    /* Minimize*/
    @media (max-width: 768px) {
        .form-container {
            width: 90%;
        }
    }

    @media (max-width: 480px) {
        .sidebar {
            display: none;
        }

        .main {
            padding: 10px;
        }
    }
</style>


<!--<div class="container">-->
<!--  <form on:submit|preventDefault={handleSubmit}>-->
<!--    <div class="form-group">-->
<!--      <label for="kd_mk">Kode Mata Kuliah</label>-->
<!--      <input-->
<!--        type="text"-->
<!--        id="kd_mk"-->
<!--        name="kd_mk"-->
<!--        bind:value={formData.kd_mk}-->
<!--        required-->
<!--      />-->
<!--    </div>-->
<!--    -->
<!--    <div class="form-group">-->
<!--      <label for="matakuliah">Nama Mata Kuliah</label>-->
<!--      <input-->
<!--        type="text"-->
<!--        id="matakuliah"-->
<!--        bind:value={formData.matakuliah}-->
<!--        required-->
<!--      />-->
<!--    </div>-->
<!--    -->
<!--    <div class="form-group">-->
<!--      <label for="sks">SKS</label>-->
<!--      <input-->
<!--        type="number"-->
<!--        id="sks"-->
<!--        bind:value={formData.SKS}-->
<!--        required-->
<!--      />-->
<!--    </div>-->
<!--    -->
<!--    -->
<!--    <div class="form-group">-->
<!--      <label for="kd_prodi">Kode Prodi:</label>-->
<!--      <select-->
<!--        id="kd_prodi"-->
<!--        bind:value={formData.kd_prodi}-->
<!--        required-->
<!--      >-->
<!--        {#each prodiData as prodi}-->
<!--          <option value={prodi.kd_prodi}>{prodi.nama_prodi}</option>-->
<!--        {/each}-->
<!--      </select>-->
<!--    </div>-->
<!--    -->
<!--    <div class="form-group">-->
<!--      <label for="semester_id">Semester ID:</label>-->
<!--      <select-->
<!--        id="semester_id"-->
<!--        bind:value={formData.semester_id}-->
<!--        required-->
<!--      >-->
<!--        {#each semesterData as semester}-->
<!--          <option value={semester.semester_id}>{semester.semester_id}</option>-->
<!--        {/each}-->
<!--      </select>-->
<!--    </div>-->
<!--    -->
<!--    <button type="submit" class="submit-btn">-->
<!--      Submit-->
<!--    </button>-->
<!--  </form>-->
<!--</div>-->

<!--<style>-->
<!--  .container {-->
<!--    max-width: 800px;-->
<!--    margin: 0 auto;-->
<!--    padding: 20px;-->
<!--  }-->
<!--  -->
<!--  h1 {-->
<!--    font-size: 24px;-->
<!--    margin-bottom: 20px;-->
<!--  }-->
<!--  -->
<!--  .form-group {-->
<!--    margin-bottom: 15px;-->
<!--  }-->
<!--  -->
<!--  label {-->
<!--    display: block;-->
<!--    margin-bottom: 5px;-->
<!--    font-weight: bold;-->
<!--  }-->
<!--  -->
<!--  input, select, textarea {-->
<!--    width: 100%;-->
<!--    padding: 8px;-->
<!--    border: 1px solid #ccc;-->
<!--    border-radius: 4px;-->
<!--    box-sizing: border-box;-->
<!--  }-->
<!--  -->
<!--  textarea {-->
<!--    resize: vertical;-->
<!--    min-height: 80px;-->
<!--  }-->
<!--  -->
<!--  select {-->
<!--    height: 35px;-->
<!--  }-->
<!--  -->
<!--  .submit-btn {-->
<!--    background-color: #4CAF50;-->
<!--    color: white;-->
<!--    padding: 10px 20px;-->
<!--    border: none;-->
<!--    border-radius: 4px;-->
<!--    cursor: pointer;-->
<!--    width: 100%;-->
<!--    font-size: 16px;-->
<!--  }-->
<!--  -->
<!--  .submit-btn:hover {-->
<!--    background-color: #45a049;-->
<!--  }-->
<!--  -->
<!--  input:focus, select:focus, textarea:focus {-->
<!--    outline: none;-->
<!--    border-color: #4CAF50;-->
<!--    box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);-->
<!--  }-->
<!--  -->
<!--  /* Add some basic form validation styles */-->
<!--  input:invalid, select:invalid, textarea:invalid {-->
<!--    border-color: #ff6b6b;-->
<!--  }-->
<!--  -->
<!--  /* Responsive design */-->
<!--  @media (max-width: 600px) {-->
<!--    .container {-->
<!--      padding: 10px;-->
<!--    }-->
<!--  }-->
<!--</style>-->

