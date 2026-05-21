const mapOrganization = (ips) => {

  return {

    resourceType: 'Organization',
	id: ips.fhir_id || undefined,
    active: ips.activo ?? true,

    identifier: [

      {
        use: 'official',

        system:
          'https://agendcore.com/fhir/identifier/ips-nit',

        value: ips.nit
      },

      {
        use: 'secondary',

        system:
          'https://agendcore.com/fhir/identifier/codigo-habilitacion',

        value: ips.codigo_habilitacion || ''
      }

    ],

    type: [
      {
        coding: [
          {
            system:
              'http://terminology.hl7.org/CodeSystem/organization-type',

            code: 'prov',

            display: 'Healthcare Provider'
          }
        ]
      }
    ],

    name: ips.nombre,

    alias: [
      ips.razon_social || ips.nombre
    ],

    telecom: [

      {
        system: 'phone',
        value: ips.telefono || '',
        use: 'work'
      },

      {
        system: 'email',
        value: ips.correo || '',
        use: 'work'
      }

    ],

    address: [

      {
        use: 'work',

        type: 'physical',

        text: ips.direccion || '',

        country: 'CO'
      }

    ]

  };
};

module.exports = {
  mapOrganization
};