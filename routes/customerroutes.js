const express = require('express');
const router = express.Router();
const customercontroller = require('../controllers/customercontroller');

router.post('/', customercontroller.createcustomer);
router.get('/', customercontroller.getcustomers);
router.get('/:id', customercontroller.getcustomerById);

module.exports = router;
