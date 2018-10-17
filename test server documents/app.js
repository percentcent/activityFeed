/*
var createError = require('http-errors');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

//var indexRouter = require('./routes/index');
//var usersRouter = require('./routes/users');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
*/

var express = require('express');
var app = express();
var url = require('url');
var path = require('path');

var bodyParser = require('body-parser');
var fs = require("fs");
app.use(express.static(__dirname));
app.use(express.json());
app.use(bodyParser.json());

var suggested_obj = JSON.parse(fs.readFileSync(path.join(__dirname,'public/jsonData/suggestedUsers.json')));
var search_obj = JSON.parse(fs.readFileSync(path.join(__dirname,'public/jsonData/searchUsers.json')));
var activityYou = JSON.parse(fs.readFileSync(path.join(__dirname,'public/jsonData/activityYou.json')));
var activityFollowing = JSON.parse(fs.readFileSync(path.join(__dirname,'public/jsonData/activityFollowing.json')));

app.listen(3004, function () {
  console.log('Example app listening on port 3004!');
});

app.post('/suggestedUsers',function(req,res){
	console.log(req.body)
	res.json(suggested_obj);
});

app.post('/followingSuggested',function(req,res){
	var success = {
		"status" : "success"
	}
	res.json(success);
	var request = req.body;
	console.log(request)
});

app.post('/searchUsers',function(req,res){
	var request = req.body;
	console.log(request)
	res.json(search_obj);
});

app.post('/activityYou',function(req,res){
	console.log(req.body)
	res.json(activityYou);
});

app.post('/activityFollowing',function(req,res){
	console.log(req.body)
	res.json(activityFollowing);
});

module.exports = app;
