<script>
  import {getUser} from "$lib/util.js";
  import {onMount} from 'svelte';
  
  let user;
  
  onMount(async () => {
    user = getUser(localStorage)
  })
</script>
<section>
  <div class="container">
    <div class="profile-section">
      <h1>Profil Mahasiswa</h1>
      {#if user}
        <div class="profile-info">
          <div class="profile-field">
            <span>NIM</span>
            <span>:</span>
            <span>{user.NIM}</span>
          </div>
          <div class="profile-field">
            <span>Nama Mahasiswa</span>
            <span>:</span>
            <span>{user.nama_mahasiswa}</span>
          </div>
          <div class="profile-field">
            <span>Fakultas</span>
            <span>:</span>
            <span>Fakultas Ilmu Komputer</span>
          </div>
          <div class="profile-field">
            <span>Prodi</span>
            <span>:</span>
            <span>{user.nama_prodi}</span>
          </div>
          <div class="profile-field">
            <span>Status Mahasiswa</span>
            <span>:</span>
            <span>Aktif</span>
          </div>
          <div class="profile-field">
            <span>Semester</span>
            <span>:</span>
            <span>{user.semester_id}</span>
          </div>
        </div>
      {/if}
    </div>
  </div>
</section>

<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  
  section {
    font-family: Arial, sans-serif;
    background: #C2C8DA;
    height: 100vh;
  }
  
  .container {
    margin-top: 70px;
    width: 100%;
    padding: 20px;
  }
  
  .profile-section {
    background-color: #C2C8DA;
    color: #000;
    width: 100%;
    padding: 40px;
  }
  
  h1 {
    font-size: 40px;
    color: #000;
    text-align: left;
    margin-bottom: 20px;
  }
  
  .profile-info {
    width: 100%;
    padding: 10px;
  }
  
  .profile-field {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    font-size: 18px;
    border-bottom: 1px solid #000;
  }
  
  .profile-field span {
    flex: 1;
  }
</style>