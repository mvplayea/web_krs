<script>
	import axios from 'axios';
	import { onMount } from 'svelte';

	let data = [];

	const getData = async () => {
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

	onMount(async () => {
		data = await getData();
		console.log(data);
	});
</script>

<body>
	<div class="container">
		<h1>KRS Anda</h1>

		{#if data[0]}
			<div class="info-section">
				<p>Mahasiswa: {data[0].nama_mahasiswa}</p>
				<p>NIM: {data[0].NIM}</p>
				<p>Prodi: {data[0].nama_prodi}</p>
				<p>Semester: {data[0].semester_id}</p>
				<p>Tahun Ajaran: {data[0].semester}</p>
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
					{#each data as krs}
						<tr>
							<td>
								{data.indexOf(krs) + 1}
							</td>
							<td>
								{krs.kd_mk}
							</td>
							<td>
								{krs.matakuliah}
							</td>
							<td> 1 </td>
							<td>
								{krs.SKS}
							</td>
							<td>
								{new Date(krs.waktu).toLocaleTimeString('id-ID', {
									hour: 'numeric',
									minute: 'numeric'
								})}
							</td>
							<td> tatap muka </td>
						</tr>
					{/each}
				</tbody>
			</table>
		</div>

		<div class="button-section">
			<button class="button">Lihat Jadwal Perkuliahan</button>
		</div>
	</div>
</body>

<style>
	body {
		font-family: Arial, sans-serif;
		background-color: #2c2c2c;
		color: #ffffff;
		display: flex;
		flex-direction: column;
		align-items: center;
		flex-direction: column;
		height: 100vh;
		margin: 0;
	}

	.container {
		padding: 20px;
		width: 80%;
		max-width: 800px;
	}

	h1 {
		text-align: center;
		font-size: 1.5rem;
		margin-bottom: 20px;
		margin-top: 0;
	}

	.info-section {
		background-color: #d9d9d9;
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
		margin: 0 0 20px;
		font-size: 1rem;
		color: #ffffff;
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

	.button-section {
		text-align: right;
		margin-top: 10px;
	}

	.button {
		background-color: #6c6c6c;
		color: #ffffff;
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
		font-size: 0.9rem;
		transition: background-color 0.3s;
	}

	.button:hover {
		background-color: #888888;
	}
</style>
