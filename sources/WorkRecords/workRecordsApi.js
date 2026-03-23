let url = 'http://localhost:8000/api/v1/work-records/';

const response = await fetch(url);
const json = await response.json();
const data = json.results;

// Export the data object
export { data };