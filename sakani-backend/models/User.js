const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  fullName: {
    type: String,
    required: [true, 'Full name is required.'],
  },
  email: {
    type: String,
    required: [true, 'Email is required.'],
    unique: true,
  },
  password: {
    type: String,
    required: [true, 'Password is required.'],
  },
});

const User = mongoose.model('User', userSchema);

module.exports = User;
