const fhirClient =
  require('../../config/fhirClient');

const {
  mapLocation
} = require('./location.mapper');

const crearLocationFhir =
  async (sede) => {

    const recurso =
      mapLocation(sede);

    const respuesta =
      await fhirClient.post(
        '/Location',
        recurso
      );

    return respuesta.data;
};

const actualizarLocationFhir =
  async (sede) => {

    const recurso =
      mapLocation(sede);

    const respuesta =
      await fhirClient.put(
        `/Location/${sede.fhir_id}`,
        recurso
      );

    return respuesta.data;
};

module.exports = {
  crearLocationFhir,
  actualizarLocationFhir
};