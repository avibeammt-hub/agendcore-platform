const fhirClient = require('../../config/fhirClient');

const {
  mapOrganization
} = require('./organization.mapper');

const crearOrganizationFhir = async (ips) => {

  const recurso = mapOrganization(ips);

  const respuesta = await fhirClient.post(
    '/Organization',
    recurso
  );

  return respuesta.data;
};

const actualizarOrganizationFhir = async (ips) => {

  const recurso = mapOrganization(ips);

  const respuesta = await fhirClient.put(
    `/Organization/${ips.fhir_id}`,
    recurso
  );

  return respuesta.data;
};

module.exports = {
  crearOrganizationFhir,
  actualizarOrganizationFhir
};