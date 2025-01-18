'use strict';

/**
 * dark-theme service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::dark-theme.dark-theme');
