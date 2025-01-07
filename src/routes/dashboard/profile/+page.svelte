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
  
  body {
    font-family: Arial, sans-serif;
    background: #C2C8DA;
    height: 100vh;
  }
  
  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    background-color: #763497;
    color: #C2C8DA;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 10;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }
  
  .top-bar .logo {
    text-align: left;
    font-size: 1.8rem;
  }
  
  .top-bar .nav {
    flex: 1;
    display: flex;
    justify-content: center;
    gap: 25px;
  }
  
  .top-bar .nav a {
    color: #f5f5f5;
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
  
  .exit-button {
    position: fixed;
    bottom: 20px;
    right: 20px;
    padding: 10px 20px;
    background-color: #000;
    color: #FFF;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
  }
  
  .top-bar .exit-button:hover {
    background-color: #d1d1d1;
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