<script>
    import {onMount} from 'svelte';
    import axios from 'axios';
    import {page} from '$app/stores';

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
            mahasiswaData = response.data.mahasiswa[0]

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

    async function loadProdiData() {

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

<section>
    <div class="main">
        <div class="form-container">
            <div class="form-header">
                + Edit Mahasiswa
            </div>
            <form class="form-body" on:submit|preventDefault={handleSubmit}>
                <div class="form-group">
                    <label for="nim">NIM</label>
                    <input
                            type="text"
                            id="nim"
                            bind:value={formData.NIM}
                            readonly
                    />
                </div>

                <div class="form-group">
                    <label for="nama">Nama</label>
                    <input
                            type="text"
                            id="nama_mahasiswa"
                            bind:value={formData.nama_mahasiswa}
                    />
                </div>

                <div class="form-group">
                    <label for="alamat">Alamat:</label>
                    <input
                            type="textarea"
                            id="alamat"
                            bind:value={formData.alamat}
                    />
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
                    <label for="semester_id">Semester ID:</label>
                    <input
                            type="text"
                            id="semester_id"
                            bind:value={formData.semester_id}
                    />
                </div>

                <div class="form-group">
                    <label for="kd_prodi">Program Studi</label>
                    <select id="kd_prodi" required>
                        <option value="" disabled selected>Pilih</option>
                        <option value="0801">Teknik Informatika</option>
                        <option value="08022">Sistem Informasi</option>
                    </select>
                </div>

                <button type="submit" class="submit-button">Edit Fakultas</button>
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

