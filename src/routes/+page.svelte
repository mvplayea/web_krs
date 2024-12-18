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

<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
</style>