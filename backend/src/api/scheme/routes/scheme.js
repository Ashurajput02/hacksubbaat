'use strict';

/**
 * scheme router
 */

const { createCoreRouter } = require('@strapi/strapi').factories;

module.exports = createCoreRouter('api::scheme.scheme');
