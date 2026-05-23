const mapLocation = (sede) => {

  return {

    resourceType: 'Location',

    id: sede.fhir_id || undefined,

    status:
	  sede.activo === false
		? 'inactive'
		: 'active',
		
	 mode: 'instance',

    name: sede.nombre,

    description:
      sede.descripcion || '',

    telecom: [

      {
        system: 'phone',
        value: sede.telefono || '',
        use: 'work'
      }

    ],

    address: {
        use: 'work',

        type: 'physical',

        text: sede.direccion || '',

        city: sede.ciudad || '',

        country: 'CO'
      },

    managingOrganization: {
      reference:
        `Organization/${sede.ips_fhir_id}`
    }

  };
};

module.exports = {
  mapLocation
};