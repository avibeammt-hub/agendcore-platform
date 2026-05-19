const axios = require('axios');
require('dotenv').config();

const fhirClient = axios.create({
  baseURL: process.env.FHIR_BASE_URL,
  timeout: 15000,
  headers: {
    'Content-Type': 'application/fhir+json'
  }
});


// =============================
// REQUEST INTERCEPTOR
// =============================

fhirClient.interceptors.request.use(

  (config) => {

    console.log(`
🌐 FHIR REQUEST:
${config.method?.toUpperCase()}
${config.baseURL}${config.url}
    `);

    return config;
  },

  (error) => {
    return Promise.reject(error);
  }

);


// =============================
// RESPONSE INTERCEPTOR
// =============================

fhirClient.interceptors.response.use(

  (response) => {

    console.log(`
✅ FHIR RESPONSE:
${response.status}
${response.config.url}
    `);

    return response;
  },

  (error) => {

    console.error(`
❌ ERROR FHIR:
${error.response?.status || 500}
${error.config?.url}
    `);

    console.error(
      error.response?.data || error.message
    );

    return Promise.reject(error);
  }

);

module.exports = fhirClient;