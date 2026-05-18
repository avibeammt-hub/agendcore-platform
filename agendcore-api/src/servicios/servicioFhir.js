const axios = require('axios');
require('dotenv').config();

const URL_FHIR = process.env.FHIR_BASE_URL;

/**
 * Crear Organization (IPS o aseguradora)
 */
const crearOrganizacionFhir = async (ips) => {
  try {
    const recurso = {
      resourceType: 'Organization',
      active: true,
      name: ips.nombre,
      identifier: [
        {
          system: 'https://acme.com/ips/nit',
          value: ips.nit
        }
      ]
    };

    const respuesta = await axios.post(
      `${URL_FHIR}/Organization`,
      recurso,
      {
        headers: {
          'Content-Type': 'application/fhir+json'
        }
      }
    );

    return respuesta.data;

  } catch (error) {
    console.error('Error FHIR Organization:', error.response?.data || error.message);
    throw error;
  }
};

/**
 * Crear Location (Sede)
 */
const crearLocationFhir = async (sede) => {
  try {
    const recurso = {
      resourceType: 'Location',
      status: 'active',
      name: sede.nombre,
      address: {
        text: sede.direccion || 'Sin dirección'
      },
      managingOrganization: {
        reference: `Organization/${sede.fhir_id_ips}`
      }
    };

    const respuesta = await axios.post(
      `${URL_FHIR}/Location`,
      recurso,
      {
        headers: {
          'Content-Type': 'application/fhir+json'
        }
      }
    );

    return respuesta.data;

  } catch (error) {
    console.error('Error FHIR Location:', error.response?.data || error.message);
    throw error;
  }
};

const crearPractitionerFhir = async (profesional) => {
  try {
    const recurso = {
      resourceType: 'Practitioner',
      active: true,
      identifier: [
        {
          system: 'https://acme.com/profesionales/tarjeta-profesional',
          value: profesional.tarjeta_profesional
        }
      ],
      name: [
        {
          family: profesional.apellidos,
          given: [profesional.nombres]
        }
      ],
      telecom: [
        {
          system: 'phone',
          value: profesional.telefono || ''
        },
        {
          system: 'email',
          value: profesional.correo || ''
        }
      ]
    };

    const respuesta = await axios.post(
      `${URL_FHIR}/Practitioner`,
      recurso,
      {
        headers: {
          'Content-Type': 'application/fhir+json'
        }
      }
    );

    return respuesta.data;

  } catch (error) {
    console.error('Error FHIR Practitioner:', error.response?.data || error.message);
    throw error;
  }
};

const crearHealthcareServiceFhir = async (servicio) => {
	
  try {
    const recurso = {
      resourceType: 'HealthcareService',
      active: true,
      name: servicio.nombre,
      providedBy: {
        reference: `Organization/${servicio.fhir_id_ips}`
      },
      location: [
        {
          reference: `Location/${servicio.fhir_id_sede}`
        }
      ],
      type: [
        {
          text: servicio.nombre_especialidad || servicio.nombre
        }
      ]
    };

    const respuesta = await axios.post(
      `${URL_FHIR}/HealthcareService`,
      recurso,
      {
        headers: {
          'Content-Type': 'application/fhir+json'
        }
      }
    );

    return respuesta.data;

  } catch (error) {
    console.error('Error FHIR HealthcareService:', error.response?.data || error.message);
    throw error;
  }
};

const sincronizarCodeSystemEspecialidadesFhir = async (especialidades) => {
  const codeSystem = {
    resourceType: 'CodeSystem',
    id: 'acme-especialidades',
    url: 'http://acme.com/fhir/CodeSystem/especialidades',
    name: 'ACMEEspecialidades',
    title: 'Catálogo de Especialidades ACME',
    status: 'active',
    content: 'complete',
    concept: especialidades
      .filter(e => e.activo)
      .map(e => ({
        code: e.codigo || `ESP-${e.id_especialidad}`,
        display: e.nombre
      }))
  };

  const respuesta = await axios.put(
    `${FHIR_BASE_URL}/CodeSystem/acme-especialidades`,
    codeSystem,
    {
      headers: {
        'Content-Type': 'application/fhir+json'
      }
    }
  );

  return respuesta.data;
};

const crearPractitionerRoleFhir = async (rol) => {
  const practitionerRole = {
    resourceType: 'PractitionerRole',
    active: true,
    practitioner: {
      reference: limpiarReferenciaFhir('Practitioner', rol.fhir_profesional_id),
      display: `${rol.nombres} ${rol.apellidos}`
    },
    organization: {
      reference: limpiarReferenciaFhir('Organization', rol.fhir_ips_id),
      display: rol.nombre_ips
    },
    location: [
      {
        reference: limpiarReferenciaFhir('Location', rol.fhir_sede_id),
        display: rol.nombre_sede
      }
    ],
    healthcareService: [
      {
        reference: limpiarReferenciaFhir('HealthcareService', rol.fhir_servicio_id),
        display: rol.nombre_servicio
      }
    ],
    period: {
      start: rol.fecha_inicio
    }
  };

  if (rol.fecha_fin) {
    practitionerRole.period.end = rol.fecha_fin;
  }

  const respuesta = await axios.post(
    `${URL_FHIR}/PractitionerRole`,
    practitionerRole,
    {
      headers: {
        'Content-Type': 'application/fhir+json'
      }
    }
  );

  return respuesta.data;
};

const limpiarReferenciaFhir = (tipo, id) => {
  if (!id) return null;
  if (String(id).includes('/')) return String(id);
  return `${tipo}/${id}`;
};

const crearScheduleFhir = async (agenda) => {
  const schedule = {
    resourceType: 'Schedule',
    active: true,

    actor: [
      {
        reference: `PractitionerRole/${agenda.fhir_rol_profesional_id}`,
        display: `${agenda.nombres} ${agenda.apellidos} - ${agenda.nombre_servicio}`
      }
    ],

    planningHorizon: {
      start: agenda.fecha_inicio,
      end: agenda.fecha_fin
    },

    comment: `Agenda mensual ${agenda.dias_semana || ''} ${agenda.hora_inicio || ''} - ${agenda.hora_fin || ''}`
  };

  const respuesta = await axios.post(
    `${URL_FHIR}/Schedule`,
    schedule,
    {
      headers: {
        'Content-Type': 'application/fhir+json'
      }
    }
  );

  return respuesta.data;
};



module.exports = {
  crearOrganizacionFhir,
  crearLocationFhir,
  crearPractitionerFhir,
  crearPractitionerRoleFhir,
  crearHealthcareServiceFhir,
  sincronizarCodeSystemEspecialidadesFhir,
  crearScheduleFhir
};