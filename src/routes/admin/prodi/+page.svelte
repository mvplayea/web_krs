<script>
	import axios from 'axios';
	import { onMount } from 'svelte';

	let prodiData;

	async function getDataProdi() {
		try {
			const response = await axios.get('/api/prodi');
			prodiData = await response.data.prodi[0];
			console.log(prodiData);
		} catch (error) {
			console.error('Error:', error);
		}
	}

	onMount(async () => {
		console.log('halo');
		await getDataProdi();
	});
</script>

<section>
	{#if prodiData}
		<p>{prodiData[0].kd_prodi}</p>
	{/if}
</section>
