async function countVisitors(){
  try{
    const response = await fetch('https://resume-functions.azurewebsites.net/api/visitorcount?');
    if (!response.ok) throw new Error("Network response was not ok");
    const quoteElement = document.getElementById("visitorcount");
    quoteElement.textContent = "Total number of site visitors :" + response;
  } catch (error) {
    quoteElement.textContent = "FAILED";
  }
  }
