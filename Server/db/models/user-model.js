const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcrypt');

const User = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    minlength: 5,
    trim: true,
    unique: true,
    validate: {
      validator: email => {
        return validator.isEmail(email);
      },
      message: 'This is not an email!'
    }
  },

  password: {
    type: String,
    required: true,
    trim: true
  },

  name: {
    type: String,
    required: true,
    minlength: 8,
    trim: true
  }
});

User.pre('save', function(next) {
  let user = this;

  if (!user.isModified('password')) {
    return next();
  }
  bcrypt.genSalt(10, (err, salt) => {
    if (err) {
      return Promise.reject(err);
    }

    bcrypt.hash(user.password, salt, (err, hashedPassword) => {
      user.password = hashedPassword;
      next();
    });
  });
});

module.exports = mongoose.model('User', User);
