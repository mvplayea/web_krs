<script>
  let {children} = $props();
  import {logoutUser} from "$lib/util.js";
  
  function logout() {
    logoutUser(localStorage)
    window.location.href = '/login';
  }
</script>

<section>
  <div class="top-bar">
    <div class="logo">Aetherion <br> University</div>
    <div class="nav">
      <a href="/dashboard/beranda">BERANDA</a>
      <a href="/dashboard/profile">PROFIL</a>
      <a href="/dashboard/krs">KRS</a>
      <a href="/dashboard/jadwal">JADWAL</a>
    </div>
    <button class="exit-button" onclick={logout}>KELUAR</button>
  </div>
  <div>
    {@render children()}
  </div>
</section>

<style>
  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 5px 20px;
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
  
  .top-bar .exit-button {
    padding: 8px 16px;
    background-color: #f5f5f5;
    color: #333;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 0.9rem;
    transition: background-color 0.3s;
    margin-right: 30px;
  }
  
  .top-bar .exit-button:hover {
    background-color: #d1d1d1;
  }
  
  
  .top-bar .exit-button:hover {
    background-color: #d1d1d1;
  }

</style>