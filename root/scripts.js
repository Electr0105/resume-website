const countVisitors = async () => {
  const response = await fetch('https://resume-functions.azurewebsites.net/api/visitorcount?');
  const myJson = await response.json(); //extract JSON from the http response
  const quoteElement = document.getElementById("visitorcount").textContent = "Number of site visitors: " + myJson;
}
