<script>
	import { onMount } from "svelte";

	let count = 0;

	function increment() {
		count += 1;
	}

	onMount(() => {
		window.location.href = "/login"
	})
</script>