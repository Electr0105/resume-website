const ccountVisitors = async () => {
  try {
    const response = await fetch('https://resume-functions.azurewebsites.net/api/visitorcount');

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();
    document.getElementById("visitorcount").textContent = 
      "Number of site visitors: " + (data?.count ?? "Unavailable");
    
  } catch (error) {
    console.error("Failed to fetch visitor count:", error);
    document.getElementById("visitorcount").textContent = 
      "Number of site visitors: Unavailable";
  }
};

