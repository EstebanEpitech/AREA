var express = require('express');
var router = express.Router();
var dbClient = require('/db');

async function getUserId(token) {
  try {
    var resp = await dbClient.query('SELECT user_id FROM users WHERE token=$1', [token])
    if (resp.rows.length != 1) {
        return (null)
    } else
        return (resp.rows[0].user_id);
  } catch (err) {
      console.log(err)
      return (null)
  }
}

router.get('/signUp', function(req, res, next) {
  var checkQuery = "SELECT * FROM users WHERE username=$1"
  var insertQuery = "INSERT INTO users(username, password, token) values ($1, $2, $3)"
  var checkValues = [req.query.username]
  var insertValues = [req.query.username, req.query.password, token]
  dbClient.query(checkQuery, checkValues, function(err, result) {
    if (err) {
      console.log(err);
      sendError(res, "Internal error")
    } else {
      if (result.rows.length > 0) {
        sendError(res, "Username already taken.")
      } else {
        dbClient.query(insertQuery, insertValues, function(err, result) {
          if (err) {
            console.log(err);
            sendError(res, "Internal error")
          } else {
            res.json({"token": token})
          }
        });
      }
    }
  });
});

router.get('/signIn', function(req, res, next) {
  var checkQuery = "SELECT * FROM users WHERE username=$1"
  var checkValues = [req.query.username]
  dbClient.query(checkQuery, checkValues, function(err, result) {
    if (err) {
      console.log(err);
      sendError(res, "Internal error")
    } else {
      if (result.rows.length > 0 && result.rows[0].username == req.query.username && result.rows[0].password == req.query.password) {
        res.json({"token": result.rows[0].token});
      } else {
        sendError(res, "Wrong credentials.")
      }
    }
  });
});