'use strict';

/**
 * scheme service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::scheme.scheme');
