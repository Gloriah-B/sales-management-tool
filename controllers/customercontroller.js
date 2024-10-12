const customer = require('../models/customer');

// Create a new customer
exports.createcustomer = async (req, res) => {
  try {
    const customer = new customer(req.body);
    await customer.save();
    res.status(201).json(customer);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get all customers
exports.getcustomers = async (req, res) => {
  try {
    const customers = await customer.find();
    res.json(customers);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get a customer by ID
exports.getcustomerById = async (req, res) => {
  try {
    const customer = await customer.findById(req.params.id);
    if (!customer) return res.status(404).json({ error: 'customer not found' });
    res.json(customer);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
