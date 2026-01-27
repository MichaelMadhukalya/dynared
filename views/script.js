const editor = document.getElementById("editor");
const output = document.getElementById("output");
const runBtn = document.getElementById("runBtn");

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
    // get query path
    const protocol = window.location.protocol;
    const hostname = window.location.hostname;
    const port = window.location.port;         
    const path = window.location.pathname; 
    const apiPath = `${protocol}//${hostname}:${port}/${path}`;

    const response = await fetch(apiPath, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ query: query })
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    output.textContent = "\n\n✔ Query completed (<result>)" + JSON.stringify(data);
  } catch (error) {
    output.textContent = "Error: " + error.message;
    console.error("Error:", error);
  } finally {
    spinner.classList.remove("active");
    runBtn.disabled = false;
  }
});

