const editor = document.getElementById("editor");
const output = document.getElementById("output");
const runBtn = document.getElementById("runBtn");
const spinner = document.getElementById("spinner");

runBtn.addEventListener("click", async () => {
  const query = editor.value.trim();

  if (!query) {
    output.textContent = "No query to execute.";
    return;
  }

  output.textContent = "Executing query...\n\n" + query;
  spinner.classList.add("active");
  runBtn.disabled = true;

  try {
    const { protocol, hostname, port } = window.location;
    const apiUrl = `${protocol}//${hostname}:${port}/api/query`;

    const response = await fetch(apiUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ query }),
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();
    output.textContent = "\n\n✔ Query completed\n" + JSON.stringify(data, null, 2);
  } catch (error) {
    output.textContent = "Error: " + error.message;
    console.error("Error:", error);
  } finally {
    spinner.classList.remove("active");
    runBtn.disabled = false;
  }
});

