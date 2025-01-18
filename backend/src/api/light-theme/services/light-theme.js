'use strict';

/**
 * light-theme service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::light-theme.light-theme');
